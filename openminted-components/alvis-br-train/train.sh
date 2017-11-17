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

ID="train"
if [ "$2" == "alvis-br-train" ]; then
     ID=$2
else
     echo "Bad id"
fi

# parameter not used here
INPUT="input"
if [ "$3" == "input" ]; then
    INPUT=$3
else
    echo "Bad command input"
fi

# parameter not used here
OUTPUT="output" 
if [ "$4" == "output" ]; then
    OUTPUT=$4
else
    echo "Bad command output"
fi

# set parameters

parNameString=$(echo $5 | cut -f1 -d=)
TRAIN_PATH_VALUE=$(echo $5 | cut -f2 -d=)
TRAIN=$(echo $parNameString | cut -f2 -d:)

parNameString=$(echo $6 | cut -f1 -d=)
DEV_PATH_VALUE=$(echo $6 | cut -f2 -d=)
DEV=$(echo $parNameString | cut -f2 -d:)

parNameString=$(echo $7 | cut -f1 -d=)
TEST_PATH_VALUE=$(echo $7 | cut -f2 -d=)
TEST=$(echo $parNameString | cut -f2 -d:)

parNameString=$(echo $8 | cut -f1 -d=)
MODEL_PATH_VALUE=$(echo $8 | cut -f2 -d=)
MODEL=$(echo $parNameString | cut -f2 -d:)


echo "-param $TRAIN textDir $TRAIN_PATH_VALUE -param $DEV textDir $DEV_PATH_VALUE  -param $TEST textDir $TEST_PATH_VALUE  -param TEESTrain $MODEL $MODEL_PATH_VALUE  /alvisnlp/plans/train.plan"

$COMMAND  -param $TRAIN textDir $TRAIN_PATH_VALUE \
    	-param $DEV textDir $DEV_PATH_VALUE \
    	-param $TEST textDir $TEST_PATH_VALUE \
    	-param TEESTrain $MODEL $MODEL_PATH_VALUE \
    	/alvisnlp/plans/train.plan

