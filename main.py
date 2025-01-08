from lib_carotte import *

# Importation des fonctions nécessaires
from Utils.utils import *
from Utils.alu import *

from examples.nadder import *


Un = "00000000000000000000000000000001"

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





    P = Reg(Defer(32, lambda: p_temp))
    actual_op = ROM(32,32,P) #Code complet de l'opération appelée
    op_code = Slice(0,8, actual_op) #Code d'identificateur de l'opération

    id_code = Slice(0,4, op_code)
    additional_code = Slice(4,8, op_code)



    arg1_raw = Slice(8,12,actual_op)
    arg2_raw = Slice(12,32, actual_op)

    arg2_reg_nb = Slice(0,4,arg2_raw)

    x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15 = mux4(arg1_raw)
    y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15 = mux4(arg2_reg_nb)



    treated_arg1 = Mux(x0,Mux(x1,Mux(x2,Mux(x3,Mux(x4,Mux(x5,Mux(x6,Mux(x7,Mux(x8,Mux(x9,Mux(x10,Mux(x11,Mux(x12,Mux(x13,Mux(x14,REG15,REG14),REG13),REG12),REG11),REG10),REG9),REG8),REG7),REG6),REG5),REG4),REG3),REG2),REG1),REG0)
    #Enfer sur terre (le 1)
    treated_arg2 = Mux(y0,Mux(y1,Mux(y2,Mux(y3,Mux(y4,Mux(y5,Mux(y6,Mux(y7,Mux(y8,Mux(y9,Mux(y10,Mux(y11,Mux(y12,Mux(y13,Mux(y14,REG15,REG14),REG13),REG12),REG11),REG10),REG9),REG8),REG7),REG6),REG5),REG4),REG3),REG2),REG1),REG0)
    #Enfer sur terre (le 2)



    is_noop,is_ari, is_bool, unary, is_jump, is_mem, is_mov, is_movi,is_cmp,_,_,_,_,_,_,_ = mux4(id_code)
    
    arg2 = Mux(Or(is_jump,is_movi),treated_arg2, Concat(Constant("000000000000"), arg2_raw)) #TODO mieux faire ça (il faut ptet concat des 1 et mettre un constant)

    (n_p, _)  = adder(P, Constant(Un), Constant("0"))

    _,c1,c2,c3,c4,_,_,_,_,_,_,_,_,_,_,_ = mux4(additional_code)


    result,of,zf,sf =  Alu(is_ari,is_bool,is_cmp,unary,additional_code, treated_arg1, treated_arg2)

    #Constant("0"*32),Constant("1"),Constant("1"),Constant("1")

    iswritingneeded = or4(is_ari, is_bool, unary, Or(is_mov, And(is_mem,c1)))

    isflagwritingneeded = or4(is_ari, is_bool, unary, Or(is_cmp, Or(is_mov, And(is_mem,c1))))

    is_load_needed = is_mem & c2

    arg2_ram = Slice(16,32, treated_arg2)
    arg1_ram = Slice(16,32, treated_arg1)

    raminho = RAM(16,32,arg2_ram,is_load_needed,arg1_ram,treated_arg2)

    finalresult = Mux(is_mem,Mux(is_mov, Mux(is_movi,result,arg2), treated_arg2),raminho)

    reg0_temp = Mux(And(iswritingneeded,x0), REG0, result )
    reg1_temp = Mux(And(iswritingneeded,x1), REG1, result )
    reg2_temp = Mux(And(iswritingneeded,x2), REG2, result )
    reg3_temp = Mux(And(iswritingneeded,x3), REG3, result )
    reg4_temp = Mux(And(iswritingneeded,x4), REG4, result )
    reg5_temp = Mux(And(iswritingneeded,x5), REG5, result )
    reg6_temp = Mux(And(iswritingneeded,x6), REG6, result )
    reg7_temp = Mux(And(iswritingneeded,x7), REG7, result )
    reg8_temp = Mux(And(iswritingneeded,x8), REG8, result )
    reg9_temp = Mux(And(iswritingneeded,x9), REG9, result )
    reg10_temp = Mux(And(iswritingneeded,x10), REG10, result )
    reg11_temp = Mux(And(iswritingneeded,x11), REG11, result )
    reg12_temp = Mux(And(iswritingneeded,x12), REG12, result )
    reg13_temp = Mux(And(iswritingneeded,x13), REG13, result )
    reg14_temp = Mux(And(iswritingneeded,x14), REG14, result )
    reg15_temp = Mux(And(iswritingneeded,x15), REG15, result )

    #Enfer sur terre (le 3)




    zf_temp = Mux(And(isflagwritingneeded,x15), ZF, zf )
    sf_temp = Mux(And(isflagwritingneeded,x15), SF, sf )
    of_temp = Mux(And(isflagwritingneeded,x15), OF, of )

    is_really_jumping = And(is_jump, or4(
        c1, #jmp
        And(c2, Not(ZF)), #Jne
        And(c3, ZF), #Jge
        And(c4, Xor(SF,OF)) #TODO ATTENTION c'est très possible que ça fasse pas ce qu'on veuille
    ))

    p_temp = Mux(is_really_jumping, n_p, arg2 )

main()
