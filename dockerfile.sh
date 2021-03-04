## jenkins ALL=(ALL) NOPASSWD: ALL  ##
rm -rf docker_jenkins
mkdir docker_jenkins
cd docker_jenkins
cp /var/lib/jenkins/workspace/package_job/target/addressbook.war .
touch dockerfile
cat << EOT >> Dockerfile
FROM tomcat
ADD addressbook.war /usr/local/tomcat/webapps
CMD "catalina.sh", "run"
EXPOSE 4040
EOT
sudo docker build -t myimage:$BUILD_NUMBER .
## overide CMD "catalina.sh", "run" ##
sudo docker run -itd -P myimage:$BUILD_NUMBER /bin/bash
