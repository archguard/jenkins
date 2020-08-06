FROM jenkins/jenkins

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false


COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
# ARG DEPENDENCY_ANALYZER_PLUGIN_URL="http://ec2-68-79-38-105.cn-northwest-1.compute.amazonaws.com.cn:8080/job/dependency-plugin/lastSuccessfulBuild/artifact/target/dependency-analyzer-plugin.hpi"
# RUN /usr/local/bin/install-plugins.sh dependency-analyzer:1.0:${DEPENDENCY_ANALYZER_PLUGIN_URL}

USER root
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce -y
RUN usermod -aG docker jenkins
RUN apt-get clean
RUN curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
USER jenkins