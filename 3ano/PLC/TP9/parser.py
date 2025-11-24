import ply.yacc as yacc
from analex_num import lexer,tokens,literals

def p_calculadora(p):
    r"""
    calculadora : Program Instruction
                | Instruction

    Instruction : "%" VAR
                | "!" EXP
                | VAR "=" Exp
                | "#" 
    
    Exp : Exp "+" Term
        | Exp "-" Term
        | Term

    Term : Term "*" Factor
        | Term "/" Factor
        | Factor
    
    Factor : NUM
            | VAR
            | "(" Exp ")"
            | Cond "?" Exp ":" Exp
    
    Cond : Cond "|" Conj
          | Conj
    
    Conj : Conj "&" Comp
        | Comp

    Comp : Exp ">" Exp
        | Exp "<" Exp
    
        
    

    """






def p_error(p):
    print('Erro sintático: ', p)
    parser.success = False


parser = yacc.yacc()
#parser.vars = dict()

parser.success = True
parser.vars = dict()

parser.parse("x = 10")


