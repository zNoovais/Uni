import ply.yacc as yacc
from inputs import *
import pprint 
from lex import lexer,tokens,literals


def p_ProgramaI(p):
    r"""
    ProgramaI : Linhas
    """
    pass

def p_Linhas(p):
    r"""
    Linhas : Linhas '(' Linha ')' 
                |
    """

def p_Linha(p):
    r"""
        Linha : | Ler_input
                | While 
                | Atrib
                | Exp
                | If
    """

def p_Ler_input(p):
    r"""
    Ler_input : read VAR
    """

# def p_Exp(p):
            



