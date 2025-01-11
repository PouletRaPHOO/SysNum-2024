from lib_carotte import *
from Utils.utils import *

def Alu(is_ari, is_bool, is_cmp, unary, add_code, arg1, arg2):
    s_add, c_add = n_adder(arg1, arg2)
    s_sub, c_sub = n_adder(arg1, arg2)
    s_mul, c_mul = Constant("0"*32), Constant("0")
    temp_mul, ctemp_mul = Constant("0"*32), Constant("0")
    for i in range(32):
        pass
    
    r_and = And(arg1, arg2)
    of_and = Constant("0")
    zf_and = Mux(r_and, Constant("0"), Constant("1"))
    sf_and = r[0]
    
    

    _,is_add,is_sub,is_mul,_,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)
    if is_add & is_ari:
        s,c = n_adder(arg1,arg2)
        return (s, c, is_zero(s), s[0])
    if is_sub & is_ari:
        s,c = n_adder(arg1, oppose(arg2))
        return (s, c, is_zero(s), s[0])
    if is_mul & is_ari:
        s, c = Constant("0"*32), Constant("0")
        temp, ctemp = Constant("0"*32), Constant("0")
        for i in range(32):
            if arg1[0]:
                ctemp, temp = sll(arg2, i)
                c = Or(c, ctemp)
                s, ctemp = n_adder(s, temp)
                c = Or(c, ctemp)
        return (s, c, is_zero(s), s[0])
            
    if is_add & is_bool:
        r  = And(arg1, arg2)
        of = Constant("0")
        zf = Constant("0")
        if r == Constant("0"):
            zf = Constant("1")
        sf = r[0]
        return (And(arg1,arg2), of, zf, sf) 
    if is_sub  & is_bool :
        r  = And(arg1, arg2)
        of = Constant("0")
        zf = Constant("0")
        if r == Constant("0"):
            zf = Constant("1")
        sf = r[0]
        return (Or(arg1,arg2), of, zf, sf)
    if is_mul & is_bool:
        r  = And(arg1, arg2)
        of = Constant("0")
        zf = Constant("0")
        if r == Constant("0"):
            zf = Constant("1")
        sf = r[0]
        return (Xor(arg1,arg2), of, zf, sf)
        
    if is_add & is_cmp:
        s,c = n_adder(arg1, oppose(arg2))
        return (s, c, is_zero(s), s[0])
    
    if is_add & unary:
        not_arg = Not(arg1)
        return (not_arg, Constant("0"), is_zero(not_arg), s[0])
    if is_mul & unary:
        srl_arg = srl(arg1,1)
        return (srl_arg, Constant("0"), is_zero(not_arg), s[0])
    if is_sub & unary:
        of, res = sll(arg1, 1)
        return (res, of, is_zero(res), res[0])
