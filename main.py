from lib_carotte import *

# Importation des fonctions nécessaires
from Utils.utils import *
from Utils.alu import *

Un = "0000000000000001"

allow_ribbon_logic_operations(True)

def main():

    ZF = Reg(Defer(1, lambda: zf_temp))
    SF = Reg(Defer(1, lambda: sf_temp))
    OF = Reg(Defer(1, lambda: of_temp))

    REG0 = Reg(Defer(32, lambda: reg0_temp))
    REG1 = Reg(Defer(32, lambda: reg1_temp))
    REG2 = Reg(Defer(32, lambda: reg2_temp))
    REG3 = Reg(Defer(32, lambda: reg3_temp))
    REG4 = Reg(Defer(32, lambda: reg4_temp))
    REG5 = Reg(Defer(32, lambda: reg5_temp))
    REG6 = Reg(Defer(32, lambda: reg6_temp))
    REG7 = Reg(Defer(32, lambda: reg7_temp))
    REG8 = Reg(Defer(32, lambda: reg8_temp))
    REG9 = Reg(Defer(32, lambda: reg9_temp))
    REG10 = Reg(Defer(32, lambda: reg10_temp))
    REG11 = Reg(Defer(32, lambda: reg11_temp))
    REG12 = Reg(Defer(32, lambda: reg12_temp))
    REG13 = Reg(Defer(32, lambda: reg13_temp))
    REG14 = Reg(Defer(32, lambda: reg14_temp))
    REG15 = Reg(Defer(32, lambda: reg15_temp))

    P = Reg(Defer(16, lambda: p_temp))
    actual_op = ROM(16,32,P) #Code complet de l'opération appelée
    op_code = Slice(0,8, actual_op) #Code d'identificateur de l'opération

    id_code = Slice(0,4, op_code)
    additional_code = Slice(4,8, op_code)

    arg1_raw = Slice(8,12,actual_op)
    arg2_raw = Slice(12,32, actual_op)

    arg2_reg_nb = Slice(0,4,arg2_raw)

    x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15 = mux4(arg1_raw)
    y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15 = mux4(arg2_reg_nb)

    treated_arg1 = Mux(x0,REG0,Mux(x1,REG1,Mux(x2,REG2,Mux(x3,REG3,Mux(x4,REG4,Mux(x5,REG5,Mux(x6,REG6,Mux(x7,REG7,Mux(x8,REG8,Mux(x9,REG9,Mux(x10,REG10,Mux(x11,REG11,Mux(x12,REG12,Mux(x13,REG13,Mux(x14,REG14,REG15)))))))))))))))
    #Enfer sur terre (le 1)
    treated_arg2 = Mux(y0,REG0,Mux(y1,REG1,Mux(y2,REG2,Mux(y3,REG3,Mux(y4,REG4,Mux(y5,REG5,Mux(y6,REG6,Mux(y7,REG7,Mux(y8,REG8,Mux(y9,REG9,Mux(y10,REG10,Mux(y11,REG11,Mux(y12,REG12,Mux(y13,REG13,Mux(y14,REG14,REG15)))))))))))))))
    #Enfer sur terre (le 2)

    is_noop,is_ari, is_bool, unary, is_jump, is_mem, is_mov, is_movi,is_cmp,a,b,c,d,e,f,g = mux4(id_code)

    arg2_et = Concat(Mux(arg2_raw[0], Constant("1"*12),Constant("000000000000")), arg2_raw)

    arg2 = Mux(Or(is_jump,is_movi), arg2_et,treated_arg2) 

    (n_p, euuuhhh)  = n_adder(P, Constant(Un))

    c,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15 = mux4(additional_code)

    result,of,zf,sf = Alu(is_ari,is_bool,is_cmp,unary,additional_code, treated_arg1, treated_arg2)

    #Constant("0"*32),Constant("1"),Constant("1"),Constant("1")

    iswritingneeded = Or(or4(is_ari, is_bool, unary, Or(is_mov, And(is_mem,c1))), is_movi)

    isflagwritingneeded = or4(is_ari, is_bool, unary, Or(is_cmp, Or(is_mov, And(is_mem,c1)))) #TODO probablement problème ici

    is_load_needed = is_mem & c2
    is_load_im = is_mem & c4

    arg2_ram = Slice(16,32, Mux((c1|c2), treated_arg2, arg2_et))


    raminho = RAM(16,32,arg2_ram,is_load_needed,arg2_ram, treated_arg2)
    # add_size, word_size, read_add, write_enable, write_addr, data

    finalresult = Mux(is_mem,raminho, Mux(is_mov, treated_arg2, Mux(is_movi,arg2, result)))

    reg0_temp = Mux(And(iswritingneeded,x0), finalresult, REG0 )
    reg1_temp = Mux(And(iswritingneeded,x1), finalresult, REG1 )
    reg2_temp = Mux(And(iswritingneeded,x2), finalresult, REG2 )
    reg3_temp = Mux(And(iswritingneeded,x3), finalresult, REG3 )
    reg4_temp = Mux(And(iswritingneeded,x4), finalresult, REG4 )
    reg5_temp = Mux(And(iswritingneeded,x5), finalresult, REG5 )
    reg6_temp = Mux(And(iswritingneeded,x6), finalresult, REG6 )
    reg7_temp = Mux(And(iswritingneeded,x7), finalresult, REG7 )
    reg8_temp = Mux(And(iswritingneeded,x8), finalresult, REG8 )
    reg9_temp = Mux(And(iswritingneeded,x9), finalresult, REG9 )
    reg10_temp = Mux(And(iswritingneeded,x10), finalresult, REG10 )
    reg11_temp = Mux(And(iswritingneeded,x11), finalresult, REG11 )
    reg12_temp = Mux(And(iswritingneeded,x12), finalresult, REG12 )
    reg13_temp = Mux(And(iswritingneeded,x13), finalresult, REG13 )
    reg14_temp = Mux(And(iswritingneeded,x14), finalresult, REG14 )
    reg15_temp = Mux(And(iswritingneeded,x15), finalresult, REG15 )

    #Enfer sur terre (le 3)

    zf_temp = Mux(And(isflagwritingneeded,x15), zf, ZF )
    sf_temp = Mux(And(isflagwritingneeded,x15), sf, SF )
    of_temp = Mux(And(isflagwritingneeded,x15), of, OF )

    is_really_jumping = And(is_jump, or4(
        c1, #jmp
        And(c2, Not(ZF)), #Jne
        And(c3, ZF), #Jge
        And(c4, Xor(SF,OF)) #TODO ATTENTION c'est très possible que ça fasse pas ce qu'on veuille
    ))

    p_temp = Mux(is_really_jumping, Slice( 16,32, arg2), n_p)

    # slled.set_as_output("sll")

    # additional_code.set_as_output("add_code")
    # is_ari.set_as_output("is_ari")
    # arg1_raw.set_as_output("arg1_raw")
    # is_movi.set_as_output("is_movi")
    # arg2_raw.set_as_output("arg2_raw")
    # arg2.set_as_output("arg2")
    # actual_op.set_as_output("actual_op")
    # # n_p.set_as_output("n_p")
    # # P.set_as_output("P")
    # p_temp.set_as_output("p_temp")
    # reg0_temp.set_as_output("regi0")
    # reg1_temp.set_as_output("regi1")
    # reg2_temp.set_as_output("regi2")
    # reg3_temp.set_as_output("regi3")
    # reg4_temp.set_as_output("regi4")
    # reg5_temp.set_as_output("regi5")
    # reg6_temp.set_as_output("regi6")
    # reg7_temp.set_as_output("regi7")
    # reg8_temp.set_as_output("regi8")
    # reg9_temp.set_as_output("regi9")
    # reg10_temp.set_as_output("regi10")
    # reg11_temp.set_as_output("regi11")
    # reg12_temp.set_as_output("regi12")
    # reg13_temp.set_as_output("regi13")
    # reg14_temp.set_as_output("regi14")
    # reg15_temp.set_as_output("regi15")