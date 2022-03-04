#!/usr/bin/python3
from pathlib import Path
import sys, shutil, json
from module import *
import copy as copy

# print ('Number of arguments:', len(sys.argv), 'arguments.')
# print ('Argument List:', str(sys.argv))


def module_name(js, module):
    name = ""
    if js:
        name = "Js" + module[0].upper()
    else:
        name = module[0].upper()

    if len(module) > 1:
        name += module[1:]
    return name


def module_path(modules, module_name):
    path = modules / module_name
    path.mkdir(parents=True, exist_ok=True)
    assert path.exists() == True
    return path


def write_module(mdata):
    print(mdata)

    """
    mdata = {}
    mdata[name] = module_name(js, module)
    mdata[modules] = Path(mdata["workspace"]) / Path("everest-core/modules")

    print(mdata)
    """


def set_cmake_lists_js(modules, module_path):
    cmake = Path("CMakeLists.txt")

    JsPN532TokenProvider = modules / Path("JsPN532TokenProvider")
    assert JsPN532TokenProvider.exists() == True
    JsPN532TokenProvider_cm = JsPN532TokenProvider / cmake
    assert JsPN532TokenProvider_cm.exists() == True
    assert module_path.exists() == True

    # OK to copy from JsPN532TokenProvider, because CMakeLists.txt is
    # dynamic and it will infer the module's name from the directory that it resides in.
    module_cm = module_path / cmake
    shutil.copy(str(JsPN532TokenProvider_cm), str(module_cm))
    assert module_cm.exists() == True
    return module_cm


def path_to_name(path):
    assert path.exists() == True
    return path.name


def get_config_file_name(module_path):
    module_name = path_to_name(module_path)
    config_name = module_name[0].lower()
    if len(module_name) > 1:
        for char in module_name[1:]:
            if char.isupper():
                config_name += "-" + char.lower()
            else:
                config_name += char
    return Path(config_name + ".json")


def get_module_id(module_path):
    module_name = path_to_name(module_path)
    out_id = module_name[0].lower()
    if len(module_name) > 1:
        for char in module_name[1:]:
            if char.isupper():
                out_id += "_" + char.lower()
            else:
                out_id += char
    return out_id


def create_config_file_js(workspace, file_path):
    config_dir = workspace / Path("everest-core/config")
    config_dir.mkdir(parents=True, exist_ok=True)
    assert config_dir.exists() == True

    config_path = config_dir / get_config_file_name(file_path)
    print(config_path)

    # ~/checkout/everest-workspace/everest-core/config/<config-file>.json
    raise Exception("not yet implemented")


def get_path_content(json_path):
    print(json_path)
    with open(json_path, "r") as f:
        content = json.load(f)
    f.close()
    return content

def write_path_content(json_path, content):
    print(content)
    with open(json_path, "w") as f:
        json.dump(content, f)
    f.close()


def extend_config_file_js(
    workspace, config_data, file_path, config_file_name="config-hil.json"
):
    config_dir = workspace / Path("everest-core/config")
    assert config_dir.exists() == True

    config_path = config_dir / Path(config_file_name)
    assert config_path.exists() == True

    existing_content = get_path_content(config_path)
    config = ModuleConfig(config_data)
    existing_content[config_data["new_module_id"]] = config.get_content()
    write_path_content(config_path, existing_content)
    print("config_path: " + str(config_path))
    # print(existing_content)

    # ~/checkout/everest-workspace/everest-core/config/<config-file>.json
    raise Exception("not yet implemented")


def code_file_js():
    raise Exception("not yet implemented")


def interface_file_js():
    raise Exception("not yet implemented")


def manifest_file_js():
    raise Exception("not yet implemented")


def dependency_file_js():
    raise Exception("not yet implemented")


def cmake_lists_all_js():
    raise Exception("not yet implemented")


def parse_args():
    mdata = {}
    if sys.argv[1][0].lower() == "t":
        mdata["js"] = True
    elif sys.argv[1][0].lower() == "f":
        mdata["js"] = False
    else:
        raise Exception("invalid input: " + str(sys.argv[1]))

    mdata["workspace"] = Path(sys.argv[2])
    if not mdata["workspace"].exists():
        raise Exception("Invalid path: " + str(mdata["workspace"]))

    mdata["modules"] = Path(mdata["workspace"]) / Path("everest-core/modules")
    assert mdata["modules"].exists() == True

    mdata["mpath"] = module_path(
        mdata["modules"], module_name(mdata["js"], sys.argv[3])
    )

    config_data = {
        "new_module_id": get_module_id(mdata["mpath"]),
        "new_module_name": path_to_name(mdata["mpath"]),
        "connection_name": "yetipowermeter",
        "other_module_id": "yeti_driver",
        "other_module_submodule_id": "powermeter",
        "new_submodule_id": "main",
        "config_key": "sim_value",
        "config_value": 5000,
    }

    if mdata["js"]:
        mdata["CMakeLists.txt"] = set_cmake_lists_js(mdata["modules"], mdata["mpath"])
        mdata["ConfigFile"] = extend_config_file_js(
            mdata["workspace"], config_data, mdata["mpath"]
        )
        mdata["ModulesCodeFile"] = code_file_js()
        mdata["InterfaceFile"] = interface_file_js()
        mdata["ManifestFile"] = manifest_file_js()
        mdata["JSPackageDepFile"] = dependency_file_js()
        mdata["CMakeLists.txtAll"] = cmake_lists_all_js()
    else:
        raise Exception("not impelemented yet")

    derrived_fields = [
        "CMakeLists.txt",
        "ConfigFile",
        "ModulesCodeFile",
        "InterfaceFile",
        "ManifestFile",
        "JSPackageDepFile",
        "CMakeLists.txtAll",
    ]

    # Confirm that all derived fields have been set deliberately.
    data_keys = set(mdata.keys())
    for field in derrived_fields:
        assert field in data_keys

    return mdata


write_module(parse_args())
