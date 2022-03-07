class ModulePkgDep:
    def __init__(self, dependency_vars):
        self.dependency_vars = dependency_vars
        self.dependency_content = self.generate_dependency_content()

    def generate_dependency_content(self):
        dependencies = {"dependencies": self.dependency_vars}

        return dependencies

    def get_dependency_contnent(self):
        return self.dependency_content
