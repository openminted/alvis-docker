# uc-tdm-AS-E
recognizes phenotypes, genes, markers, and wheat-related taxa. It categorizes the phenotypes with the Wheat Trait Ontology. It is the workflow for the OpenMinTeD AS-E use case.

## test-data
The test-data folder contains data to run the workflow. More specifically:
* corpus/ contains a text sample that can be used as input.
* output/ is where the output of the workflow will be created.

## Run in command-line

To run the workflow (from the folder containing the README):

```
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/uc-tdm-as-e \
alvisnlp org.bibliome.alvisnlp.modules.uc-tmd-as-e \
--input /alvisnlp/data/corpus/pubmed_result_2.xml \
--output entities.txt  \
--param:readhtml=/alvisnlp/data/corpus/fulltext/html \
--param:readWoK=/alvisnlp/data/corpus/corpus2000_12012017.txt \
--param:exportDocument=sectionsWOK+PubMed.txt \
--param:output_fixed_relations=relationsgroup.txt \
--param:outputDir=/alvisnlp/data/output/
```

<!--- ```sudo docker run -i --rm -v $PWD/test-data/:/as-e/data as-e-docker alvisnlp -verbose -J "-Xmx30g" 
-alias readPubMed /as-e/data/alvisir2_corpus/pubmed_result-2.xml \
-alias readhtml /as-e/data/alvisir2_corpus/fulltext/html \
-alias readWoK /as-e/data/alvisir2_corpus/corpus2000_12012017.txt \
-alias exportDocument /as-e/data/output/sectionsWOK+PubMed.txt \
-alias output_fixed_relations /as-e/data/output/relationsgroup.txt \
-alias output_fixed_entities /as-e/data/output/entities.txt \
/as-e/plan/entities.plan
``` --->

## OpenMinteD metadata

The OpenMinteD metadata are recorded in the following [XML file](uc-tdm-as-d.omtd.v3.0.0)

## Re-build the docker image

```docker build . -t bibliome/uc-tdm-as-e -f Dockerfile.uc-tdm-as-e```
