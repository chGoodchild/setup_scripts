#!/bin/bash
sudo apt-get install node.js
sudo apt-get install npm
sudo npm install -g typescript@2.0.2

echo "Updating to the latest version before we can proceed:"
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
echo "Assuming latest = 7.8.0"
sudo ln -sf /usr/local/n/versions/node/7.8.0/bin/node /usr/bin/node 
sudo n latest
echo "Done updating."

sudo npm install -g angular-cil

echo "Verifying a successful install:"
ng version
