#! /bin/bash

cwd=$(pwd)

# https://everest.github.io/doc_tutorial_new_modules.html
cd ~/checkout/everest-workspace/everest-utils/ev-dev-tools
pip3 install .

cd ~/checkout/everest-workspace/

# Checkout init script in everest utils... Does the things that this script needs to do...
# https://github.com/EVerest/everest-utils/blob/main/everest-cpp/init.sh

# Add:
# export CPM_SOURCE_CACHE=$HOME/cache
# To:
# ~/.profile
edm --update

cd $cwd

echo $cwd

python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter new
python3 setup_module.py true ~/checkout/everest-workspace/ ExampleReader new

# Both writer and reader
user_conf_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path UserConfigFile)
cp config-sil.json $user_conf_file

# conf_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path UserConfigFile)
# cp config-sil.json_full $conf_file
# rm $user_conf_file

# Writer
interface_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path InterfaceFile)
cp js/writer/js_example_writer.json $interface_file

code_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path ModulesCodeFile)
cp js/writer/index.js $code_file

manifest_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path ManifestFile)
cp js/writer/manifest.json $manifest_file

# Reader
interface_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleReader get_path InterfaceFile)
cp js/reader/js_example_reader.json $interface_file

code_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleReader get_path ModulesCodeFile)
cp js/reader/index.js $code_file

manifest_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleReader get_path ManifestFile)
cp js/reader/manifest.json $manifest_file

# Build
cd ~/checkout/everest-workspace/everest-core/build
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Debug
# cmake ..
# cmake .. -GNinja
# cmake .. -DCMAKE_BUILD_TYPE=Debug
mkdir ~/checkout/everest-workspace/everest-core/build/modules/JsExampleWriter/node_modules
mkdir ~/checkout/everest-workspace/everest-core/build/modules/JsExampleReader/node_modules
# make -j$(nproc) install
ninja install
# ./~/checkout/everest-workspace/everest-core/run_sil.sh

# cd $cwd
# cp config-sil.json_no_array $user_conf_file
# cd ~/checkout/everest-workspace/everest-core/build

# /home/pachai/checkout/everest-workspace/everest-core/config
# emacs logging.ini
# Filter="%Severity% >= INFO"
# Filter="%Severity% >= DEBUG"

# sudo docker-compose up -d # Only needed once
# ~/checkout/everest-workspace$ edm --git-info --git-fetch
# ~/checkout/everest-workspace$ edm --git-pull libocpp
# ./../run_sil.sh --check # only validates the config and doesn't try to start the modules
./../run_sil.sh

# ll /home/pachai/checkout/everest-workspace/everest-core/build/dist/interfaces/js_example_reader.json
# rather than
# ll /home/pachai/checkout/everest-workspace/everest-core/build/dist/interfaces/example_reader_interface.json

# <<COMMENT
# COMMENT


# mqtt-explorer
# localhost
# validate certificate off

# Node-RED: see notes