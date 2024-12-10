from lib_carotte import *

def update_registers(arg1, arg2, new_write):
    return Mux(new_write, arg1, arg2)


    