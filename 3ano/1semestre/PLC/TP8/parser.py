import ply.yacc as yacc
from analex_num import lexer,tokens,literals

def p_calculadora(p):
    r"""
    Calculadora : ATRIB  
                | VALVAR
                | VALEXP
                | DUMP
    """
    print(str(p[1]))

def p_atrib(p): #parser.vars
    r"""
    ATRIB : VAR "=" EXP
    """ 
    parser.vars[p[1]] = p[3]
    p[0] = "Var " + p[1] + " = " + str(p[3]) 

def p_valvar(p):
    r"""
    VALVAR : "?" VAR
    """
    if p[2] not in parser.vars.keys():
        p[0] = "var not in memory"
    else:
        p[0] = parser.vars[p[2]]

    p[0] = parser.vars[p[2]]
    
def p_valexp(p):
    r"""
    VALEXP : "!" EXP
    """
    p[0] = p[2]

def p_dump(p):
    r"""
    DUMP : "*"
    """
    res = ""
    for var,v in parser.vars.items():
        res += f"{var}: {v}\n"
    
    p[0] = res

##### fim das funçoes 

def p_exp(p):
    r"""
    EXP : MENOS
        | MAIS
        | TERM    
    """
    p[0] = p[1]

def p_mais(p):
    r"""
    MAIS : EXP "+" TERM
    """
    p[0] = p[1] + p[3]

    


def p_menos(p):
    r"""
    MENOS : EXP "-" TERM
    
    """
    p[0] = p[1] + p[3]




def p_term(p):
    r"""
    TERM : MULT
         | DIV
         | FACTOR
    """
    p[0] = p[1]

def p_mult(p):
    r"""
    MULT : TERM "*" FACTOR 
    """
    p[0] = p[1] * p[3]

def p_div(p):
    r"""
    DIV : TERM "/" FACTOR
    """
    p[0] = p[1] / p[3]

def p_factor(p):
    r"""
    FACTOR : NUM
           | PA
           | VARNUM
    """
    if p.slice[1].type != "VARNUM":
        p[0] = float(p[1])
    else:
        p[0] = p[1]

def p_parent(p):
    r"""
    PA : "(" EXP ")"
    """
    p[0] = p[2]
    
def p_varnum(p):
    r"""
    VARNUM : VAR
    """
    if p[1] in parser.vars.keys():
        p[0] = parser.vars[p[1]]
    else:
        p[0] = f"error :: variable {p[1]} not in memory"

def p_error(p):
    print('Erro sintático: ', p)
    parser.success = False


parser = yacc.yacc()
#parser.vars = dict()

parser.success = True
parser.vars = dict()

parser.parse("x = 10")


