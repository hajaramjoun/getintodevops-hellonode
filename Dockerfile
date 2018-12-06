FROM tomcat:7.0.65-jre7
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install openjdk-7-jdk
ADD conf/setenv.sh /usr/local/tomcat/bin/
RUN chmod a+x  /usr/local/tomcat/bin/setenv.sh
CMD ["setenv.sh", "run"]
ADD Rjcms /usr/local/tomcat/webapps/ROOT
ADD conf/server.xml /usr/local/tomcat/bin/
ADD conf/setclasspath.sh /usr/local/tomcat/bin/
ADD conf/context.xml /usr/local/tomcat/conf/context.xml
CMD ["catalina.sh", "run"]
