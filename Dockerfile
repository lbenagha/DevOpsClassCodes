## if rerun and failed input this line ##
## jenkins ALL=(ALL) NOPASSWD: ALL  ##
rm -rf docker_jenkins
mkdir docker_jenkins
cd docker_jenkins
## copy file from jenkins to tomcat /usr/local/tomcat/webapps ##
cp /var/lib/jenkins/workspace/package_job/target/addressbook.war .
touch dockerfile
cat << EOT >> Dockerfile
## dockerfile ##
FROM tomcat
ADD addressbook.war /usr/local/tomcat/webapps
CMD "catalina.sh", "run"
EXPOSE 4040
EOT
sudo docker build -t myimage:$BUILD_NUMBER .
## overide CMD "catalina.sh", "run" ##
sudo docker run -itd -P myimage:$BUILD_NUMBER /bin/bash
