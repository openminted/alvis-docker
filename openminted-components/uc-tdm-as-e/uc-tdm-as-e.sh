#!/bin/bash

# Copyright 2016 Institut National de la Recherche Agronomique
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#         http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


#docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
#bibliome/uc-tdm-as-e \
#alvisnlp org.bibliome.alvisnlp.modules.uc-tmd-as-e \
#--input /alvisnlp/data/corpus/pubmed_result-2.xml \
#--output /alvisnlp/data/output/entities.txt  \
#--param:readhtml=/alvisnlp/data/corpus/fulltext/html \
#--param:readWoK=/alvisnlp/data/corpus/corpus2000_12012017.txt \
#--param:exportDocument=/alvisnlp/data/output/sectionsWOK+PubMed.txt \
#--param:output-fixed-relations=/alvisnlp/data/output/relationsgroup.txt
#```

COMMAND="alvisnlp"
if [ "$1" == "alvisnlp" ]; then
    COMMAND=$1
else
    echo "Bad command"
fi

ID="org.bibliome.alvisnlp.modules.uc-tmd-as-e"
if [ "$2" == "org.bibliome.alvisnlp.modules.uc-tmd-as-e" ]; then
     ID=$2
else
     echo "Bad id"
fi

# parameter not used here
INPUT=$(echo $3 | cut -f3 -d-)
if [ "$3" == "input" ]; then
    echo "Good command input"
else
    echo "Bad command input"
fi
INPUT_VALUE=$4

# parameter not used here
OUTPUT=$(echo $5 | cut -f3 -d-) 
if [ "$5" == "output" ]; then
   echo "Good command output"
else
    echo "Bad command output"
fi
OUTPUT_VALUE=$6

# set parameters

parNameString=$(echo $7 | cut -f1 -d=)
readhtml_VALUE=$(echo $7 | cut -f2 -d=)
readhtml=$(echo $parNameString | cut -f2 -d:)

parNameString=$(echo $8 | cut -f1 -d=)
readWoK_VALUE=$(echo $8 | cut -f2 -d=)
readWoK=$(echo $parNameString | cut -f2 -d:)

parNameString=$(echo $9 | cut -f1 -d=)
exportDocument_VALUE=$(echo $9 | cut -f2 -d=)
exportDocument=$(echo $parNameString | cut -f2 -d:)

parNameString=$(echo $10 | cut -f1 -d=)
output-fixed-relations_VALUE=$(echo $10 | cut -f2 -d=)
output-fixed-relations=$(echo $parNameString | cut -f2 -d:)


#<!--- ```sudo docker run -i --rm -v $PWD/test-data/:/as-e/data as-e-docker alvisnlp -verbose -J "-Xmx30g" 
#-alias readPubMed /as-e/data/alvisir2_corpus/pubmed_result-2.xml \
#-alias readhtml /as-e/data/alvisir2_corpus/fulltext/html \
#-alias readWoK /as-e/data/alvisir2_corpus/corpus2000_12012017.txt \
#-alias exportDocument /as-e/data/output/sectionsWOK+PubMed.txt \
#-alias output-fixed-relations /as-e/data/output/relationsgroup.txt \
#-alias output-fixed-entities /as-e/data/output/entities.txt \
#/as-e/plan/entities.plan
#``` --->
$COMMAND -verbose -J "-Xmx30g" \
        -alias readPubMed $INPUT_VALUE \
	-alias output-fixed-entities $OUTPUT_VALUE \
	-alias $readhtml $readhtml_VALUE \
    	-alias $readWoK  $readWoK_VALUE \
	-alias $exportDocument $exportDocument_VALUE \
	-alias $output-fixed-relations $output-fixed-relations_VALUE \
	/as-e/plan/entities.plan
