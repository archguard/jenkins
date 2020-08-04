# jenkins
Custom jenkins images with docker-compose,docker and all the plugins pre-installed

If you are using this on production, you may want to comment the passowrd setup on the jenkins file 

## export plugins.txt from exist jenkins instance
```
java -jar jenkins-cli.jar -s http://your_jenkins_url/ groovy --username "admin" --password "admin" groovy = < jenkins/plugins.groovy > jenkins/plugins.txt
```
Read more about: <https://gist.github.com/superPershing/b7c7da9c0bd23f8c2c6b0b026a18508b>

## boot
```
docker build . -t archguard/jenkins:lastest

docker run \
  -u root \
  -d \
  -p 18070:8080 \
  -p 50000:50000 \
  -v ~/jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  archguard/jenkins:lastest
```