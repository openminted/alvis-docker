# alvis-br-train

This component is used to train a SVM model for binary relation extration on text documents. It is based on TEES and it uses GeniaTagger. It is defined using alvisnlp plans (see the plans into the [test-data/plans folder](test-data/plans)).

## test-data
the test-data to run this component are into the `test-data` folder
 
* corpus is composed of
	* train set
	* dev set
	* test set

* model is the folder where the produced TEES SVM  model is stored

## Run in command-line

From the folder contained the README run the following command. You're supposed to have docker installed.
```
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/alvis-br-train \
alvisnlp org.bibliome.alvisnlp.modules.tees.alvis-br-train \
--input /alvisnlp/data/corpus \
--output /alvisnlp/data/models \
--param:train=/alvisnlp/data/corpus/train \
--param:dev=/alvisnlp/data/corpus/dev \
--param:test=/alvisnlp/data/corpus/test \
--param:modelTargetDir=/alvisnlp/data/models
```

# OpenMinTeD metadata

The Openminted metadata records are described in the following XML files
* [OMTD-SHARE records with V2.0.1](alvis-br-train.metadata.omtd.v2.0.1)
* [OMTD-SHARE records with V3.0.0](alvis-br-train.metadata.omtd.v3.0.0]

# re-build the docker image
You can re-build the docker image from the dockerfile by running the following command from the folder contained the README
```
docker build . -t bibliome/alvis-br-train -f Dockerfile.alvis-br-train
```
