class ModuleConfig:
    def __init__(self, config_vars):
        self.config_vars = config_vars
        self.module_content = self.generate_module_content()

    def get_connection(self):
        connection = {}
        connection["module_id"] = self.config_vars["other_module_id"]
        connection["implementation_id"] = self.config_vars["other_module_submodule_id"]
        return connection

    def get_connections(self, connection):
        connections = {}
        connections[self.config_vars["connection_name"]] = connection
        return connections

    def get_config_implementation(self, submodule):
        config_implementation = {}
        config_implementation[self.config_vars["new_submodule_id"]] = submodule
        return config_implementation

    def get_submodule_id(self):
        submodule_id = {}
        submodule_id[self.config_vars["config_key"]] = self.config_vars["config_value"]
        return submodule_id

    def generate_module_content(self):
        module_content = {}
        module_content["module"] = self.config_vars["new_module_name"]
        module_content["connections"] = self.get_connections(self.get_connection())
        module_content["config_implementation"] = self.get_config_implementation(
            self.get_submodule_id()
        )
        return module_content

    def get_content(self):
        return self.module_content
