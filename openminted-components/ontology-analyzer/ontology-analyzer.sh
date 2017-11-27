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

COMMAND="alvisnlp"
if [ "$1" == "alvisnlp" ]; then
    COMMAND=$1
else
    echo "Bad command"
fi

ID="org.bibliome.alvisnlp.modules.phenotype-ontology-analyzer"
if [ "$2" == "org.bibliome.alvisnlp.modules.phenotype-ontology-analyzer" ]; then
     ID=$2
else
     echo "Bad id"
fi

# parameter used here
INPUT=$(echo $3 | cut -f3 -d-)
if [ "$3" == "input" ]; then
    echo "Good command input"
else
    echo "Bad command input"
fi
INPUT_VALUE=$4

# parameter used here
OUTPUT=$(echo $5 | cut -f3 -d-) 
if [ "$5" == "output" ]; then
   echo "Good command output"
else
    echo "Bad command output"
fi
OUTPUT_VALUE=$6

#  parameters not used here

#parNameString=$(echo $7 | cut -f1 -d=)
#TRAIN_PATH_VALUE=$(echo $7 | cut -f2 -d=)
#TRAIN=$(echo $parNameString | cut -f2 -d:)

#parNameString=$(echo $8 | cut -f1 -d=)
#DEV_PATH_VALUE=$(echo $8 | cut -f2 -d=)
#DEV=$(echo $parNameString | cut -f2 -d:)

#parNameString=$(echo $9 | cut -f1 -d=)
#TEST_PATH_VALUE=$(echo $9 | cut -f2 -d=)
#TEST=$(echo $parNameString | cut -f2 -d:)

#parNameString=$(echo $10 | cut -f1 -d=)
#MODEL_PATH_VALUE=$(echo $10 | cut -f2 -d=)
#MODEL=$(echo $parNameString | cut -f2 -d:)


#echo "alvisnlp -alias input resources/OntoBiotope-Phenotype.obo -alias output output/OntoBiotope-Phenotype.tomap plans/phenotype_ontology_analyzer.plan"

$COMMAND -verbose \
        -alias $INPUT  $INPUT_VALUE \
	-alias $OUTPUT $OUTPUT_VALUE \
    	/as-c/plans/phenotype_ontology_analyzer.plan

