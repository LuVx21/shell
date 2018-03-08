#! /bin/bash

# wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.5.28/bin/apache-tomcat-8.5.28.tar.gz
wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-9/v9.0.5/bin/apache-tomcat-9.0.5.tar.gz
tar -zxvf apache-tomcat-9.0.5.tar.gz -C /usr/local/
mv /usr/local/apache-tomcat-9.0.5 /usr/local/tomcat9
