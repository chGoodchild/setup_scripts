#!/usr/bin/python3
from module_package_dependencies import *
from module_interface import *
from module_manifest import *
from module_config import *
from helpers import *
import copy as copy


class ModuleJS:

    def parse_args(self, args):
        self.mdata = {}
        if args[1][0].lower() == "t":
            self.mdata["js"] = True
        elif args[1][0].lower() == "f":
            self.mdata["js"] = False
        else:
            raise Exception("invalid input: " + str(args[1]))

        self.mdata["workspace"] = Path(args[2])
        if not self.mdata["workspace"].exists():
            raise Exception("Invalid path: " + str(self.mdata["workspace"]))

        self.mdata["modules"] = Path(self.mdata["workspace"]) / Path(
            "everest-core/modules"
        )
        assert self.mdata["modules"].exists() == True

        self.mdata["mpath"] = module_path(
            self.mdata["modules"], module_name(self.mdata["js"], args[3])
        )

        if len(args) > 4:
            self.mdata["command"] = args[4]
        else:
            self.mdata["command"] = None

        if len(args) > 5:
            self.mdata["arg1"] = args[5]
        else:
            self.mdata["arg1"] = None

    def check_data_completeness(self):
        derrived_fields = [
            "CMakeLists.txt",
            "ConfigFile",
            "UserConfigFile",
            "ModulesCodeFile",
            "InterfaceFile",
            "ManifestFile",
            "JSPackageDepFile",
            "CMakeLists.txt_global",
        ]

        # Confirm that all derived fields have been set deliberately.
        data_keys = set(self.mdata.keys())
        for field in derrived_fields:
            try:
                assert field in data_keys
            except:
                raise Exception("Failed to find the field; ", field)

    def generate_new(self):
        if self.mdata["js"]:
            self.extend_user_config_file_js()
            self.create_interface_file_js(
                self.mdata["workspace"],
            )
            self.create_manifest_file_js()
            self.create_package_dep_js()
            self.create_cmake_lists_js()
            self.global_cmake_lists()
            self.code_file_js()
        else:
            raise Exception("not impelemented yet")

        self.check_data_completeness()

    def modify(self):
        raise Exception("Not implemented yet")

    def get_path(self):
        if self.mdata["arg1"] in set(self.mdata.keys()):
            return self.mdata[self.mdata["arg1"]]
        else:
            raise Exception("Unknown input")

    def construct_paths(self):
        self.set_config_path()
        self.set_interface_path(self.mdata["workspace"])
        self.set_index_path()
        self.set_manifest_path()
        self.set_js_package_path()
        self.set_cmake_lists_js()
        self.global_cmake_lists()

    def __init__(self, args):
        self.parse_args(args)
        if self.mdata["command"] == "new":
            self.generate_new()
        else:
            self.construct_paths()
        self.check_data_completeness()

    def react(self):
        if self.mdata["command"] == "modify":
            self.modify()

        if self.mdata["command"] == "get_path":
            return self.get_path()

    def set_js_package_path(self):
        assert self.mdata["mpath"].exists() == True
        self.mdata["JSPackageDepFile"] = self.mdata["mpath"] / Path("package.json")

    def create_package_dep_js(self):
        self.set_js_package_path()
        dep_vars = ModulePkgDep(dependency_vars={})
        dep_vars.get_dependency_contnent()
        write_path_content(self.mdata["JSPackageDepFile"], dep_vars.get_dependency_contnent())

    def set_manifest_path(self):
        assert self.mdata["mpath"].exists() == True
        self.mdata["ManifestFile"] = self.mdata["mpath"] / Path("manifest.json")

    def create_manifest_file_js(self):
        manifest = ModuleManifest(
            manifest_vars={
                "description": "manifest for test module",
                "new_submodule_id": "main",
                "description_of_submodule": "test submodule for manifest",
                "interface_name": str(
                    self.mdata["InterfaceFile"].name
                ),  # Must be equal to interface file's name!
                "config_key": "sim_value",
                "intention_of_value": "test value for a test file",
                "value_type": "number",
                "optional_type_specific": None,
                "optional_value": None,
                "license_url": "license_url",
                "author_name": "author name",
                "other_author": "other author name",
            }
        )

        manifest.get_manifest_content()
        self.set_manifest_path()
        write_path_content(self.mdata["ManifestFile"], manifest.get_manifest_content())
        assert self.mdata["ManifestFile"].exists() == True


    def set_interface_path(self, workspace):
        interface_name = get_module_id(self.mdata["mpath"]) + ".json"
        interface_dir = workspace / Path("everest-core/interfaces")
        assert interface_dir.exists() == True
        self.mdata["InterfaceFile"] = interface_dir / Path(interface_name)

    def create_interface_file_js(self, workspace):

        interface = ModuleInterface(
            interface_vars={
                "description": "this is an interface for a test module",
                "variable_name": path_to_name(self.mdata["mpath"]),
                "variable_intention": "testing variables in the test interface with a test module",
                "variable_type": "string",
                "type_options": None,
                "type_option_value": None,
                "default_value": None,
                "function_name": "test_function",
                "function_description": "testing variables in the test interface with a test module",
                "argument_val_name": "test_argument",
                "argument_val_intention": "test argument for a test function",
                "value_type": "boolean",
            }
        )

        self.set_interface_path(workspace)
        write_path_content(self.mdata["InterfaceFile"], interface.get_interface_content())

    def set_config_path(self, config_file_name="config-sil.json"):
        user_config_dir = self.mdata["workspace"] / Path("everest-core/config/user-config")

        assert user_config_dir.exists() == True
        config_dir = self.mdata["workspace"] / Path("everest-core/config/")
        assert config_dir.exists() == True

        config_source = config_dir / Path(config_file_name)
        assert config_source.exists() == True

        self.mdata["UserConfigFile"] = user_config_dir / Path(config_file_name)
        self.mdata["ConfigFile"] = config_source



    # TODO: Am I extending the right JSON file?
    def extend_user_config_file_js(self, use_empty=True):
        self.set_config_path()

        existing_content = {}
        if not self.mdata["UserConfigFile"].exists() and not use_empty:
            shutil.copy(str(self.mdata["ConfigFile"]), str(self.mdata["UserConfigFile"]))
            existing_content = get_path_content(self.mdata["UserConfigFile"])
        elif not self.mdata["UserConfigFile"].exists() and use_empty:
            existing_content = {}
        else:
            existing_content = get_path_content(self.mdata["UserConfigFile"])

        config = ModuleConfig(
            config_vars={
                "new_module_name": path_to_name(self.mdata["mpath"]),
                "connection_name": "yetipowermeter",
                "other_module_id": "yeti_driver",
                "other_module_submodule_id": "powermeter",
                "new_submodule_id": "main",
                "config_key": "sim_value",
                "config_value": 5000,
            }
        )
        existing_content[get_module_id(self.mdata["mpath"])] = config.get_content()
        write_path_content(self.mdata["UserConfigFile"], existing_content)
        return self.mdata["UserConfigFile"]

    def get_index(self, list, element):
        for index, el in enumerate(list):
            if element == el:
                return index
        return None

    def set_cmake_lists_js(self):
        self.mdata["CMakeLists.txt"] = self.mdata["mpath"] / Path("CMakeLists.txt")

    def create_cmake_lists_js(self):
        self.set_cmake_lists_js()
        # OK to copy from JsPN532TokenProvider, because CMakeLists.txt is
        # dynamic and it will infer the module's name from the directory that it resides in.
        shutil.copy(str(self.mdata["modules"] / Path("JsPN532TokenProvider/CMakeLists.txt")), str(self.mdata["CMakeLists.txt"]))

    def global_cmake_lists(self):
        cmake_path = self.mdata["modules"] / Path("CMakeLists.txt")
        assert cmake_path.exists() == True

        new_string = "    " + str(self.mdata["mpath"].name)

        outlist = []
        with open(cmake_path, "r") as reader:
            lines = reader.read().split("\n")
            if self.get_index(lines, new_string) == None:
                idx = self.get_index(lines, "list(APPEND EVEREST_MODULES_LIST")
                for element in lines[: idx + 1]:
                    outlist.append(element)
                outlist.append(new_string)
                for element in lines[idx + 1 :]:
                    outlist.append(element)
            else:
                outlist = lines

        joined_string = "\n".join(outlist)

        with open(cmake_path, "w") as text_file:
            text_file.write(joined_string)
        self.mdata["CMakeLists.txt_global"] = cmake_path

    def set_index_path(self):
        property = Path("index.js")
        source_path = get_source_path(self.mdata["modules"], property)
        assert self.mdata["mpath"].exists() == True
        self.mdata["ModulesCodeFile"] = self.mdata["mpath"] / property
        return source_path

    def code_file_js(self):
        source_path = self.set_index_path()
        shutil.copy(str(source_path), str(self.mdata["ModulesCodeFile"]))
        assert self.mdata["ModulesCodeFile"].exists() == True

