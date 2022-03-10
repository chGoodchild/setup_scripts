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

# Both writer and reader
conf_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path ConfigFile)
cp config-sil.json $conf_file

# Writer
interface_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path InterfaceFile)
cp writer/js_example_writer.json $interface_file

code_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path ModulesCodeFile)
cp writer/index.js $code_file

manifest_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path ManifestFile)
cp writer/manifest.json $manifest_file

# Reader
interface_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleReader get_path InterfaceFile)
cp reader/js_example_reader.json $interface_file

code_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleReader get_path ModulesCodeFile)
cp reader/index.js $code_file

manifest_file=$(python3 setup_module.py true ~/checkout/everest-workspace/ ExampleWriter get_path ManifestFile)
cp reader/manifest.json $manifest_file

# Build
cd ~/checkout/everest-workspace/everest-core/build
cmake .. && make -j$(nproc) install
# ./~/checkout/everest-workspace/everest-core/run_sil.sh
./../run_sil.sh
