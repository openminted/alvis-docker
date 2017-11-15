# alvis-br-train

The is component is used to train TEES SVM model for binary relations extraction

## Run

The command to run this component in command line is the following


# test-data
the test-data to run this component are into the `test-data` folder
 
** corpus is composed of
*** train set
*** dev set
*** test set

** model is the TEST SVM  model produced

## Run command in command line
```
docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data -a stderr \
alvis-br-train \ 
train /opt/alvisnlp/data/corpus/train \
dev /opt/alvisnlp/data/corpus/dev \
test /opt/alvisnlp/data/corpus/test \
model /opt/alvisnlp/data/models
```

# OpenMinTeD metadata

The Openminted metadata records for this component are described in this [file](alvis-br-train.metadata.omtd)