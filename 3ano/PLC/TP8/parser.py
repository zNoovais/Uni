import ply.yacc as yacc
from analex_num import lexer,tokens,literals

def p_calculadora(p):
    r"""
    Calculadora : ATRIB  
                | VALVAR
                | VALEXP
                | DUMP
    """
    print(p[1])

def p_atrib(p): #parser.vars
    r"""
    ATRIB : VAR "=" EXP
    """

    pass

def p_valvar(p):
    r"""
    VALVAR : "?" VAR
    """
    p[0] = parser.vars[p[2]]
    pass
def p_valexp(p):
    r"""
    VALEXP : "!" EXP
    """
    p[0] = p[2]

def p_dump(p):
    r"""
    DUMP : "*"
    """
    pass

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
           | VAR
    """
    p[0] = float(p[1])

def p_parent(p):
    r"""
    PA : "(" EXP ")"
    """
    p[0] = p[2]
    


def p_error(p):
    print('Erro sintático: ', p)
    parser.success = False


parser = yacc.yacc()
#parser.vars = dict()

parser.success = True
parser.vars = dict()

parser.parse("! 10*(1+1)")
