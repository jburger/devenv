#!/bin/sh
set -e
GREEN=$'\e[0;32m'
NC=$'\e[0m'
echo -e "${GREEN}Bringing up the environment${NC}"
docker-compose up -d
docker stats
echo -e "${GREEN}Done!${NC}"