
# This config builds Guacamole server

# Stage 1
FROM ubuntu:focal as BUILDER

COPY ./guacamole/guacamole.properties /tmp/guacamole.properties

COPY ./guacamole/user-mapping.xml /tmp/user-mapping.xml

# Configure timezone
RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
    apt update && \
    apt install -y tzdata

# Compile and Install Guacamole server
RUN apt install -y gcc vim curl wget g++ libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin libossp-uuid-dev libavcodec-dev libavutil-dev libswscale-dev build-essential libpango1.0-dev libssh2-1-dev libvncserver-dev libtelnet-dev freerdp2-dev freerdp2-x11 libwebsockets-dev libssl-dev libvorbis-dev libwebp-dev openjdk-11-jdk && \
    wget https://dlcdn.apache.org/guacamole/1.4.0/source/guacamole-server-1.4.0.tar.gz -O /tmp/guacamole-server-1.4.0.tar.gz && \
    cd /tmp && \
    tar zxf guacamole-server-1.4.0.tar.gz && \
    cd guacamole-server-1.4.0 && \
    ./configure && \
    make && \
    make install && \
    ldconfig

# Install tomcat9
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.60/bin/apache-tomcat-9.0.60.tar.gz -O /tmp/apache-tomcat-9.0.60.tar.gz && \
    cd /tmp && \
    tar zxf apache-tomcat-9.0.60.tar.gz && \
    mkdir /usr/local/tomcat/ && \
    cp -R apache-tomcat-9.0.60/* /usr/local/tomcat/

# Install Guacamole webapp
RUN cd /usr/local/tomcat/ && \
    wget https://dlcdn.apache.org/guacamole/1.4.0/binary/guacamole-1.4.0.war -O webapps/guacamole.war && \
    mkdir /etc/guacamole && \
    mkdir /usr/local/tomcat/.guacamole && \
    ln -s /etc/guacamole/guacamole.properties /usr/local/tomcat/.guacamole/ && \
    cp /tmp/guacamole.properties /etc/guacamole/guacamole.properties && \
    cp /tmp/user-mapping.xml /etc/guacamole/user-mapping.xml

RUN apt clean && \
    apt auto-clean && \
    rm -rf /tmp/*


# Stage 2
FROM scratch

MAINTAINER nivedan_rajasekar@comcast.com "https://github.comcast.com/nrajas590"

COPY --from=BUILDER / /

EXPOSE 8080

CMD ["ping" "localhost"]
