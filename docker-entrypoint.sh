#!/bin/bash
java -jar -Dspring.profiles.active=$STAGE $JAR_TARGET
