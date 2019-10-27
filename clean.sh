#!/bin/bash
set -e
data_path=$(<./.config)
ORANGE=$'\e[0;33m'
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

read -p "${RED}This will stop and delete the SQL and SEQ containers and DELETE EVERYTHING from $data_path are you sure?${NC} [yes/no] " answer
if [ "$answer" != "yes" ]; then
	exit 1
fi
echo -e "${ORANGE}Stopping containers...${NC}"
sudo docker-compose down

if [ "$data_path" -ef / ] || [ -z "$data_path" ]; then
	echo "The config file didn't look right to me, please try and re-run setup.sh"
	exit 1
fi
echo -e "${GREEN}OK... Deleting $data_path!${GREEN}"
sudo rm -rf $data_path

echo -e "${GREEN}All cleaned up!${NC}"
