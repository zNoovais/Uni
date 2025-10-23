
# E : E V T | T
# T : T ^ F | F
# F : True | False | id

import ply.lex as lex


tokens = ('AND','OR', 'CONS', 'ID', 'PA', 'PF')


t_PA = r'\('
t_PF = r'\)'


def t_AND(t):
    r'And'
    return t


def t_OR(t):
    r'Or'
    return t

def t_CONS(t):
    r'True|False'
    return t

def t_ID(t):
    r'[A-Z]'
    return t




def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)

t_ignore = '\t '

def t_error(t):
    print('Carácter desconhecido: ', t.value[0], 'Linha: ', t.lexer.lineno)
    t.lexer.skip(1)

lexer = lex.lex()