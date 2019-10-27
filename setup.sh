#!/bin/bash
set -e
ORANGE=$'\e[0;33m'
GREEN=$'\e[0;32m'
NC=$'\e[0m'
default_data_path=$HOME/.devenv
default_sql_port=1433
default_seq_port=5341
env=.env
read -p "${ORANGE}Which host port do you want SQL to listen on?${NC} [$default_sql_port] " sql_port

if [ -z "$sql_port" ]; then
	sql_port=$default_sql_port
fi
 
read -p "${ORANGE}Which host port do you want Seq to listen on?${NC} [$default_seq_port] " seq_port

if [ -z "$seq_port" ]; then
	seq_port=$default_seq_port
fi

read -p "${ORANGE}Where do you want data to be stored?${NC} [$default_data_path] " data_path

if [ "$data_path" -ef / ]; then
	echo -e "${ORANGE}Sorry, thats a bad idea${NC}"
	exit 1
fi

read -s -p "${ORANGE}Enter the SA password for the database:${NC} [At least 8 chars] " sql_pass

if [ ${#sql_pass} -le 8 ]; then 
	echo -e "${ORANGE}Please use a password with at least 8 characters${NC}"
	exit 1
fi

if [ -z "$data_path" ]; then
	data_path=$default_data_path
	sql_data_path="$default_data_path/sql"
	seq_data_path="$default_data_path/seq"
else 
	sql_data_path="$data_path/sql"
	seq_data_path="$data_path/seq"
fi

mkdir -p $sql_data_path
mkdir -p $seq_data_path

if [ -f "$env" ]; then
	rm $env
fi

printf "SA_PASSWORD=$sql_pass\nACCEPT_EULA=true\nMSSQL_PID=Developer" > ./.env 

echo "creating .config"
rm -f ./.config
echo "$data_path" > .config

echo -e "${ORANGE}Configuring scripts...${NC}"
yes | cp -f ./docker-compose-template.yml ./docker-compose.yml
sed -i -e "s+#{sql_data_path}+$sql_data_path+g" ./docker-compose.yml
sed -i -e "s+#{seq_data_path}+$seq_data_path+g" ./docker-compose.yml
sed -i -e "s/#{sql_port}/$sql_port/g" ./docker-compose.yml
sed -i -e "s/#{seq_port}/$seq_port/g" ./docker-compose.yml

# echo -e "${ORANGE}Building containers...${NC}"
# sudo docker build --tag=mssql-fts-ha . 
echo -e "${GREEN}Finished. Do you want me bring it all up?${NC} [yes/no]"
read continue
if [ "$continue" == "yes" ]; then
	sudo docker-compose up -d
	sudo docker stats
else
	echo -e "${GREEN}No probs, you can start it all up yourself with start.sh${NC}"
fi

exit 0