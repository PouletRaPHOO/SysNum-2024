from lib_carotte import *
from alu import *
from utils import *
# Importation des fonctions nécessaires

from examples.nadder import *


Un = "00000000000000000000000000000001"

allow_ribbon_logic_operations(True)

def r():

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

    arg1_raw = Slice(8,12,actual_op)
    arg2_raw = Slice(12,32, actual_op)

    arg2_reg_nb = Slice(0,4,arg2_raw)

    x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15 = mux4(arg1_raw)
    y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15 = mux4(arg2_reg_nb)

    treated_arg1 = Mux(x0,Mux(x1,Mux(x2,Mux(x3,Mux(x4,Mux(x5,Mux(x6,Mux(x7,Mux(x8,Mux(x9,Mux(x10,Mux(x11,Mux(x12,Mux(x13,Mux(x14,REG15,REG14),REG13),REG12),REG11),REG10),REG9),REG8),REG7),REG6),REG5),REG4),REG3),REG2),REG1),REG0)
    #Enfer sur terre (le 1)
    treated_arg2 = Mux(y0,Mux(y1,Mux(y2,Mux(y3,Mux(y4,Mux(y5,Mux(y6,Mux(y7,Mux(y8,Mux(y9,Mux(y10,Mux(y11,Mux(y12,Mux(y13,Mux(y14,REG15,REG14),REG13),REG12),REG11),REG10),REG9),REG8),REG7),REG6),REG5),REG4),REG3),REG2),REG1),REG0)
    #Enfer sur terre (le 2)

    is_noop,is_ari, is_bool, unary, is_jump, is_mem, is_mov, is_movi,is_cmp,a,b,c,d,e,f,g = mux4(id_code)


    c1 = Constant("1")


    result = Constant("0"*32)

    #Constant("0"*32),Constant("1"),Constant("1"),Constant("1")


    iswritingneeded = or4(is_ari, is_bool, unary, Or(is_mov, And(is_mem,c1)))


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

    p_temp = Mux(Constant("0"), Constant("0"*32), Constant("0"*32))
r()