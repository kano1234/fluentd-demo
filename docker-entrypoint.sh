#!/bin/bash
cp fluent.conf /etc/td-agent/td-agent.conf
sudo systemctl start td-agent.service
java -jar -Dspring.profiles.active=$STAGE $JAR_TARGET
