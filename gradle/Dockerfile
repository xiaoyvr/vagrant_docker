FROM ubuntu:14.04
MAINTAINER jksun
ENV REFRESHED_AT 2014-11-25
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer
RUN apt-get install -y oracle-java8-set-default
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/jre

RUN apt-get install -y maven
RUN apt-get -qfy install wget curl git build-essential
ADD https://get.docker.io/builds/Linux/x86_64/docker-latest /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker

ADD https://downloads.gradle.org/distributions/gradle-2.8-bin.zip gradle.zip
RUN unzip gradle.zip
ENV PATH /gradle-2.8/bin:$PATH
RUN rm -rf gradle.zip
ADD run.sh run.sh
RUN chmod +x run.sh
ENTRYPOINT ["./run.sh"]
