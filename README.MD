# How to configuration GLPI 10 using Docker

This repository is intended to guide in a basic way to use GLPI in your environment using docker containers and images.

If you want to create your image, follow the steps below, otherwise clone this repository and run the command below in the project root folder

> `` docker compose up -d ``

* Note
> You must have installed docker on your local machine or server

### Features and Setps: 

* Docker Images utilization
* Download GLPI version
* Understanding files and Directories
* Create and build image php:apache-bookworm for GLPI
* Configuration Apache Document Root folder
* Create local folder for use to GLPI
* Configuration 
* Creating and building glpi docker image
* Running and test image
* Upload image for your docker hub repository
* Creating your docker compose file
* Running container with docker compose file

### 1. Docker Images utilization

1. php:apache-bookworm (required)
2. mariadb:10.7 (required)
3. phpmyadmin:latest (optional)

* About images:

> php:apache-bookworm: this container recieve php files to install GLPI

> mariadb:10.7: this container create and configure database

> phpmyadmin:latest (optional): for administration database

### 2. Download GLPI version

Download GLPI Version on  ([https://glpi-project.org/downloads](https://glpi-project.org/downloads/)).


### 3. Understanding files and Directories

* Diretories

> env - Folder containing environment variables for db container and phpmyadmin container.

> glpi - Folder that will receive the php files of the glpi version for building image.

> files - Folder containing config files for glpi and apache.

* Files

> Dockerfile.yml - contains all steps for creating and building our custom glpi docker image. 

> docker-compose.yml - contains all stpes for running our docker image and others services for running this container. 


### 3.  Create and build image php:apache-bookworm for GLPI


In this step we will need to create a file called Dockerfile.yml

> Create file on the root folder in your project.

This file will be responsible for creating the image and installing the extensions necessary to run GLPI.

A. Create folders:
- glpi
- files
- env

B. Download glpi version and extract files into the folder name:  "glpi"

C. 
 