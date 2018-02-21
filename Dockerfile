# Use an official Python runtime as a parent image
FROM andypetrella/spark-notebook:0.7.0-scala-2.11.8-spark-2.1.0-hadoop-2.7.3-with-hive


# Make port 80 available to the world outside this container
EXPOSE 9001 4040-4045

ADD hadoop-2.7.3.tar.gz ./
ADD core-site.xml hdfs-site.xml hadoop-2.7.3/etc/hadoop/

RUN \ 
  echo export JAVA_HOME=${JAVA_HOME} >> ${HOME}/.bashrc && \
  apt-get update && \
  apt-get install -y wget rsync ssh nano && \
  export TERM=xterm && \
  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  chmod 0600 ~/.ssh/authorized_keys && \
  echo export PATH=$PATH:/opt/docker/hadoop-2.7.3/bin:/opt/docker/hadoop-2.7.3/sbin >> ${HOME}/.bashrc  

ENTRYPOINT service ssh start && bin/spark-notebook