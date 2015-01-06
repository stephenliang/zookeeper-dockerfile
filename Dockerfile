FROM ubuntu
MAINTAINER Stephen Liang "docker-maint@stephenliang.pw"

ENV VERSION 3.4.6

RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
ADD http://mirror.cogentco.com/pub/apache/zookeeper/zookeeper-${VERSION}/zookeeper-${VERSION}.tar.gz /

RUN tar -xvzf zookeeper-${VERSION}.tar.gz -C /opt/ && mv /opt/zookeeper* /opt/zookeeper
RUN cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg
RUN mkdir -p /tmp/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
