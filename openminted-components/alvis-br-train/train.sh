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
    COMMAND = $1
else
    echo "Bad command"
fi

# parameter not used here
INPUT="input"
if [ "$2" == "input" ]; then
    INPUT = $2
else
    echo "Bad command input"
fi

# parameter not used here
INPUT="output" 
if [ "$3" == "output" ]; then
    OUTPUT = $3
else
    echo "Bad command output"
fi

TRAIN = $4
TRAIN_PATH_VALUE = $5

DEV = $6
DEV_PATH_VALUE = $7

TEST = $8
TEST_PATH_VALUE = $9

MODEL = $10
MODEL_PATH_VALUE = $11


$COMMAND  -param $TRAIN extDir $TRAIN_PATH_VALUE \
    	-param $DEV textDir $DEV_PATH_VALUE \
    	-param $TEST textDir $TEST_PATH_VALUE \
    	-param TEESTrain $MODEL $MODEL_PATH_VALUE \
    	/alvisnlp/plans/train.plan

