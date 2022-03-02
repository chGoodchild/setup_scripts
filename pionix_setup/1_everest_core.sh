#! /bin/bash

# https://github.com/EVerest/everest-core#readme

sudo apt update
sudo apt install -y git rsync wget cmake doxygen graphviz build-essential clang-tidy cppcheck maven openjdk-11-jdk npm docker docker-compose libboost-all-dev nodejs libssl-dev libsqlite3-dev clang-format

sudo apt install -y jstyleson jsonschema
sudo apt install -y python3-pip

python3 -m pip install --upgrade pip setuptools wheel

git clone git@github.com:EVerest/everest-dev-environment.git
cd everest-dev-environment/dependency_manager

python3 -m pip install .

edm --register-cmake-module --config ../everest-complete.yaml --workspace ~/checkout/everest-workspace

export CPM_SOURCE_CACHE=$HOME/.cache/CPM

cd ~/checkout/everest-workspace/everest-utils/ev-dev-tools
python3 -m pip install .

rm -rf ~/checkout/everest-workspace/everest-core/build
mkdir -p ~/checkout/everest-workspace/everest-core/build
cd ~/checkout/everest-workspace/everest-core/build

npm install bufferutil

# https://github.com/nodesource/distributions
sudo apt install -y curl
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install -y nodejs

# sudo apt install -y clang-format-12
# sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-12 100
# clang-format --version
# Ubuntu clang-format version 12.0.0-3ubuntu1~20.04.4

cmake -j$(nproc) ..

old_str="AllowShortEnumsOnASingleLine: false"
new_str="# AllowShortEnumsOnASingleLine: false"
filepath="~/checkout/everest-workspace/everest-core/.clang-format"
sed -i "s/$old_str/$new_str/g" $filepath

make -j$(nproc) install
