#FROM maven:3.2-jdk-7-onbuild
FROM ubuntu:14.04
MAINTAINER Mouhamadou Ba <mouhamadou.ba@inra.fr>

RUN apt-get -yqq update

RUN apt-get -yqq install maven

RUN apt-get -yqq install git

RUN apt-get install -yqq openjdk-7-jdk

ENV java_version openjdk-7-jdk

WORKDIR /opt/

RUN git clone https://github.com/Bibliome/alvisnlp.git

WORKDIR /opt/alvisnlp

RUN mvn clean install

RUN ./install.sh .

ENV PATH /opt/alvisnlp/bin:$PATH

CMD ["alvisnlp"]
