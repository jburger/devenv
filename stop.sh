#!/bin/sh
GREEN=$'\e[0;32m'
NC=$'\e[0m'
echo -e "${GREEN}Taking down the environment${NC}"
sudo docker-compose down
echo -e "${GREEN}Done!${NC}"