# Alvis Docker
Dockerizing Alvis and its components

## Use the docker image

A fist docker image for testing the [alvisnlp](https://github.com/Bibliome/alvisnlp) engine in command line is present into [Docker Hub](https://hub.docker.com/r/mandiayba/alvisengine)

1. display the alvis help

`docker run mandiayba/alvisengine:1.0.0 alvisnlp -help`

2. list the modules supported by alvis

`docker run mandiayba/alvisengine alvisnlp -supportedModules`

3. display the doc of the module named `SimpleProjector`

`docker run mandiayba/alvisengine alvisnlp -moduleDoc SimpleProjector`

3. run an alvis plan that trains a ML model for binary relation extraction 

`docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data  -a stderr mandiayba/alvisengine:1.0.0 alvisnlp /opt/alvisnlp/data/plans/train.plan`

4. run an alvis plan that classifies binary relations

`docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data  -a stderr mandiayba/alvisengine:1.0.0 alvisnlp /opt/alvisnlp/data/plans/predict.plan`

The train and classify plans are based on [GeniaTagger](http://www.nactem.ac.uk/GENIA/tagger/) and [TEES](https://github.com/jbjorne/TEES/) tools integrated to AlvisNLP. The corpus used is the [Bacteria Biotope 2016](https://sites.google.com/site/bionlpst2016/tasks/bb2). The binary relation classified here is named "Lives_in". It expresses the fact that some bacteries live in some habitats.


## The docker image creation

* automatically clone and install alvisnlp with Dockerfile
* then, install the following external programs in an interactive mode 

  * [Species](http://download.jensenlab.org/species_tagger.tar.gz) 1.0
  * [BioLG](http://mars.cs.utu.fi/biolg/) 1.1.12
  * [CCGParser](http://www.cl.cam.ac.uk/~sc609/candc-1.00.html) 1.00
  * [CCGPosTagger](http://www.cl.cam.ac.uk/~sc609/candc-1.00.html) 1.00
  * [EnjuParser](http://www.nactem.ac.uk/enju/) 2.4.2
  * [EnjuParser2](http://www.nactem.ac.uk/enju/) 2.4.2
  * [GeniaTagger](http://www.nactem.ac.uk/GENIA/tagger/) 3.0.1<sup>*</sup>
  * [StanfordNER](https://nlp.stanford.edu/software/CRF-NER.shtml) 2014-06-16<sup>*</sup>
  * [TEESClassify](https://github.com/jbjorne/TEES/) 2.2.1
  * [TEESTrain](https://github.com/jbjorne/TEES/) 2.2.1
  * [TreeTagger](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) 3.2<sup>*</sup>
  * [WapitiLabel](https://wapiti.limsi.fr/) 1.5.0
  * [WapitiTrain](https://wapiti.limsi.fr/) 1.5.0
  * [YateaExtractor](https://perso.limsi.fr/hamon/YaTeA/) 0.5<sup>*</sup>

<sup>*</sup> Not the latest version, we might want to test with the latest version.
