from module import *
import sys

"""
def write_module(mdata):
    print(mdata)

    mdata = {}
    mdata[name] = module_name(js, module)
    mdata[modules] = Path(mdata["workspace"]) / Path("everest-core/modules")

    print(mdata)

write_module(parse_args())

"""

module = ModuleJS(args=sys.argv)
