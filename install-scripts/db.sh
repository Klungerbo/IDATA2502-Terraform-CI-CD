#!/bin/bash
echo 'This is the DB' > index.html; nohup busybox httpd -f -p 8080 &