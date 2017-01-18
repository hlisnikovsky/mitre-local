FROM openjdk:8
 
RUN mkdir  /csas/ &&  mkdir ~/.ssh/
RUN apt-get update && apt-get install -y git && apt-get install -y software-properties-common
RUN touch ~/.ssh/known_hosts && ssh-keyscan github.com >> ~/.ssh/known_hosts 

#install maven3
RUN mkdir -p /usr/local/apache-maven && cd /usr/local/apache-maven && wget http://apache.mirrors.lucidnetworks.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz &&  tar -xzvf apache-maven-3.3.9-bin.tar.gz && rm ./apache-maven-3.3.9-bin.tar.gz
ENV  M2_HOME /usr/local/apache-maven/apache-maven-3.3.9 
ENV  M2=$M2_HOME/bin 
ENV  MAVEN_OPTS="-Xms256m -Xmx512m"
ENV  PATH=$M2:$PATH

RUN pwd
#Variant 1) for OP demo on localhost
RUN cd /csas && git clone https://github.com/hlisnikovsky/mitre-local
RUN cd /csas/mitre-local && mvn clean install
CMD cd /csas/mitre-local && mvn tomcat7:run

EXPOSE 8080 


#EXAMPLE of how to run this docker (mitre-local is name you can change): 
# build: docker build -t mitre-local .
# run:   docker run -it -p 8080:8080 mitre-local:latest 
#
