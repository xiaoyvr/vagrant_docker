#!/bin/sh
git clone ${GIT_REMOTE} codebase
cd codebase
gradle standaloneJar

cat << EOF > Dockerfile
FROM java:8
MAINTAINER jksun
ENV REFRESHED_AT 2014-11-25
COPY captcha/build/libs/captcha-standalone.jar captcha-standalone.jar
CMD ["java", "-cp", "captcha-standalone.jar", "com.thoughtworks.captcha.CaptchaServer", ">", "/tmp/log", "2>&1"]
EOF

docker build -t ${DOCKER_REGISTRY}/captcha .
docker push
