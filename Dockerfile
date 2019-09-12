FROM centos
MAINTAINER srini (sriison@gmail.com)

RUN yum install wget -y
COPY . /opt
RUN cd /opt
RUN yum install git -y
ENV JAVA_HOME=/opt/jdk8
ENV PATH=$JAVA_HOME/bin:$PATH
WORKDIR /opt
RUN cd /opt
RUN wget http://mirrors.wuchna.com/apachemirror/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.tar.gz
RUN tar -zxvf apache-tomcat-9.0.12.tar.gz 
RUN mv apache-tomcat-9.0.12 tomcat9


RUN cd /opt/tomcat9/conf
WORKDIR /opt/tomcat9/conf
RUN printf "<role rolename="manager-gui"/>" >> tomcat-users.xml
RUN printf "<user username="srini" password="srini" roles="manager-gui"/>" >> tomcat-users.xml

WORKDIR /opt/tomcat9/webapps
RUN cd /opt/tomcat9/webapps
RUN wget https://s3.ap-south-1.amazonaws.com/hema123/target/petclinic.war

WORKDIR /opt/tomcat9/bin
RUN cd /opt/tomcat9/bin
RUN ./startup.sh
   
