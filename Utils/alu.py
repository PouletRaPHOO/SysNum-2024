from lib_carotte import *
from Utils.utils import *

def Alu(is_ari, is_bool, is_cmp, unary, add_code, arg1, arg2):
    bit0 = Constant("0")


    _,e1,e2,_,_,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)

    reel_arg2 = Mux(is_cmp|(is_ari&e2), oppose(arg2), arg2)

    s_op, c_op = n_adder(arg1, reel_arg2)
    s_mul, c_mul = Constant("0"*32), bit0
    # temp_mul, ctemp_mul = arg2, Constant("0")
    # for i in range(32):
    #     ctemp_mul, temp_mul = sll(temp_mul)
    #     c_mul = Or(c_mul, ctemp_mul)
    #     sadd_mul, ctempadd_mul = n_adder(s_mul, temp_mul)
    #     s_mul, ctemp_mul = Mux(arg1[i], sadd_mul, s_mul), Mux(arg1[i], ctempadd_mul, ctemp_mul)
    #     c_mul = Or(c_mul, ctemp_mul)
    
    r_and = And(arg1, arg2)

    r_or = Or(arg1, arg2)

    r_xor = Xor(arg1, arg2)

    not_arg = Not(arg1)

    srl_arg = srl(arg1)

    of_sll, sll_arg = sll(arg1)



    ari_mux_val = Mux(e1|e2, s_op, s_mul)
    ari_mux_of = Mux(e1|e2, c_op, c_mul)

    bool_mux_val = Mux(e1, r_and, Mux(e2, r_or, r_xor))


    unary_mux_val = Mux(e1, not_arg, Mux(e2, sll_arg, srl_arg))
    unary_mux_of = Mux(e1|e2, bit0, of_sll)

    val_final = Mux(is_ari|is_cmp, ari_mux_val, Mux(is_bool, bool_mux_val, unary_mux_val))
    zf_final = is_zero(val_final)
    sf_final = val_final[0]

    return (val_final,
            Mux(is_ari|is_cmp, ari_mux_of, Mux(is_bool, bit0, unary_mux_of)),
            zf_final,
            sf_final)




    # _,is_add,is_sub,is_mul,_,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)
    # if is_add & is_ari:
    #     s,c = n_adder(arg1,arg2)
    #     return (s, c, is_zero(s), s[0])
    # if is_sub & is_ari:
    #     s,c = n_adder(arg1, oppose(arg2))
    #     return (s, c, is_zero(s), s[0])
    # if is_mul & is_ari:
    #     s, c = Constant("0"*32), Constant("0")
    #     temp, ctemp = Constant("0"*32), Constant("0")
    #     for i in range(32):
    #         if arg1[0]:
    #             ctemp, temp = sll(arg2, i)
    #             c = Or(c, ctemp)
    #             s, ctemp = n_adder(s, temp)
    #             c = Or(c, ctemp)
    #     return (s, c, is_zero(s), s[0])
            
    # if is_add & is_bool:
    #     r  = And(arg1, arg2)
    #     of = Constant("0")
    #     zf = Constant("0")
    #     if r == Constant("0"):
    #         zf = Constant("1")
    #     sf = r[0]
    #     return (And(arg1,arg2), of, zf, sf) 
    # if is_sub  & is_bool :
    #     r  = And(arg1, arg2)
    #     of = Constant("0")
    #     zf = Constant("0")
    #     if r == Constant("0"):
    #         zf = Constant("1")
    #     sf = r[0]
    #     return (Or(arg1,arg2), of, zf, sf)
    # if is_mul & is_bool:
    #     r  = And(arg1, arg2)
    #     of = Constant("0")
    #     zf = Constant("0")
    #     if r == Constant("0"):
    #         zf = Constant("1")
    #     sf = r[0]
    #     return (Xor(arg1,arg2), of, zf, sf)
        
    # if is_add & is_cmp:
    #     s,c = n_adder(arg1, oppose(arg2))
    #     return (s, c, is_zero(s), s[0])
    
    # if is_add & unary:
    #     not_arg = Not(arg1)
    #     return (not_arg, Constant("0"), is_zero(not_arg), s[0])
    # if is_mul & unary:
    #     srl_arg = srl(arg1,1)
    #     return (srl_arg, Constant("0"), is_zero(not_arg), s[0])
    # if is_sub & unary:
    #     of, res = sll(arg1, 1)
    #     return (res, of, is_zero(res), res[0])
