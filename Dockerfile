FROM tomcat
COPY /target/devopssampleapplication.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]