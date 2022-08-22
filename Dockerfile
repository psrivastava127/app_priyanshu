FROM tomcat
COPY /target/devopssampleapplication.war /usr/local/tomcat/webapps
EXPOSE 7500
CMD ["catalina.sh", "run"]