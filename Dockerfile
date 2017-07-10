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
    apt-get clean && \
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

RUN cp share/default-param-values.xml.template share/default-param-values.xml && \
# create the external soft dir
mkdir psoft
ADD tees.expect alvisnlp/psoft/
# install TEES
WORKDIR alvisnlp/psoft
RUN wget https://github.com/jbjorne/TEES/tarball/master && \
    tar xvf master && \
    rm -rf master && \
    mv *-TEES-*  tees && \
    cp tees.expect tees/ && \
    cd tees && \
    expect tees.expect && \
    export TEES_SETTINGS=$pwd/tees_local_settings.py && \
    xmlstarlet ed --inplace -u "/default-param-values/module/teesHome" -v /opt/alvisnlp/psoft/tees /opt/alvisnlp/share/default-param-values.xml && \
    #install tees by answering questions
    #WORKDIR /opt/alvisnlp/psoft/tees
    #RUN expect tees.expect && \
    #xmlstarlet ed --inplace -u "/default-param-values/module/teesHome" -v /opt/alvisnlp/psoft/tees /opt/alvisnlp/share/default-param-values.xml && \
    #SPECIES
    wget http://download.jensenlab.org/species_tagger.tar.gz && \
    tar xvf species_tagger.tar.gz && \
    rm  species_tagger.tar.gz && \
    cd species_tagger && \
    cd ../  && \
    #RUN xmlstarlet ed -u "/default-param-values/module/teesHome" -v /opt/alvisnlp/tees /opt/alvisnlp/share/default-param-values.xml && \
    #install biolg && \
    #RUN wget http://staff.cs.utu.fi/~spyysalo/biolg/biolg-1.1.12.tar.gz && \
    #tar xvf biolg-1.1.12.tar.gz && \
    #rm biolg-1.1.12.tar.gz && \
    #RUN cd ../ && \
    #RUN xmlstarlet ed -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.tees.TEESClassify]/teesHome" -v /opt/alvisnlp/tees /opt/alvisnlp/share/default-param-values.xml && \
    #install CCGParser 1.00 && \
    #RUN wget http://www.cl.cam.ac.uk/%7Esc609/resources/candc-downloads/candc-linux-1.00.tgz && \
    #tar xvf candc-linux-1.00.tgz && \
    #rm candc-linux-1.00.tgz && \
    #make 
    #RUN cd ../
    #RUN xmlstarlet ed -u "/default-param-values/module[@class=org.bibliome.alvisnlp.modules.tees.TEESClassify]/teesHome" -v /opt/alvisnlp/tees /opt/alvisnlp/share/default-param-values.xml
    #CCGPosTagger 1.00 /!\ seem to be the same as CGParser 1.00
    #enju parser /!\ download link does work
    #enju parser 2 /!\ download link does work
    #install geniatagger
    wget http://www.nactem.ac.uk/tsujii/GENIA/tagger/geniatagger-3.0.2.tar.gz && \
    tar -xvf geniatagger-3.0.2.tar.gz && \
    rm geniatagger-3.0.2.tar.gz && \
    cd geniatagger-3.0.2 && \
    make && \
    cd ../ && \
    xmlstarlet ed --inplace -u "/default-param-values/module/geniaDir" -v /opt/alvisnlp/psoft/geniatagger-3.0.2  /opt/alvisnlp/share/default-param-values.xml && \
    #StanfordNER 2014-06-16*
    wget https://nlp.stanford.edu/software/stanford-ner-2016-10-31.zip && \
    unzip stanford-ner-2016-10-31.zip && \
    rm stanford-ner-2016-10-31.zip && \
    cd stanford-ner-2016-10-31/ && \
    cd ../ && \
    xmlstarlet ed --inplace -u "/default-param-values/module/geniaDir" -v /opt/alvisnlp/psoft/geniatagger-3.0.2  /opt/alvisnlp/share/default-param-values.xml && \
    #TEES see abovee
    #treeTagger
    wget http://www.cis.uni-muenchen.de/%7Eschmid/tools/TreeTagger/data/tree-tagger-linux-3.2.1.tar.gz && \
    tar xvf tree-tagger-linux-3.2.1.tar.gz && \
    rm tree-tagger-linux-3.2.1.tar.gz && \
    cd ../
    #WapitiLabel 1.5.0
    #WapitiTrain 1.5.0
    #YateaExtractor 0.5*
    #install alvisnlp

RUN mvn clean install && ./install.sh .

ENV PATH /opt/alvisnlp/bin:$PATH

# ENTRYPOINT ["/opt/alvisnlp/bin/alvisnlp"]

CMD ["alvisnlp"]
