FROM  registry.access.redhat.com/rhscl/nodejs-8-rhel7

USER root

RUN rpm -vhi https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y ffmpeg graphicsmagick git

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install
COPY *bower* /usr/src/app/
RUN node node_modules/bower/bin/bower install --allow-root
COPY . /usr/src/app

# Default HTTP port
EXPOSE 8075

USER 10020

# Start the server
CMD ["node", "server.js"]
