from lib_carotte import *

# Importation des fonctions nécessaires
import utils
import alu

from examples.nadder import *


Un = "00000000000000000000000000000001"

allow_ribbon_logic_operations(True)

def main():
    P = Reg(Defer(32, lambda: p_temp)) # 1 is the bus size that c will have
    x1 = ROM(32,32,P)

    (n_p, osef)  = adder(P, Constant(Un), Constant("0"))

    p_temp = Mux(x1[0], P, n_p )
    P.set_as_output("P")