# Alvis Docker
Dockerizing Alvis and its components

A fist docker image for testing the [alvisnlp](https://github.com/Bibliome/alvisnlp) engine is present into the Docker Hub

`docker pull mandiayba/alvisengine`

display the alvis help
`docker run mandiayba/alvisengine alvisnlp -help`

list the modules supported by alvis
`docker run mandiayba/alvisengine alvisnlp -supportedModules`
