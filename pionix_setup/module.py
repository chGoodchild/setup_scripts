#!/usr/bin/python3
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

        config_variables = {
            "new_module_id": get_module_id(self.mdata["mpath"]),
            "new_module_name": path_to_name(self.mdata["mpath"]),
            "connection_name": "yetipowermeter",
            "other_module_id": "yeti_driver",
            "other_module_submodule_id": "powermeter",
            "new_submodule_id": "main",
            "config_key": "sim_value",
            "config_value": 5000,
        }

        if self.mdata["js"]:
            self.mdata["CMakeLists.txt"] = self.set_cmake_lists_js(
                self.mdata["modules"], self.mdata["mpath"]
            )
            self.mdata["ConfigFile"] = self.extend_config_file_js(
                self.mdata["workspace"], config_variables
            )
            self.mdata["InterfaceFile"] = self.interface_file_js()
            self.mdata["ManifestFile"] = manifest_file_js()
            self.mdata["JSPackageDepFile"] = dependency_file_js()
            self.mdata["CMakeLists.txtAll"] = cmake_lists_all_js()
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

    # TODO: Am I extending the right JSON file?
    def extend_config_file_js(
        self, workspace, config_variables, config_file_name="config-hil.json"
    ):
        config_dir = workspace / Path("everest-core/config")
        assert config_dir.exists() == True

        config_path = config_dir / Path(config_file_name)
        assert config_path.exists() == True

        existing_content = get_path_content(config_path)
        config = ModuleConfig(config_variables)
        existing_content[config_variables["new_module_id"]] = config.get_content()
        write_path_content(config_path, existing_content)

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

    def interface_file_js(self):
        raise Exception("not yet implemented")
