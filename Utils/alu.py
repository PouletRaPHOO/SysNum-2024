from lib_carotte import *
from Utils.utils import *

def Alu(is_ari, is_bool, is_cmp, unary, add_code, arg1, arg2):
    if is_ari:
        _,is_add,is_sub,is_mul,_,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)
        if is_add:
            s,c = n_adder(arg1,arg2)
            return (s, c, is_zero(s), s[0])
        if is_sub:
            s,c = n_adder(arg1, oppose(arg2))
            return (s, c, is_zero(s), s[0])
        if is_mul:
            s, c = Constant("0"*32), Constant("0")
            temp, ctemp = Constant("0"*32), Constant("0")
            for i in range(32):
                if arg1[0]:
                    ctemp, temp = sll(arg2, i)
                    c = Or(c, ctemp)
                    s, ctemp = n_adder(s, temp)
                    c = Or(c, ctemp)
            return (s, c, is_zero(s), s[0])
            
    elif is_bool:
        _,is_and,is_or,is_xor,_,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)
        if is_and:
            r  = And(arg1, arg2)
            of = Constant("0")
            zf = Constant("0")
            if r == Constant("0"):
                zf = Constant("1")
            sf = r[0]
            return (And(arg1,arg2), of, zf, sf) 
        elif is_or:
            r  = And(arg1, arg2)
            of = Constant("0")
            zf = Constant("0")
            if r == Constant("0"):
                zf = Constant("1")
            sf = r[0]
            return (Or(arg1,arg2), of, zf, sf)
        elif is_xor:
            r  = And(arg1, arg2)
            of = Constant("0")
            zf = Constant("0")
            if r == Constant("0"):
                zf = Constant("1")
            sf = r[0]
            return (Xor(arg1,arg2), of, zf, sf)
        
    elif is_cmp:
        _,is_true,_,_,_,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)
        if is_true:
            s,c = n_adder(arg1, oppose(arg2))
            return (s, c, is_zero(s), s[0])
    
    elif unary:
        _,is_not, is_sll, is_srl,_,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)
        if is_not:
            not_arg = Not(arg1)
            return (not_arg, Constant("0"), is_zero(not_arg), s[0])
        if is_srl:
            srl_arg = srl(arg1,1)
            return ()
        if is_sll:
            of, res = sll(arg1, 1)
            return (res, of, is_zero(res), res[0])
