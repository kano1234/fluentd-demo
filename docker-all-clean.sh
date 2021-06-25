#!/bin/bash
# コンテナを停止＆削除
docker stop $(docker ps -q)
docker rm $(docker ps -q -a)
# docker rmi -f $(docker images -q)
docker ps
