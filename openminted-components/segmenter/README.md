# segmenter
Performs segmentation, detects sentence boundaries and creates one annotation for each sentence.

## Test data
The test data to run this component are into the `test-data` folder
 
* corpus is composed of xmi files

* output is the folder where the produced files are stored

## Run from the command line

From the folder contained the README, run the following command. You're supposed to have docker installed.
> Note that, OpenMinTeD will generate this command from the metadata records and the input/output/parameter values provided by the user when (s)he runs the component. 

```
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/segmenter \
alvisnlp alvis.segmentation.plan \
--input /alvisnlp/data/corpus \
--output /alvisnlp/data/output \
```

# OpenMinTeD metadata

The Openminted metadata records are described in the following XML files based on [OMTD-SHARE](https://openminted.github.io/releases/omtd-share/)
* [OMTD-SHARE records V3.0.0](segmenter.metadata.omtd.v3.0.2.xml)

# re-build the docker image
You can re-build the docker image from the dockerfile by running the following command from the folder contained the README
```
docker build . -t bibliome/segmenter -f Dockerfile.segmenter
```
