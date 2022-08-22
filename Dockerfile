FROM tomcat:alpine
COPY /target/devopssampleapplication.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]