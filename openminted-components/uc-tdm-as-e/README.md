# Arabidopsis Gene Regulation Extractor
Recognizes Gene, Protein and RNA of Arabidopsis thaliana. It normalizes them with Gene Locus and identifies interacts_with relationships between Gene and Protein. It encapsulates the workflow for the OpenMinTeD AS-E use case.

## test-data
The test-data folder contains data to run the workflow. More specifically:
* corpus/ contains the input data (i.g., pubmed corpus)
    * pubmed_result_2.xml is an input corpus from PubMed abstract.
    * fulltext/html is a corpus from any html file.
    * corpus2000_12012017.txt is a corpus from Web Of Knowledge website.
* output/ is where the output of the will be strored.
    * /alvisnlp/data/output/ is the output directory
      * entities.txt is the main output file with Gene, Protein and RNA entities annotations
      * savedrecs.txt is an output parameter to export metadata of the documents
      * relationsgroup.txt is an output file with relations between entities annotations

## Run in command-line
To run the workflow (from the folder containing the README):
```
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/uc-tdm-as-e \
alvisnlp org.bibliome.alvisnlp.modules.uc-tmd-as-e \
--input /alvisnlp/data/corpus/pubmed_result_2.xml \
--output /alvisnlp/data/output  \
--param:readhtml=/alvisnlp/data/corpus/fulltext/html \
--param:readWoK=/alvisnlp/data/corpus/corpus2000_12012017.txt
```

<!---
In a general way , the OMTD command for this component will look like this:
docker run -i --rm -v $PWD/test-data:[FOLDER/WHERE/TO/MOUNT] -a stderr \
bibliome/uc-tdm-as-e \
alvisnlp org.bibliome.alvisnlp.modules.uc-tmd-as-e \
--input [FOLDER/WHERE/TO/MOUNT]/corpus/pubmed_result_2.xml \
--output entities.txt  \
--param:readhtml=[FOLDER/TO/MOUNT]/corpus/fulltext/html \
--param:readWoK=[FOLDER/TO/MOUNT]/corpus/corpus2000_12012017.txt \
--param:exportDocument=sectionsWOK+PubMed.txt \
--param:output_fixed_relations=relationsgroup.txt \
--param:outputDir=[FOLDER/TO/MOUNT]/output/
```
--->

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

The OpenMinteD metadata are recorded in the following [XML file](uc-tdm-as-e.omtd.v3.0.2.xml)

## Re-build the docker image

```docker build . -t bibliome/uc-tdm-as-e -f Dockerfile.uc-tdm-as-e```
