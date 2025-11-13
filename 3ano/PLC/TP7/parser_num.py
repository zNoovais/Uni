import ply.yacc as yacc
from analex_num import tokens, literals
# Production rules

print("alo")

def p_S(p):
    "S : Exp '.'"
    parser.success = True

def p_Exp_int(p):
    "Exp : INT"
    pass

def p_Exp_funcao(p):
    "Exp : '(' Funcao ')'"
    pass

def p_Funcao_mais(p):
    "Funcao : '+' Lista"
    pass

def p_Funcao_vezes(p):
    "Funcao : '*' Lista"
    pass

def p_Lista_rec(p):
    "Lista : Exp Lista"
    pass

def p_Lista_single(p):
    "Lista : Exp"
    pass


parser = yacc.yacc()
parser.success = True

def p_error(p):
    print('Erro sintático: ', p)
    parser.success = False
# Build the parser
parser = yacc.yacc()
# Adicionar estado ao parser
parser.success = True

parser.parse("")


