#!/bin/bash
echo 'This is the backend API' > index.html; nohup busybox httpd -f -p 8080 &