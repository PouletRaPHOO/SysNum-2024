from lib_carotte import *
from Utils.utils import *

def Alu(is_ari, is_bool, is_cmp, unary, add_code, arg1, arg2):
    s_add, c_add = n_adder(arg1, arg2)
    s_sub, c_sub = n_adder(arg1, arg2)
    s_mul, c_mul = Constant("0"*32), Constant("0")
    temp_mul, ctemp_mul = arg2, Constant("0")
    for i in range(32):
        ctemp_mul, temp_mul = sll(temp_mul, 1)
        c_mul = Or(c_mul, ctemp_mul)
        sadd_mul, ctempadd_mul = n_adder(s_mul, temp_mul)
        s_mul, ctemp_mul = Mux(arg1[i], sadd_mul, s_mul), Mux(arg1[i], ctempadd_mul, ctemp_mul)
        c_mul = Or(c_mul, ctemp_mul)
    
    r_and = And(arg1, arg2)
    of_and = Constant("0")
    zf_and = is_zero(r_and)
    sf_and = r_and[0]
    
    r_or = Or(arg1, arg2)
    of_or = Constant("0")
    zf_or = is_zero(r_or)
    sf_or = r_or[0]


    r_xor = Xor(arg1, arg2)
    of_xor = Constant("0")
    zf_xor = is_zero(r_xor)
    sf_or = r_xor[0]

    s_cmp, c_cmp = n_adder(arg1, oppose(arg2))
    
    not_arg = Not(arg1)

    srl_arg = srl(arg1,1)

    of_sll, sll_arg = sll(arg1,1)

    _,e1,e2,e3,e4,_,_,_,_,_,_,_,_,_,_,_ = mux4(add_code)

    ari_mux_val = Mux(e1, s_add, Mux(e2, s_sub, s_mul))
    ari_mux_of = Mux(e1, c_add, Mux(e2, c_sub, c_mul))
    ari_mux_zf = Mux(e1, is_zero(s_add), Mux(e2, is_zero(s_sub), is_zero(s_mul)))
    ari_mux_sf = Mux(e1, s_add[0], Mux(e2, s_sub[0], s_mul[0]))

    bool_mux_val = Mux(e1, r_and, Mux(e2, r_or, r_xor))
    bool_mux_of = Mux(e1, of_and, Mux(e2, of_or, of_xor))
    bool_mux_zf = Mux(e1, is_zero(r_and), Mux(e2, is_zero(r_or), is_zero(r_xor)))
    bool_mux_sf = Mux(e1, r_and[0], Mux(e2, r_or[0], r_xor[0]))

    cmp_val = s_cmp
    cmp_of = c_cmp
    cmp_zf = is_zero(cmp_val)
    cmp_sf = cmp_val[0]

    unary_mux_val = Mux(e1, not_arg, Mux(e2, srl_arg, sll_arg))
    unary_mux_of = Mux(e1, Constant("0"), Mux(e2, Constant("0"), of_sll))
    unary_mux_zf = Mux(e1, is_zero(not_arg), Mux(e2, is_zero(srl_arg), is_zero(sll_arg)))
    unary_mux_sf = Mux(e1, not_arg[0], Mux(e2, srl_arg[0], sll_arg[0]))

    return (Mux(is_ari, ari_mux_val, Mux(is_bool, bool_mux_val, Mux(is_cmp, cmp_val, unary_mux_val))),
            Mux(is_ari, ari_mux_of, Mux(is_bool, bool_mux_of, Mux(is_cmp, cmp_of, unary_mux_of))),
            Mux(is_ari, ari_mux_zf, Mux(is_bool, bool_mux_zf, Mux(is_cmp, cmp_zf, unary_mux_zf))),
            Mux(is_ari, ari_mux_sf, Mux(is_bool, bool_mux_sf, Mux(is_cmp, cmp_sf, unary_mux_sf))))

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
