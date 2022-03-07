class ModuleManifest:
    def __init__(self, manifest_vars):
        self.manifest_vars = manifest_vars
        self.manifest_content = self.generate_manifest_content()

    def generate_manifest_content(self):
        provides = {
            self.manifest_vars["new_submodule_id"]: {
                "description": self.manifest_vars["description_of_submodule"],
                "interface": self.manifest_vars["interface_name"],
                "config": {
                    "description": self.manifest_vars["intention_of_value"],
                    "type": self.manifest_vars["value_type"],
                    self.manifest_vars["optional_type_specific"]: self.manifest_vars[
                        "optional_value"
                    ],
                },
            }
        }

        manifest = {
            "description": self.manifest_vars["description"],
            "provides": provides,
            "metadata": {
                "license": self.manifest_vars["license_url"],
                "authors": [
                    self.manifest_vars["author_name"],
                    self.manifest_vars["other_author"],
                ],
            },
            "enable_external_mqtt": "false",
        }

        return manifest

    def get_manifest_content(self):
        return self.manifest_content
