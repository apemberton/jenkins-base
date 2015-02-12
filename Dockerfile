# Docker base image for other CloudBees Jenkins images

FROM debian:jessie
MAINTAINER Andy Pemberton <apemberton@cloudbees.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
    curl \
    ntp \
    ntpdate  \
    git

RUN cd /opt &&  curl -L 'http://download.oracle.com/otn-pub/java/jdk/7u65-b17/jdk-7u65-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie; gpw_e24=Dockerfile' | tar -xz
RUN ln -s /opt/jdk1.7.0_65/bin/* /usr/local/bin/

# Install Docker client
RUN curl https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker
RUN groupadd docker

# Create Jenkins user
RUN useradd jenkins -d /home/jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN usermod -a -G docker jenkins

# Make directories for [masters] JENKINS_HOME, jenkins.war lib and [slaves] remote FS root, ssh privilege separation directory
RUN mkdir /usr/lib/jenkins /var/lib/jenkins /home/jenkins /var/run/sshd

# Set permissions
RUN chown -R jenkins:jenkins /usr/lib/jenkins /var/lib/jenkins /home/jenkins

# USER jenkins

CMD ["/bin/bash"]
