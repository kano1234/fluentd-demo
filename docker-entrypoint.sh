#!/bin/bash
apt -y update
apt -y install sudo
apt -y install less
apt -y install systemctl
apt -y install gnupg
curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-focal-td-agent4.sh | sh
cp fluent.conf /etc/td-agent/td-agent.conf
sudo systemctl start td-agent.service
java -jar -Dspring.profiles.active=$STAGE $JAR_TARGET
