class ModuleInterface:
    def __init__(self, interface_vars):
        self.interface_vars = interface_vars
        self.interface_content = self.generate_interface_content()

    def generate_interface_content(self):
        pass
