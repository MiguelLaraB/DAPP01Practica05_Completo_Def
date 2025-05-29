FROM tomcat:9.0-jdk11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/DAPP01Practica05-0.0.1-SNAPSHOT.war  /usr/local/tomcat/webapps/DAPP01Practica05-0.0.1-SNAPSHOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]