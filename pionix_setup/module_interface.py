class ModuleInterface:
    def __init__(self, interface_vars):
        self.interface_vars = interface_vars
        self.interface_content = self.generate_interface_content()

    def generate_vars(self):
        var = {
            "description": self.interface_vars["variable_intention"],
            "type": self.interface_vars["variable_type"],
            "default": self.interface_vars["default_value"],
        }

        if self.interface_vars["type_options"] != None:
            var[self.interface_vars["type_options"]] = self.interface_vars[
                "type_option_value"
            ]

        vars = {self.interface_vars["variable_name"]: var}

        return vars

    def generate_cmds(self):

        args = {
            self.interface_vars["argument_val_name"]: {
                "description": self.interface_vars["argument_val_intention"],
                "type": self.interface_vars["value_type"],
            }
        }

        cmd = {
            "description": self.interface_vars["function_description"],
            "arguments": args,
        }

        cmds = {self.interface_vars["function_name"]: cmd}
        return cmds

    def generate_interface_content(self):
        content = {
            "description": self.interface_vars["description"],
            "vars": self.generate_vars(),
            "cmds": self.generate_cmds(),
        }

        return content

    def get_interface_content(self):
        return self.interface_content
