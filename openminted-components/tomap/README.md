# tomap
Performs segmentation, POS-tagging, lemmatization, NER (habitat). 

## Test data
The test data to run this component are into the `test-data` folder
 
* corpus is composed of xmi files

* output is the folder where the produced files are stored

## Run from the command line

From the folder contained the README, run the following command. You're supposed to have docker installed.
> Note that, OpenMinTeD will generate this command from the metadata records and the input/output/parameter values provided by the user when (s)he runs the component. 

```
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/tomap \
alvisnlp /alvisnlp/OMTD_ToMap.plan \
--input /alvisnlp/data/corpus \
--output /alvisnlp/data/output \
```

# OpenMinTeD metadata

The Openminted metadata records are described in the following XML files based on [OMTD-SHARE](https://openminted.github.io/releases/omtd-share/)
* [OMTD-SHARE records](tomap.xml)

# re-build the docker image
You can re-build the docker image from the dockerfile by running the following command from the folder contained the README
```
docker build . -t bibliome/tomap -f Dockerfile.tomap
```
