#!/bin/bash

ONTOBIOTOPE=$1

# 1. Remove obsolote concepts
/alvisnlp/psoft/obo-utils/obo2obo.py resources/$ONTOBIOTOPE.obo >resources/$ONTOBIOTOPE-no-obsolete.obo

# 2. Cut subtrees that are not used
/alvisnlp/psoft/obo-utils/obo-subtree.py --exclude-root OBT:002412 --exclude-root OBT:002325 --exclude-root OBT:002323 --exclude-root OBT:002324 --exclude-root OBT:002448 resources/$ONTOBIOTOPE-no-obsolete.obo >resources/$ONTOBIOTOPE-cut.obo

# 3. Analyze ontology with tomap
alvisnlp -cleanTmp -verbose -environmentEntities -entity outfile $ONTOBIOTOPE-cut.tomap -entity ontofile $ONTOBIOTOPE-cut.obo plans/biotope_ontology_analyzer.plan

# 4. obo to json
/alvisnlp/psoft/obo-utils/obo2json.py --root OBT:000000 resources/$ONTOBIOTOPE-cut.obo >resources/$ONTOBIOTOPE-cut.json


