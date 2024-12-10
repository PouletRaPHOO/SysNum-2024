from lib_carotte import *

def mux2(bit_array):
    x1 = bit_array[0]
    x2 = bit_array[1]
    return (And(Not(x1), Not(x2)),
            And(Not(x1), x2),
            And(x1, Not(x2)),
            And(x1, x2))

def mux4(bit_array):
    x1 = Slice(0,2, bit_array)
    x2 = Slice(2,4, bit_array)
    x10, x11, x12, x13 = mux2(x1)
    x20, x21, x22, x23 = mux2(x2)
    return (And(x10, x21),
            And(x10, x21),
            And(x10, x22),
            And(x10, x23),
            And(x11, x21),
            And(x11, x21),
            And(x11, x22),
            And(x11, x23),
            And(x12, x21),
            And(x12, x21),
            And(x12, x22),
            And(x12, x23),
            And(x13, x21),
            And(x13, x21),
            And(x13, x22),
            And(x13, x23))

def or4(x1, x2, x3, x4):
    return Or(Or(x3,x4),Or(x1, x2))

def or6(x1, x2, x3, x4, x5, x6):
    return Or(Or(x1, x2), or4(x3, x4, x5, x6))