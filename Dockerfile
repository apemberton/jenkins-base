# Docker base image for other CloudBees Jenkins images

FROM debian:jessie
MAINTAINER Andy Pemberton <apemberton@cloudbees.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-7-jdk \
    openssh-server \
    curl \
    ntp \
    ntpdate

# Create Jenkins user
RUN useradd jenkins
RUN echo "jenkins:jenkins" | chpasswd

# Make directories for [masters] JENKINS_HOME, jenkins.war lib and [slaves] remote FS root, ssh privilege separation directory
RUN mkdir /usr/lib/jenkins /var/lib/jenkins /var/run/sshd /home/jenkins

# Set permissions
RUN chown -R jenkins:jenkins /usr/lib/jenkins /var/lib/jenkins /home/jenkins

CMD ["/bin/bash"]