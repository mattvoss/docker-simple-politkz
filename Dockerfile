# Install simple-politkz
#
# VERSION 0.1.0

FROM ubuntu:14.04
MAINTAINER Matt Voss "voss.matthew@gmail.com"
WORKDIR /data/simple-politkz

# Install dependencies for nginx installation
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN apt-get install -y wget curl unzip build-essential checkinstall zlib1g-dev libyaml-dev libssl-dev telnet less \
    libgdbm-dev libreadline-dev libncurses5-dev libffi-dev iputils-ping iputils-tracepath rsyslog supervisor \
    python-software-properties sendmail python g++ make software-properties-common rlwrap git-core wget vim && \
    apt-get clean && \
    add-apt-repository -y ppa:chris-lea/node.js && apt-get update && apt-get upgrade -y && apt-get clean && \
    apt-get install -y nodejs

#RUN dpkg-divert --local --rename --add /sbin/initctl && \
#    ln -s /bin/true /sbin/initctl

RUN echo "*.* @172.17.42.1:514" >> /etc/rsyslog.d/90-networking.conf

# Clone
RUN git clone --verbose https://github.com/mattvoss/simple-politkz.git /data/simple-politkz && \
    ls -al /data/simple-politkz

# Add custom settings.json to /data/simple-politkz
ADD settings.json /data/simple-politkz/config/settings.json
ADD supervisor-server.conf /etc/supervisor/conf.d/
ADD supervisor-simulate.conf /etc/supervisor/conf.d/
ADD supervisor-crawler.conf /etc/supervisor/conf.d/
ADD supervisor-rsyslogd.conf /etc/supervisor/conf.d/

# Install disney-dining-server with NPM
RUN cd /data/simple-politkz  && npm install && npm install -g grunt-cli bower && bower install --allow-root && grunt build

ADD install.sh /data/install.sh
RUN chmod +x /data/install.sh
ADD run.sh /data/run.sh
RUN chmod +x /data/run.sh

# Volumes

# Expose port 5001
EXPOSE 5001

# Run Supervisord
CMD ["/data/run.sh"]
