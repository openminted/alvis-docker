docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/ontology-analyzer \
alvisnlp org.bibliome.alvisnlp.modules.phenotype-ontology-analyzer \
--input /alvisnlp/data/ontology/OntoBiotope-Phenotype-v2.obo \
--output /alvisnlp/data/result/OntoBiotope-Phenotype.tomap
