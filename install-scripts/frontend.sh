#!/bin/bash
sudo apt-get update && sudo apt -y install apache2
echo '<!doctype html><html><body><h1>This is the frontend</h1></body></html>' | sudo tee /var/www/html/index.html