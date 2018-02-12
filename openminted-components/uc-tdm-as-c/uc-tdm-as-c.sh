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

ID="org.bibliome.alvisnlp.modules.uc-tdm-as-c"
if [ "$2" == "org.bibliome.alvisnlp.modules.uc-tdm-as-c" ]; then
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

set -o xtrace

$COMMAND -verbose -J "-Xmx30g" \
        -alias $INPUT $INPUT_VALUE \
	-entity outdir $OUTPUT_VALUE \
    	 plans/tag_pubmed.plan

