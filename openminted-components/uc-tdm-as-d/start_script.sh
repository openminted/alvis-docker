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

command=$1
id=$2
inDir=""
outDir=""
alvisParams=""

# Parse arguments and fill.
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --input)
    inDir="$2"
    shift # past argument
    shift # past value
    ;;
    --output)
    outDir="$2"
    shift # past argument
    shift # past value
    ;;
    --param*)
    parString=$(echo $1 | cut -f1 -d=)
    paramValue=$(echo $1 | cut -f2 -d=)
    paramName=$(echo $parString | cut -f2 -d:)
    alvisParams=$alvisParams"  -alias "$paramName" "$paramValue
    shift # past argument
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done


echo "command:"$command
echo "command id:"$id
echo "inDir:"$inDir
echo "otDir:"$otDir
echo "alvisParams:"$alvisParams

# Call executor  
set -o xtrace
$command -J-Xmx30g -verbose  -alias input $inDir -entity outdir $outDir $alvisParams plans/tag_pubmed.plan
