#!/bin/bash
set -e
GREEN=$'\e[0;32m'
NC=$'\e[0m'
echo -e "${GREEN}Bringing up the environment${NC}"
sudo docker-compose up -d
sudo docker stats
echo -e "${GREEN}Done!${NC}"
