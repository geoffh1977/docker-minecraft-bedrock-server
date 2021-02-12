# Minecraft Bedrock Server Image #

<p align="center">
<img src="https://github.com/geoffh1977/docker-minecraft-bedrock-server/raw/main/images/minecraft.jpg" width="50%" height="50%" text-align="center">
</p>

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/geoffh1977/minecraft-bedrock-server?style=plastic) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/geoffh1977/minecraft-bedrock-server?style=plastic) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/geoffh1977/minecraft-bedrock-server/latest?style=plastic) ![Docker Pulls](https://img.shields.io/docker/pulls/geoffh1977/minecraft-bedrock-server?style=plastic) ![Circle CI Status](https://img.shields.io/circleci/build/github/geoffh1977/docker-minecraft-bedrock-server/main?label=cirecleci&style=plastic&token=a61a99b1c491ddd861ece08fcd224a6298b8650d)


## Description ##
This docker image provides the latest version of the Minecraft Bedrock Server inside a docker container image. The Minecraft Bedrock build is checked on a nightly basis and the image will be automatically be updated as new versions are released.

## Quickstart ##
To Start The Server:

`docker run --rm --name Minecraft -p 19132:19132/udp geoffh1977/minecraft-bedrock-server`

This will start a copy of the latest Minecraft Bedrock Server image. It is important to note that no worlds/config will be saved persistently by running it this way.

## Data Persistence ##
In order to use data persistnce, the following criteria must be met:

* A directory for the config path and the worlds path.
* The directory needs the UID/GID of 1000:1000 as the minecraft server is set to a non-root user.
* The config path should contain a server.properties and/or permissions.json file at a minimum.

In order to maintain data persistence across service restarts, you can mount a volume or host share on the "/bedrock-server/config" and the "/bedrock-server/worlds" path within the container.

`docker run --rm --name Minecraft -p 19132:19132/udp -v <CONFIG_PATH>:/bedrock-server/config -v <WORLDS_PATH>:/bedrock-server/worlds geoffh1977/minecraft-bedrock-server`

## Tags And Versioning ###

The _latest_ tag is supported as well as the major version numbers for each minecraft server released. Along with these are all the minor version tags. For example:

* *geoffh1977/minecraft-bedrock-server:latest* -- will release the absolute latest build created.
* *geoffh1977/minecraft-bedrock-server:1.16* -- will release the latest version of the 1.16 build series (e.g. 1.16.203.1 as of this writing)
* *geoffh1977/minecraft-bedrock-server:1.16.203.1* -- will lock the image to the version _1.16.203.1_
* *geoffh1977/minecraft-bedrock-server:1.15* -- would release the latest version of the 1.15 build series.

The major versions will always be available now and going forward as this is working in an automated fashion

### Getting In Contact ###
If you find any issues with this container or want to recommend some improvements, fell free to get in contact with me or submit pull requests on github. Depending on the popularity of the image, I will consider adding more funcationality in the future as time allows.
