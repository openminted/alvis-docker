# alvis-br-train

This component is used to train a SVM model for binary relation extration. It is based on TEES and it uses GeniaTagger. It is defined from alvis plans (see plans into the [test-data/plans folder](test-data/plans)

## Run

The command to run this component in command line is the following


# test-data
the test-data to run this component are into the `test-data` folder
 
* corpus is composed of
	* train set
	* dev set
	* test set

* model is the TEST SVM  model produced

## Run command in command line

From the folder contained the README run the following command
```sh
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/alvis-br-train \ 
train /alvisnlp/data/corpus/train \
dev /alvisnlp/data/corpus/dev \
test /alvisnlp/data/corpus/test \
model /alvisnlp/data/models
```

# OpenMinTeD metadata

The Openminted metadata records for this component are described in this [file](alvis-br-train.metadata.omtd)
