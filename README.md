# Alvis Docker
Dockerizing Alvis and its components

A fist docker image for testing [alvisnlp](https://github.com/Bibliome/alvisnlp) engine is present into docker hub

`docker pull mandiayba/alvisengine`

If all work fine, you will display the help

`docker run mandiayba/alvisengine alvisnlp -help`

list the modules supported by alvis

`docker run mandiayba/alvisengine alvisnlp -supportedModules`
