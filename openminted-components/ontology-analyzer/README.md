# ontology-analyzer

This component processes an ontology (in OBO format)
in order to use with the ToMap component. It analyzes the structure of
the ontology terms and outputs the result in XML format. It is defined using alvisnlp plans (see the plans into the [test-data/plans folder](test-data/plans)).

## test-data
the test-data to run this component are into the `test-data` folder
 
* ontology contains an example of ontology to process

* an example of output is stored into the result folder

## Run from the command line

From the folder contained the README, run the following command. You're supposed to have docker installed.
> Note that, OpenMinTeD will generate this command from the metadata records and also from the input/output/parameter values provided by the user when (s)he runs the component. 

```
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/ontology-analyzer \
alvisnlp org.bibliome.alvisnlp.modules.ontology-analyzer \
--input /alvisnlp/data/ontology/OntoBiotope-Phenotype-v2.obo \
--output /alvisnlp/data/result/OntoBiotope-Phenotype.tomap
```

# OpenMinTeD metadata

The Openminted metadata records are described in the following XML files
* [OMTD-SHARE records V3.0.0](ontology-analyzer.metadata.omtd.v3.0.0)

# re-build the docker image
You can re-build the docker image from the dockerfile by running the following command from the folder contained the README
```
docker build . -t bibliome/ontology-analyzer -f Dockerfile.ontology-analyzer
```
