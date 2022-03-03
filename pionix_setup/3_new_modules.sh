#! /bin/bash

# https://everest.github.io/doc_tutorial_new_modules.html
cd ~/checkout/everest-workspace/everest-utils/ev-dev-tools
pip3 install .

cd ~/checkout/everest-workspace/
edm --update

# cp ~/Documents/setup_scripts/pionix_setup/example_manifest.json .
# cp ~/Documents/setup_scripts/pionix_setup/example_interface.json .

########################################
# Creating a JS workspace
########################################
mkdir js_test_module
cd js_test_module

cp ~/checkout/everest-workspace/everest-core/modules/JsPN532TokenProvider/manifest.json ~/checkout/everest-workspace/js_test_module/manifest.json
cp ~/checkout/everest-workspace/everest-core/modules/JsPN532TokenProvider/CMakeLists.txt ~/checkout/everest-workspace/js_test_module/CMakeLists.txt
echo "{}" > ~/checkout/everest-workspace/js_test_module/package.json # Assuming: no dependencies on external packages


########################################
# Creating a C++ workspace
########################################

cd ~/checkout/everest-workspace/everest-core
ev-cli mod create js_test_module
