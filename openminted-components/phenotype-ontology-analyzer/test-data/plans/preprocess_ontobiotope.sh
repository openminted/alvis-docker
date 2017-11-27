#!/bin/bash

ONTOBIOTOPE=$1

# 1. Remove obsolote concepts
/alvisnlp/psoft/obo-utils/obo2obo.py resources/$ONTOBIOTOPE.obo >resources/$ONTOBIOTOPE-no-obsolete.obo

# 2. Cut subtrees that are not used + separate between biotopes and phenotypes and molecular entities
/alvisnlp/psoft/obo-utils/obo-subtree.py --exclude-root OBT:002412 --exclude-root OBT:002325 --exclude-root OBT:002323 --exclude-root OBT:002324 --exclude-root OBT:002448 --exclude-root MoPh:00000520 --exclude-root EC:0000270 resources/$ONTOBIOTOPE-no-obsolete.obo >resources/$ONTOBIOTOPE-Habitat.obo

/alvisnlp/psoft/obo-utils/obo-subtree.py --exclude-root OBT:002412 --exclude-root OBT:002325 --exclude-root OBT:002323 --exclude-root OBT:002324 --exclude-root OBT:002448 --exclude-root OBT:000000 --exclude-root EC:0000270 resources/$ONTOBIOTOPE-no-obsolete.obo >resources/$ONTOBIOTOPE-Phenotype.obo

/alvisnlp/psoft/obo-utils/obo-subtree.py --exclude-root OBT:002412 --exclude-root OBT:002325 --exclude-root OBT:002323 --exclude-root OBT:002324 --exclude-root OBT:002448 --exclude-root OBT:000000 --exclude-root MoPh:00000520 resources/$ONTOBIOTOPE-no-obsolete.obo >resources/$ONTOBIOTOPE-Molecule.obo

# 3. Analyze ontologies with tomap
alvisnlp -cleanTmp -verbose -alias input resources/$ONTOBIOTOPE-Habitat.obo -alias output resources/$ONTOBIOTOPE-Habitat.tomap plans/biotope_ontology_analyzer.plan

alvisnlp -cleanTmp -verbose -alias input resources/$ONTOBIOTOPE-Phenotype.obo -alias output resources/$ONTOBIOTOPE-Phenotype.tomap plans/phenotype_ontology_analyzer.plan

# 4. obo to json
/alvisnlp/psoft/obo-utils/obo2json.py --root OBT:000000 resources/$ONTOBIOTOPE-Habitat.obo >resources/$ONTOBIOTOPE-Habitat.json

/alvisnlp/psoft/obo-utils/obo2json.py --root MoPh:00000520 resources/$ONTOBIOTOPE-Phenotype.obo >resources/$ONTOBIOTOPE-Phenotype.json



