# Habitat-Phenotype Relation Extractor for Microbes

Recognizes microorganism taxa, their habitats and their phenotypes. It categorizes them with ontologies (NCBI taxonomy and OntoBiotope ontology). It identifies lives-in relationships between taxa and habitats, and exhibits relationships between taxa and phenotypes. It is the workflow for the OpenMinTeD AS-C use case.

## test-data
The test-data folder contains data to run the workflow. More specifically:
* corpus/ contains a xmi file that can be used as input.
* output/ is where the output of the workflow will be created.

## Run in command-line

To run the workflow (from the folder containing the README):

```
docker run -m 12g -i -v $PWD/test-data:/alvisnlp/data \
bibliome/uc-tdm-as-c \ 
alvisnlp -verbose \
/as-c/plans/tag_xmi.plan \
--input /alvisnlp/data/corpus \
--output /alvisnlp/data/output
```

<!--- ```
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/uc-tdm-as-c \
alvisnlp org.bibliome.alvisnlp.modules.uc-tmd-as-c \
--input /alvisnlp/data/corpus/test.xml \
--output /alvisnlp/data/output
```
--->

<!--- ```docker run -i --rm -v $PWD/test-data/:/as-d/data ldeleger/uc-tdm-as-d-docker alvisnlp -J "-Xmx30g" -entity inputfile /as-d/data/corpus/test.txt -entity outdir /as-d/data/output plans/tag_WoS_abstracts.plan``` --->

## OpenMinteD metadata

The OpenMinteD metadata are recorded in the following [XML file](habitat-phenotype-relation-extractor-for-microbes.xml)

## Re-build the docker image

```docker build . -t bibliome/uc-tdm-as-c -f Dockerfile.uc-tdm-as-c```
