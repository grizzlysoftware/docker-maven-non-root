# Docker Image to run Apache Maven as non root user
this is fork of [jtim's repository](https://github.com/j-tim/docker-maven-non-root).
This repository just adds images that are combination of various Maven and OpenJDK versions.

Available Maven versions:

* 3.6.2
* 3.6.1
* 3.5.4
* 3.2.5
* 3.1.1
* 3.0.5

Available OpenJDK versions:
* 8u222-jdk-stretch
* 11.0.4-jdk-stretch

Docker image tags:
basicaly it gives us $mvn_version x $jdk_version, so:
* 3.0.5-11.0.4-jdk-stretch
* 3.0.5-8u222-jdk-stretch
* 3.1.1-11.0.4-jdk-stretch
* 3.1.1-8u222-jdk-stretch
* 3.2.5-11.0.4-jdk-stretch
* 3.2.5-8u222-jdk-stretch
* 3.5.4-11.0.4-jdk-stretch
* 3.5.4-8u222-jdk-stretch
* 3.6.1-11.0.4-jdk-stretch
* 3.6.1-8u222-jdk-stretch
* 3.6.2-11.0.4-jdk-stretch
* 3.6.2-8u222-jdk-stretch

Images are pushed to [Dockerhub](https://hub.docker.com/r/grizzlysoftware/maven-non-root/)

## Example how to use this Docker image using Gitlab CI

.gitlab-ci.yml

```yml
stages:
  - build

java-maven-3.6.2-11.0.4-jdk-stretch-job:
  image: grizzlysoftware/maven-non-root:3.6.2-11.0.4-jdk-stretch
  stage: build
  script:
    - whoami
    - java -version
    - mvn -v
    - mvn clean package
```