# business-web

## Run

```bash
# elasticsearch, kibana を起動
$ docker-compose up -d

# 現状、docker image から起動しています
$ ./docker-run.sh
```

## docker container にアクセス（docker-run.shにでログインするように修正しましたので不要となります）
```bash
# container に入る
$ docker ps
$ docker exec -it {CONTAINER ID} /bin/bash

# td-agent log
$ cat /var/log/td-agent/td-agent.log

```
参考記事：\
https://docs.fluentd.org/language-bindings/java \
https://pppurple.hatenablog.com/entry/2018/03/05/034339

## 参考コマンド

```bash
# docker image (adoptopenjdk/openjdk11:slim)はUbuntu ベースです
# Ubuntuのバージョン確認
$ cat /etc/os-release

# vim 入ってないので欲しい場合は入れてください
$ apt -y install vim
```

## Java version

```text
java -version
openjdk version "11.0.11" 2021-04-20
OpenJDK Runtime Environment AdoptOpenJDK-11.0.11+9 (build 11.0.11+9)
OpenJDK 64-Bit Server VM AdoptOpenJDK-11.0.11+9 (build 11.0.11+9, mixed mode)

```
