#!/bin/bash

(/usr/local/tomcat/bin/catalina.sh run)&

/usr/local/sbin/guacd -f
