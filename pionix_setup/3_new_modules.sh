#! /bin/bash

cwd=$(pwd)

# https://everest.github.io/doc_tutorial_new_modules.html
cd ~/checkout/everest-workspace/everest-utils/ev-dev-tools
pip3 install .

cd ~/checkout/everest-workspace/
edm --update

cd $cwd

echo $cwd

python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter new
python3 setup_module.py true ~/checkout/everest-workspace/ ExampleReader new

conf_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path ConfigFile)
cp config-sil.json $conf_file

interface_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path InterfaceFile)
cp js_example_writer.json $interface_file

code_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path ModulesCodeFile)
cp writer/index.js $code_file

manifest_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path ManifestFile)
cp writer/manifest.json $manifest_file


<<COMMENT

cd ~/checkout/everest-workspace/everest-core/build
cmake .. && make -j$(nproc) install
# ./~/checkout/everest-workspace/everest-core/run_sil.sh
./../run_sil.sh

COMMENT