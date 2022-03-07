#!/usr/bin/python3
from module_package_dependencies import *
from module_interface import *
from module_manifest import *
from module_config import *
from helpers import *
import copy as copy


class ModuleJS:
    def __init__(self, args):
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

        if self.mdata["js"]:
            self.mdata["CMakeLists.txt"] = self.set_cmake_lists_js(
                self.mdata["modules"], self.mdata["mpath"]
            )
            self.mdata["ConfigFile"] = self.extend_user_config_file_js(
                self.mdata["workspace"],
            )
            self.mdata["InterfaceFile"] = self.create_interface_file_js(
                self.mdata["workspace"],
            )
            self.mdata["ManifestFile"] = self.create_manifest_file_js(
                self.mdata["workspace"], self.mdata["InterfaceFile"]
            )
            self.mdata["JSPackageDepFile"] = self.create_package_dep_js(
                self.mdata["workspace"]
            )
            self.mdata["CMakeLists.txtAll"] = self.modify_cmake_lists(
                self.mdata["workspace"], self.mdata["mpath"]
            )
            self.mdata["ModulesCodeFile"] = self.code_file_js(
                self.mdata["modules"], self.mdata["mpath"]
            )
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
        data_keys = set(self.mdata.keys())
        for field in derrived_fields:
            assert field in data_keys

    def set_cmake_lists_js(self, modules, module_path):
        return copy_module_property(
            modules, module_path, property=Path("CMakeLists.txt")
        )

    def create_package_dep_js(self, workspace):
        dep_vars = ModulePkgDep(dependency_vars={})
        dep_vars.get_dependency_contnent()
        module_dir = workspace / Path("everest-core/modules")
        assert module_dir.exists() == True
        dep_vars_path = module_dir / Path("package.json")
        write_path_content(dep_vars_path, dep_vars.get_dependency_contnent())
        return dep_vars_path

    def create_manifest_file_js(self, workspace, interface_file):
        manifest = ModuleManifest(
            manifest_vars={
                "description": "manifest for test module",
                "new_submodule_id": "main",
                "description_of_submodule": "test submodule for manifest",
                "interface_name": str(
                    interface_file.name
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
        module_dir = workspace / Path("everest-core/modules")
        assert module_dir.exists() == True
        manifest_path = module_dir / Path("manifest.json")
        write_path_content(manifest_path, manifest.get_manifest_content())
        return manifest_path

    def create_interface_file_js(self, workspace):
        interface_name = get_module_id(self.mdata["mpath"]) + ".json"

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
        interface_dir = workspace / Path("everest-core/interfaces")
        assert interface_dir.exists() == True
        interface_path = interface_dir / Path(interface_name)
        write_path_content(interface_path, interface.get_interface_content())
        return interface_path

    # TODO: Am I extending the right JSON file?
    def extend_user_config_file_js(self, workspace, config_file_name="config-sil.json"):
        user_config_dir = workspace / Path("everest-core/config/user-config")
        assert user_config_dir.exists() == True
        config_dir = workspace / Path("everest-core/config/")
        assert config_dir.exists() == True

        config_path = config_dir / Path(config_file_name)
        assert config_path.exists() == True

        user_config_path = user_config_dir / Path(config_file_name)
        shutil.copy(str(config_path), str(user_config_path))

        existing_content = get_path_content(user_config_path)

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
        write_path_content(user_config_path, existing_content)
        return user_config_path

    def get_index(self, list, element):
        for index, el in enumerate(list):
            if element == el:
                return index
        return None

    def modify_cmake_lists(self, workspace, module_path):
        cmake_path = workspace / Path("everest-core/modules/CMakeLists.txt")
        assert cmake_path.exists() == True

        new_string = "    " + str(module_path.name)

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

        return cmake_path

    def code_file_js(self, modules, module_path):
        new_path = copy_module_property(modules, module_path, property=Path("index.js"))
        done = False
        while not done:
            print(
                "Are you done adapting the logic of your new module in "
                + str(new_path)
                + "? [Y / N]"
            )
            response = input()
            if response[0].lower() == "y":
                done = True
        return new_path
