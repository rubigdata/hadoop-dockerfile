# Use an official Python runtime as a parent image
FROM andypetrella/spark-notebook:0.7.0-scala-2.11.8-spark-2.1.0-hadoop-2.7.3-with-hive


# Make port 80 available to the world outside this container
EXPOSE 9001
EXPOSE 4040-4045

RUN \ 
  echo export JAVA_HOME=${JAVA_HOME} >> ${HOME}/.bashrc && \
  apt-get update && \
  apt-get install -y wget rsync ssh nano && \
  export TERM=xterm && \
  service ssh start && \
  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  chmod 0600 ~/.ssh/authorized_keys 

ADD  https://archive.apache.org/dist/hadoop/core/hadoop-2.7.3/hadoop-2.7.3.tar.gz .

RUN tar xzvfp hadoop-2.7.3.tar.gz

COPY core-site.xml hadoop-2.7.3/etc/hadoop
COPY hdfs-site.xml hadoop-2.7.3/etc/hadoop