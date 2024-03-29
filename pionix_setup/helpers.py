from pathlib import Path
import sys, shutil, json


def module_path(modules, module_name):
    path = modules / module_name
    path.mkdir(parents=True, exist_ok=True)
    assert path.exists() == True
    return path


def module_name(js, module):
    name = ""
    if js:
        name = "Js" + module[0].upper()
    else:
        name = module[0].upper()

    if len(module) > 1:
        name += module[1:]
    return name


def path_to_name(path):
    assert path.exists() == True
    return path.name


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


def get_path_content(json_path):
    with open(json_path, "r") as f:
        content = json.load(f)
    f.close()
    return content


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


def write_path_content(json_path, content):
    with open(json_path, "w") as f:
        json.dump(content, f)
    f.close()

def get_source_path_js(modules, property):
    JsPN532TokenProvider = modules / Path("JsPN532TokenProvider")
    assert JsPN532TokenProvider.exists() == True
    property_path = JsPN532TokenProvider / property
    assert property_path.exists() == True
    return property_path


def get_source_path_cpp(modules, property):

    raise Exception("Stop here")
    JsPN532TokenProvider = modules / Path("JsPN532TokenProvider")
    assert JsPN532TokenProvider.exists() == True
    property_path = JsPN532TokenProvider / property
    assert property_path.exists() == True
    return property_path
