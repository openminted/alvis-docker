# Alvis Docker
Dockerizing Alvis and its components

A fist docker image for testing [alvisnlp](https://github.com/Bibliome/alvisnlp) engine is present into docker hub

`docker pull mandiayba/alvisengine`

If all work fine, you will get help

`docker run alvisengine alvisnlp -help`

list the alvis modules

`docker run alvisengine alvisnlp -supportedModules`
