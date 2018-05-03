# Wheat Phenotypic Information Extractor

Recognizes phenotypes, genes, markers, and wheat-related taxa. It categorizes the phenotypes with the Wheat Trait Ontology. It encapsulates the workflow for the OpenMinTeD AS-D use case.

## test-data
The test-data folder contains data to run the workflow. More specifically:
* corpus/ contains xmi files that can be used as input.
* output/ is where the output of the workflow will be created.

## Run in command-line

To run the workflow (from the folder containing the README):


<!---```
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/uc-tdm-as-d \
alvisnlp org.bibliome.alvisnlp.modules.uc-tmd-as-d \
--input /alvisnlp/data/corpus/test.xml \
--output /alvisnlp/data/output
```
--->

```
docker run -i -v $PWD/test-data:/alvisnlp/data \
bibliome/uc-tdm-as-d \ 
alvisnlp -verbose /as-d/plans/tag_xmi.plan  \
--input /alvisnlp/data/corpus/xmi \
--output /alvisnlp/data/output
```


<!--- ```docker run -i --rm -v $PWD/test-data/:/as-d/data ldeleger/uc-tdm-as-d-docker alvisnlp -J "-Xmx30g" -entity inputfile /as-d/data/corpus/test.txt -entity outdir /as-d/data/output plans/tag_WoS_abstracts.plan``` --->

## OpenMinteD metadata

The OpenMinteD metadata are recorded in the following [XML file](wheat-phenotypic-information-extractor.xml)

## Re-build the docker image

```docker build . -t bibliome/uc-tdm-as-d -f Dockerfile.uc-tdm-as-d```
