from lib_carotte import *

def slicer(bit_array):
    x = Slice(0, 4, bit_array)
    y = Slice(4, 24, bit_array)
    return (x,y)
