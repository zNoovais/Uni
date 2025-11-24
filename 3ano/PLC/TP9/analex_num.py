import ply.lex as lex

tokens = ['NUM','VAR']

literals = ['(', ')', '=', '+', '*','!','?','/','>','<','|','&','%']

def t_NUM(t):
    r"\d+(\.\d+)?"
    return t#float(t.value)



def t_VAR(t):
    r"[a-zA-Z]+"
    return t

def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)

t_ignore = '\t '
def t_error(t):
    print('Carácter desconhecido: ', t.value[0], 'Linha: ',t.lexer.lineno)
    t.lexer.skip(1)

lexer = lex.lex()

#lexer.input("10 + x")
