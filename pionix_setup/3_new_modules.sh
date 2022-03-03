#! /bin/bash

# https://everest.github.io/doc_tutorial_new_modules.html
cd ~/checkout/everest-workspace/everest-utils/ev-dev-tools
pip3 install .

cd ~/checkout/everest-workspace/
edm --update

# cp ~/Documents/setup_scripts/pionix_setup/example_manifest.json .
# cp ~/Documents/setup_scripts/pionix_setup/example_interface.json .

# --------------------------------------------------------------------
# 4.1. Writing a Js module: Creating some more essential files
# --------------------------------------------------------------------
# mkdir JsTestModule 2> /dev/null

# python3 write_module.py true ~/checkout/everest-workspace/ testModule

cd JsTestModule

# All modules CMakeList.txt:
# ~/checkout/everest-workspace/everest-core/modules/CMakeLists.txt


cp ~/checkout/everest-workspace/everest-core/modules/JsPN532TokenProvider/CMakeLists.txt ~/checkout/everest-workspace/JsTestModule/CMakeLists.txt
cp ~/checkout/everest-workspace/everest-core/modules/JsPN532TokenProvider/manifest.json ~/checkout/everest-workspace/JsTestModule/manifest.json
echo "{}" > ~/checkout/everest-workspace/JsTestModule/package.json # Assuming: no dependencies on external packages


# --------------------------------------------------------------------
# 4.2. Writing a C++ module: Creating some more essential files
# --------------------------------------------------------------------

<<COMMENT
mkdir testModule
cd testModule

cd ~/checkout/everest-workspace/everest-core
ev-cli mod create ~/checkout/everest-workspace/testModule
COMMENT

# New module's CMakeLists.txt: ~/checkout/everest-workspace/testModule/CMakeLists.text

# Configuration file:  ~/checkout/everest-workspace/everest-core/config/<config-file>.json
# Module's top level code files:
# ~/checkout/everest-workspace/testModule/testModule.cpp
# ~/checkout/everest-workspace/testModule/testModule.hpp

# Interface files:
# ~/checkout/everest-workspace/everest-core/interfaces/<interface-name>.json

# Manifest file
# ~/checkout/everest-workspace/everest-core/modules/testModule/manifset.json


# Submodule files:
# ~/checkout/everest-workspace/testModule/JsTestSubModule/<interface-name>.hpp
# ~/checkout/everest-workspace/testModule/JsTestSubModule/<interface-name>.cpp

# All modules CMakeList.txt:
# ~/checkout/everest-workspace/everest-core/modules/CMakeLists.txt




# Check that the new modules are present in
# ~/checkout/everest-workspace/everest-core/modules
# and
# ~/checkout/everest-workspace/everest-core/interfaces

# Link <Js/Cpp>ExampleReader in ~/checkout/everest-workspace/everest-core/config/config-sil.json, so that it's interface is no longer empty

# Add module names to `EVEREST_MODULES_LIST` in `/modules/CmakeLists.txt`
# Module names: JsExampleWriter, JsExampleReader, CppExampleWriter, CppExampleReader

# /everest-core/build/

cd ~/checkout/everest-workspace/everest-core/build
cmake .. && make -j$(nproc) install
# ./~/checkout/everest-workspace/everest-core/run_sil.sh
./../run_sil.sh

