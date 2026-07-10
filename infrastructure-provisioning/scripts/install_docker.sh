#!/bin/bash

yum update -y

amazon-linux-extras install docker -y

systemctl start docker

systemctl enable docker

usermod -aG docker ec2-user

chmod 666 /var/run/docker.sock