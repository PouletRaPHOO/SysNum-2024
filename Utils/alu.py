from lib_carotte import *
from Utils.utils import *
#feur

def Alu(is_ari, is_bool, is_cmp, add_code, arg1, arg2):
    if is_ari:
        _,is_add,is_sub,is_mul,_,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)
        if is_add:
            s,c = n_adder(arg1,arg2)
            return (s, c, is_zero(s), s[0])
        if is_sub:
            s,c = n_adder(arg1, oppose(arg2))
            return (s, c, is_zero(s), s[0])
        if is_mul:
            s,c = Constant("0"), Constant("0")
            
    elif is_bool:
        _,is_and,is_or,is_xor,_,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)
        if is_and:
            return And(arg1,arg2)
        elif is_or:
            return Or(arg1,arg2)
        elif is_xor:
            return Xor(arg1,arg2)
    