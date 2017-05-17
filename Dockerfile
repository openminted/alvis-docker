#FROM maven:3.2-jdk-7-onbuild
FROM ubuntu:14.04
MAINTAINER Mouhamadou Ba <mouhamadou.ba@inra.fr>

RUN apt-get -yqq update

RUN apt-get -yqq install maven

RUN apt-get -yqq install git

RUN apt-get -yqq install wget

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean

ENV java_version oracle-java8

WORKDIR /opt/

RUN git clone https://github.com/Bibliome/alvisnlp.git

VOLUME /opt/alvisnlp/data

WORKDIR /opt/alvisnlp

RUN mvn clean install

RUN ./install.sh .

ENV PATH /opt/alvisnlp/bin:$PATH

# create the external soft dir
RUN mkdir psoft
WORKDIR /opt/alvisnlp/psoft
# install TEES
RUN git clone https://github.com/jbjorne/TEES.git && \
    cd TEES/ && \
    apt-get install -y python && \
    apt-get install -y make && \
    apt-get install -y ruby && \
    apt-get install -y g++ && \
    apt-get install -y flex && \
    # python configure.py && \
    cd ../

# install geniatagger
RUN wget http://www.nactem.ac.uk/tsujii/GENIA/tagger/geniatagger-3.0.2.tar.gz && \
    tar -xvf geniatagger-3.0.2.tar.gz && \
    rm geniatagger-3.0.2.tar.gz

WORKDIR /opt/alvisnlp

# ENTRYPOINT ["/opt/alvisnlp/bin/alvisnlp"]

CMD ["alvisnlp"]
