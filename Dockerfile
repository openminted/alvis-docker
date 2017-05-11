#FROM maven:3.2-jdk-7-onbuild
FROM ubuntu:14.04
MAINTAINER Mouhamadou Ba <mouhamadou.ba@inra.fr>

RUN apt-get -yqq update

RUN apt-get -yqq install maven

RUN apt-get -yqq install git

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

WORKDIR /opt/alvisnlp

RUN mvn clean install

RUN ./install.sh .

ENV PATH /opt/alvisnlp/bin:$PATH

CMD ["alvisnlp"]
