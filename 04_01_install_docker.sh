#!/bin/bash

## 04_01_install_docker on ubuntu

############### Installing DOCKER ######################

# Try to install the DOCKER:

sudo apt install -y docker.io
### >> Pay attention for every "Do you want to continue? [Y/n]".
### Accept "y" if it occurs. Try to enable silent mode of installation again...

sudo docker

sudo docker --version

# If something is missing or not, next let's try to use advices of Brian Hogan at his article:
# on https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

# Updating the list of packages:

    sudo apt update
### >> enter the password

# Installing some prerequisite packages which let apt use packages over HTTPS:

    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Adding the GPG key for the official Docker repository to your system:

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Adding the Docker repository to APT sources:

    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# Updating the list of packages database with Docker from the newly added repo:

    sudo apt update

# Making sure we are about to install from the Docker repo (instead of the default Ubuntu repo):

    apt-cache policy docker-ce

# Installing Docker:

    sudo apt install -y docker-ce

# Checking: Docker should now be installed, the daemon started, and the process enabled to start on boot. Check that it's running:

    sudo systemctl status docker

############### Executing the DOCKER Command Without Sudo ######################

    docker run --help

# If you want to avoid typing "sudo" whenever you run the docker command, add your username to the docker group:

    echo ${USER}
    sudo usermod -aG docker ${USER}

# Apllying the new group membership. Type the following:

    su - ${USER}
### >> enter the password

# Checking the confirmation that the user is now added to the docker group by typing:

    id -nG

# Sample output:   kris adm cdrom sudo dip plugdev lpadmin sambashare docker


## (Optional) If you need to add a user to the docker group that you're not logged in as, declare that username explicitly using:
##   sudo usermod -aG docker username

############### Using the DOCKER Command ######################

## The syntax is "a chain of options and commands followed by arguments". Usage:
##    docker [OPTIONS] COMMAND [arguments]

# Viewing the version:

    docker --version

# Viewing all available subcommands:

    docker

# Runing 'docker COMMAND --help' for more information on a specific command:

    docker kill --help

# Viewing system-wide information about Docker. We can use:

    docker info

############### Working with DOCKER Images ######################

# Checking if we can access and download images from Docker Hub. We can type:

    docker run hello-world

# We can search for images available on Docker Hub by typing:

    docker search ubuntu

# Executing the following command to download the official "ubuntu" image to our machine:

    docker pull ubuntu

# Viewing the images that have been downloaded to our machine. We can type:

    docker images

############### Running a DOCKER Container ######################

# The "hello-world" container is an example container, which runs and exits after emitting a test message.
# Containers can be much more useful than that, and they can be interactive, as a virtual machines.

# As an second example, let's run a container using the latest official image of "Ubuntu".
# The combination of the -i and -t switches gives you interactive shell access into the container. We can use "bash":

    docker run -it ubuntu bash

# Your command prompt should change to reflect the fact that you're now working inside the container:

## OUTPUT:

#kris@gandalf1:~$     docker run -it ubuntu bash
#root@5495e623ad66:/#

# Pay attention! Note the container ID in the command prompt: it is 5495e623ad66.
# You'll need that container ID later to identify the container when you want to remove it.


# Now you can run any command inside the container:

    apt update

# Installing any application in it. Let's install the Node.js:

    apt install -y nodejs

# It installs Node.js in the container from the official Ubuntu repository.
# "Do you want to continue? [Y/n]"
### >> type "y" + ENTER
# Verify that Node.js is installed to see the version number:

    node -v

# Any changes you make inside the container only apply to that container.
# To exit the container, type "exit" at the prompt.

    exit

############### Managing DOCKER Containers ######################

# Viewing all containers: active and inactive. Type with the "-a" switch:

    docker ps -a

# Viewing the latest container you created:

    docker ps -l

