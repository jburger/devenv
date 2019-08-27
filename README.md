# Docker dev environment

## What you get

- a container running SQL server with full text search, persisting to your host folders, to a location of your choosing
- a Seq logging instance also persisting to your hosts folders
- a set of convenience scripts to spin up and tear down this environment

Please review these scripts before running them. You'll need to mark them as executable too:

```sh
git clone https://github.com/<repo> 
cd /your/repo/dir
chmod +x *.sh
```

### Software Pre-requisites
These are bash scripts that have been tested on Ubuntu 18.04

These scripts also assume you have the following installed
- [Docker CE](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-engine---community-1)
- [docker-compose](https://docs.docker.com/compose/install/) 

### Workflow
There are a number of tools in this repo to speed up your workflow

#### Setup
Run `setup.sh` to create the containers and get your ports & data directories in order, it will also build the correct containers and configure a script to bring everything up. You can optionally start from here, just follow the prompts

#### Run
Run `start.sh` to start the environment in the background, it will bring up a status page to monitor the environment. You can cancel back out to a shell if you like and keep everything running by using `CTRL+C` 

#### Stop
If you want to halt your environment, just run `stop.sh`

#### Start over
To blow it all away, run `clean.sh`. This will halt all containers, remove the containers that it created, **AND DELETE THE DATA IN YOUR DATA DIRECTORIES** it doesn't delete the container images by default, leaving those for next time. 
