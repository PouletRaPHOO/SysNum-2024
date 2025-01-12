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
    return x10&x20, x10&x21,x10&x22, x10&x23,x11&x20, x11& x21,x11&x22, x11&x23, x12&x20, x12&x21, x12&x22, x12&x23, x13&x20, x13&x21, x13&x22, x13& x23

def or4(x1, x2, x3, x4):
    return (x3 |x4) | (x1 | x2)

def or6(x1, x2, x3, x4, x5, x6):
    return (x1 | x2) | or4(x3, x4, x5, x6)

def or8(x1,x2,x3,x4,x5,x6,x7,x8):
    return Or(or4(x1,x2,x3,x4),or4(x5,x6,x7,x8))

def full_adder(a, b, c):
    tmp = a ^ b
    return (tmp ^ c, (tmp & c) | (a & b))

def n_adder(a, b):
    assert(a.bus_size == b.bus_size)
    c = Constant("0")
    (s, c) = full_adder(a[a.bus_size - 1], b[a.bus_size - 1], c) # Treat the 0 case separately since variables have a bus size >= 1
    for i in range(2, a.bus_size + 1):
        (s_i, c) = full_adder(a[a.bus_size - i], b[a.bus_size - i], c)
        s = s_i + s
    return (s, c)

def is_zero(a):
    zf = Constant("0")
    return Not(a[0] | a[1] | a[2] | a[3] | a[4] | a[5] | a[6] | a[7] | a[8] | a[9] |
               a[10] | a[11] | a[12] | a[13] | a[14] | a[15] | a[16] | a[17] | a[18] | a[19] |
               a[20] | a[21] | a[22] | a[23] | a[24] | a[25] | a[26] | a[27] | a[28] | a[29] |
               a[30] | a[31])

def bin_to_int(a):
    k = len(a)
    s = 0
    for i in range(k):
        s += a[i]*(2**(k-i-1))
    return s
    
def oppose(a):
    not_a = Not(a)
    s,_ = n_adder(not_a, Constant(Un))
    return s

def sll(a):
    c = Constant("0")
    a, ctemp = n_adder(a, a)
    c = c | ctemp
    return (c, a)

def srl(a):
    return Slice(0, a.bus_size, Mux(a[0], Concat(Constant("1"), a), Concat(Constant("0"), a)))
