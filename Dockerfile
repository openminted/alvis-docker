#FROM maven:3.2-jdk-7-onbuild
FROM ubuntu:14.04 
MAINTAINER Mouhamadou Ba <mouhamadou.ba@inra.fr>


# general tools
RUN apt-get -yqq update && apt-get -yqq install \
    maven \
    git \
    expect \
    wget \
    xmlstarlet \
    # for the python-based tools
    python \
    python-numpy \
    make \
    ruby \
    g++ \
    flex && \
    # java
    apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*

ENV java_version oracle-java8

RUN git clone https://github.com/Bibliome/alvisnlp.git /alvisnlp

WORKDIR /alvisnlp

# compiling and installing alvisnlp
RUN mvn clean install && ./install.sh .

# preparing the default params file
RUN cp share/default-param-values.xml.template share/default-param-values.xml && \
# create the external soft dir
mkdir psoft
ADD tees.expect /alvisnlp/psoft/
# install TEES
WORKDIR /alvisnlp/psoft
#RUN ## installing biolg 
    #wget http://staff.cs.utu.fi/~spyysalo/biolg/biolg-1.1.12.tar.gz && \
    #mkdir biolg-1.1.12 && tar xvzf biolg-1.1.12.tar.gz -C biolg-1.1.12/ && \
    #rm biolg-1.1.12.tar.gz && \
    #cd biolg-1.1.12/pcre-5.0 && ./configure && cd ../.. && \
    #cd biolg-1.1.12/expat-2.0.0 && ./configure && cd ../.. && \
    #cd biolg-1.1.12 && make && cd ../ && \
    #xmlstarlet ed -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.biolg.BioLG]/parserPath" -v /alvisnlp/psoft/biolg-1.1.12 /alvisnlp/share/default-param-values.xml && \
#xmlstarlet ed -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.biolg.BioLG]/lp2lpExecutable" -v /alvisnlp/psoft/biolg-1.1.12 /alvisnlp/share/default-param-values.xml && \
#xmlstarlet ed -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.biolg.BioLG]/lp2lpConf" -v /alvisnlp/psoft/biolg-1.1.12 /alvisnlp/share/default-param-values.xml && \
    ## intalling ccgparser
 RUN wget http://www.cl.cam.ac.uk/%7Esc609/resources/candc-downloads/candc-linux-1.00.tgz && \
    tar xvf candc-linux-1.00.tgz && \
    rm candc-linux-1.00.tgz && \
    cd candc-1.00/ && make && cd /alvisnlp/psoft && \
    xmlstarlet ed --inplace -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.ccg.CCGParser]/executable" -v /alvisnlp/psoft/candc-1.00/bin/parser /alvisnlp/share/default-param-values.xml && \
    xmlstarlet ed --inplace -d "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.ccg.CCGParser]/parserModel" /alvisnlp/share/default-param-values.xml && \
    xmlstarlet ed --inplace -d "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.ccg.CCGParser]/superModel" /alvisnlp/share/default-param-values.xml && \
    ## installing ccgpostagger
    xmlstarlet ed --inplace -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.ccg.CCGPosTagger]/executable" -v /alvisnlp/psoft/candc-1.00/bin/pos /alvisnlp/share/default-param-values.xml && \
    xmlstarlet ed --inplace -d "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.ccg.CCGPosTagger]/model" /alvisnlp/share/default-param-values.xml && \
    ## installing enjuparser /!\ download link does work
    ## installing enjuparser 2 /!\ download link does work
    ## install geniatagger
    wget http://www.nactem.ac.uk/tsujii/GENIA/tagger/geniatagger-3.0.2.tar.gz && \
    tar -xvf geniatagger-3.0.2.tar.gz && \
    rm geniatagger-3.0.2.tar.gz && \
    cd geniatagger-3.0.2 && make && cd /alvisnlp/psoft && \
    xmlstarlet ed --inplace -u "/default-param-values/module/geniaDir" -v /alvisnlp/psoft/geniatagger-3.0.2  /alvisnlp/share/default-param-values.xml && \
    ## installing StanfordNER 2014-06-16*
    wget https://nlp.stanford.edu/software/stanford-ner-2014-06-16.zip && \
    unzip stanford-ner-2014-06-16.zip && \
    rm stanford-ner-2014-06-16.zip && \
    # not required cd stanford-ner-2014-06-16/ && /alvisnlp/psoft ../ && \
    xmlstarlet ed --inplace -d "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.stanford.StanfordNER]/classifierFile" /alvisnlp/share/default-param-values.xml && \
    ## installing SPECIES
    wget http://download.jensenlab.org/species_tagger.tar.gz && \
    tar xvf species_tagger.tar.gz && \
    rm  species_tagger.tar.gz && \
    cd species_tagger && make && cd /alvisnlp/psoft && \
    xmlstarlet ed --inplace -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.Species]/speciesDir" -v /alvisnlp/psoft/species_tagger/ /alvisnlp/share/default-param-values.xml && \
    ## installing tees
    wget https://github.com/jbjorne/TEES/tarball/master && \
    tar xvf master && \
    rm -rf master && \
    mv *-TEES-*  tees && \
    cp tees.expect tees/ && \
    cd tees && expect tees.expect && \
    export TEES_SETTINGS=$pwd/tees_local_settings.py && \
    cd /alvisnlp/psoft 
    ## installing tees classify
    xmlstarlet ed --inplace -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.tees.TEESClassify]/teesHome" -v /alvisnlp/psoft/tees/ /alvisnlp/share/default-param-values.xml && \
    ## installing tees train
xmlstarlet ed --inplace -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.tees.TEESTrain]/teesHome" -v /alvisnlp/psoft/tees/ /alvisnlp/share/default-param-values.xml && \
    ## installing treeTagger
    wget http://www.cis.uni-muenchen.de/%7Eschmid/tools/TreeTagger/data/tree-tagger-linux-3.2.1.tar.gz && \
    mkdir treetagger/ && tar xvf tree-tagger-linux-3.2.1.tar.gz -C treetagger && \
    rm tree-tagger-linux-3.2.1.tar.gz && \
    cd treetagger/ && cd /alvisnlp/psoft  && \
    xmlstarlet ed --inplace -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.treetagger.TreeTagger]/treeTaggerExecutable" -v /alvisnlp/psoft/treetagger/bin/tree-tagger  /alvisnlp/share/default-param-values.xml && \
    xmlstarlet ed --inplace -d "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.tees.TEESTrain]/parFile" /alvisnlp/share/default-param-values.xml && \
    ## installing wapiti
    wget https://wapiti.limsi.fr/wapiti-1.5.0.tar.gz && \
    tar xvf wapiti-1.5.0.tar.gz && \
    rm wapiti-1.5.0.tar.gz && \
    cd  wapiti-1.5.0 && make && make install && cd /alvisnlp/psoft && \
    ## install wapiti label
    xmlstarlet ed --inplace -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.wapiti.WapitiLabel]/wapitiExecutable" -v /usr/local/bin/wapiti /alvisnlp/share/default-param-values.xml && \
    ## install wapiti train
    xmlstarlet ed --inplace -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.wapiti.WapitiTrain]/wapitiExecutable" -v /usr/local/bin/wapiti /alvisnlp/share/default-param-values.xml && \
    ## installing yatea /!\ seems to require Q&A during installation
    wget http://search.cpan.org/CPAN/authors/id/T/TH/THHAMON/Lingua-YaTeA-0.622.tar.gz && \
    tar xvf Lingua-YaTeA-0.622.tar.gz && \
    rm  Lingua-YaTeA-0.622.tar.gz && \
    cd Lingua-YaTeA-0.622 && \
    cpan App::cpanminus && \
    cpanm Lingua::YaTeA && \
    cd /alvisnlp/psoft && \
    xmlstarlet ed --inplace -u "/default-param-values/module/yateaExecutable" -v /usr/local/bin/yatea  /alvisnlp/share/default-param-values.xml && \
    xmlstarlet ed --inplace -d "/default-param-values/module/rcFile" /alvisnlp/share/default-param-values.xml && \
    xmlstarlet ed --inplace -d "/default-param-values/module/configDir" /alvisnlp/share/default-param-values.xml && \
    xmlstarlet ed --inplace -d "/default-param-values/module/localeDir" /alvisnlp/share/default-param-values.xml

ENV PATH /alvisnlp/bin:$PATH

# ENTRYPOINT ["/alvisnlp/bin/alvisnlp"]

CMD ["alvisnlp"]
