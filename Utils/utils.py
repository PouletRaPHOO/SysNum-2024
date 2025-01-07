from lib_carotte import *

Un = "00000000000000000000000000000001"

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
    return (And(x10, x20),
            And(x10, x21),
            And(x10, x22),
            And(x10, x23),
            And(x11, x20),
            And(x11, x21),
            And(x11, x22),
            And(x11, x23),
            And(x12, x20),
            And(x12, x21),
            And(x12, x22),
            And(x12, x23),
            And(x13, x20),
            And(x13, x21),
            And(x13, x22),
            And(x13, x23))

def or4(x1, x2, x3, x4):
    return Or(Or(x3,x4),Or(x1, x2))

def or6(x1, x2, x3, x4, x5, x6):
    return Or(Or(x1, x2), or4(x3, x4, x5, x6))

def or8(x1,x2,x3,x4,x5,x6,x7,x8):
    return Or(or4(x1,x2,x3,x4),or4(x5,x6,x7,x8))

def full_adder(a, b, c):
    tmp = a ^ b
    return (tmp ^ c, (tmp & c) | (a & b))

def n_adder(a, b):
    assert(a.bus_size == b.bus_size)
    c = Constant("0")
    (s, c) = full_adder(a[0], b[0], c) # Treat the 0 case separately since variables have a bus size >= 1
    for i in range(1, a.bus_size):
        (s_i, c) = full_adder(a[i], b[i], c)
        s = s + s_i
    return (s, c)

def is_zero(a):
    if a == Constant("0"):
        return Un
    else : return Constant("0")

def bin_to_int(a):
    k = len(a)
    s = 0
    for i in range(k):
        s += a[i]*(2**(k-i-1))
    return s
    
def oppose(a):
    not_a = Not(a)
    return n_adder(not_a, Un)