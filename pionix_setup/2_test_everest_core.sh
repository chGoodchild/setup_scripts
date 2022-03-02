#! /bin/bash

cd ~/checkout/everest-workspace/everest-utils/docker
sudo docker network create infranet_network
sudo docker-compose up -d

cd ~/checkout/everest-workspace/everest-core/build
.././run_sil.sh
