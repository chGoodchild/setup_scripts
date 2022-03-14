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
edm --update

cd $cwd

rm -rf /home/pachai/checkout/everest-workspace/everest-core/modules/ExampleWriter
python3 setup_module.py false ~/checkout/everest-workspace/ ExampleWriter new

rm -rf /home/pachai/checkout/everest-workspace/everest-core/modules/ExampleReader
python3 setup_module.py false ~/checkout/everest-workspace/ ExampleReader new


# Set config
user_conf_file=$(python3 setup_module.py false ~/checkout/everest-workspace/ ExampleWriter get_path UserConfigFile)
cp cpp/config-sil.json $user_conf_file

# Reader
interface_file=$(python3 setup_module.py false ~/checkout/everest-workspace/ ExampleReader get_path InterfaceFile)
cp cpp/reader/example_reader.json $interface_file

# Writer
interface_file=$(python3 setup_module.py false ~/checkout/everest-workspace/ ExampleWriter get_path InterfaceFile)
cp cpp/writer/example_writer.json $interface_file

# -------------------------
# Create writer
core=$(python3 setup_module.py false ~/checkout/everest-workspace/ ExampleWriter get_path core)
manifest_file=$(python3 setup_module.py false ~/checkout/everest-workspace/ ExampleWriter get_path ManifestFile)
cp cpp/writer/manifest.json $manifest_file

cd $core
ev-cli mod create ExampleWriter
cd $cwd

# -------------------------
# Create reader
core=$(python3 setup_module.py false ~/checkout/everest-workspace/ ExampleReader get_path core)
manifest_file=$(python3 setup_module.py false ~/checkout/everest-workspace/ ExampleReader get_path ManifestFile)
cp cpp/reader/manifest.json $manifest_file

cd $core
ev-cli mod create ExampleReader
cd $cwd

# -------------------------

cp cpp/reader/ExampleReader.* ~/checkout/everest-workspace/everest-core/modules/ExampleReader/.
cp cpp/reader/example_reader_submodule ~/checkout/everest-workspace/everest-core/modules/ExampleReader/.

cp cpp/writer/ExampleWriter.* ~/checkout/everest-workspace/everest-core/modules/ExampleWriter/.
cp cpp/writer/example_writer_submodule ~/checkout/everest-workspace/everest-core/modules/ExampleWriter/.

# This is required because the auto generated .cpp and .hpp files have a "js_" prefix, ninja install would crash at [9/13] Linking CXX shared library modules/ExampleWriter/libmodExampleWriter.so
# cd $cwd
# cp cpp/writer/ExampleWriter.hpp ~/checkout/everest-workspace/everest-core/modules/ExampleWriter/ExampleWriter.hpp
# cp cpp/reader/ExampleReader.hpp ~/checkout/everest-workspace/everest-core/modules/ExampleReader/ExampleReader.hpp

# Build

# Slow
cd ~/checkout/everest-workspace/everest-core
rm -rf build
mkdir build
cd build
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Debug
# mkdir ~/checkout/everest-workspace/everest-core/build/modules/JsExampleWriter/node_modules
# mkdir ~/checkout/everest-workspace/everest-core/build/modules/JsExampleReader/node_modules


# Fast
# cd ~/checkout/everest-workspace/everest-core/build
# cmake .. -GNinja


ninja install
./../run_sil.sh
# https://github.com/EVerest/everest-core/tree/test/ld_cpp_example_writer/modules/CppExampleWriter

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


# ll /home/pachai/checkout/everest-workspace/everest-core/build/dist/interfaces/js_example_reader.json
# rather than
# ll /home/pachai/checkout/everest-workspace/everest-core/build/dist/interfaces/example_reader_interface.json



# mqtt-explorer
# localhost
# validate certificate off

# Node-RED: see notes