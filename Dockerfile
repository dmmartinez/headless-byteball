# FROM ubuntu:16.04
FROM node:9

WORKDIR /usr/src/app

# De https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget tor expect && \
  rm -rf /var/lib/apt/lists/*

# Volúmenes
VOLUME /root/.config/
VOLUME /var/log/

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)

COPY . .
# COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production
RUN chown -R root:root ./
RUN chmod -R 700 ./
RUN /etc/init.d/tor restart
RUN ./docker-init.exp

# EXPOSE 8080
# CMD ["node", "start.js"]
CMD ["docker-start.exp"]