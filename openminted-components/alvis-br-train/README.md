# alvis-br-train

This component is used to train a SVM model for binary relation extration on text documents. It is based on TEES and it uses GeniaTagger. It is defined using alvisnlp plans (see the plans into the [test-data/plans folder](test-data/plans)).

## test-data
the test-data to run this component are into the `test-data` folder
 
* corpus is composed of
	* train set
	* dev set
	* test set

* model is the TEST SVM  model produced

## Run in command-line

From the folder contained the README run the following command. You're supposed to have docker installed.
```
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/alvis-br-train \ 
alvisnlp \
input /alvisnlp/data/corpus
output /alvisnlp/data/models
train /alvisnlp/data/corpus/train \
dev /alvisnlp/data/corpus/dev \
test /alvisnlp/data/corpus/test \
model /alvisnlp/data/models
```

# OpenMinTeD metadata

The Openminted metadata records are described into the following [XML file](alvis-br-train.metadata.omtd)

# re-build the docker image
You can re-build the docker image from the dockerfile by running the following command from the folder contained the README
```
docker build . -t bibliome/alvis-br-train -f Dockerfile.alvis-br-train
```
