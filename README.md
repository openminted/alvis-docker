# Alvis Docker
Dockerizing Alvis and its components

## Use the docker image

A fist docker image for testing the [alvisnlp](https://github.com/Bibliome/alvisnlp) engine is present into the Docker Hub

`docker pull mandiayba/alvisengine`

display the alvis help

`docker run mandiayba/alvisengine alvisnlp -help`

list the modules supported by alvis

`docker run mandiayba/alvisengine alvisnlp -supportedModules`

display the doc of the module named `SimpleProjector`

`docker run mandiayba/alvisengine alvisnlp -moduleDoc SimpleProjector`

## The docker image creation

### Automatically clone and install alvisnlp with Dockerfile


### Install external program in an interactive mode 

