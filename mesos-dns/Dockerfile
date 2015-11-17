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

RUN apt-get install -y gradle maven
RUN apt-get -qfy install wget curl git build-essential

RUN curl -Ls https://github.com/mesosphere/mesos-dns/releases/download/v0.4.0/mesos-dns-v0.4.0-linux-amd64.gz -o mesos-dns.gz; \
	gunzip mesos-dns.gz; \
	rm -rf mesos-dns.gz;
RUN chmod +x mesos-dns
EXPOSE 53
EXPOSE 8123
ADD config.json config.json
ENTRYPOINT ["./mesos-dns"]
