# sexp_analex.py
# 2025-11-11 by jcr
# ----------------------
import ply.lex as lex
tokens = ['INT']
literals = ['(', ')', '.', '+', '*']
t_INT = r'\d+'
def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)
t_ignore = '\t '
def t_error(t):
    print('Carácter desconhecido: ', t.value[0], 'Linha: ',
t.lexer.lineno)
    t.lexer.skip(1)

lexer = lex.lex()
