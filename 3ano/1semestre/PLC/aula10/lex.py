import ply.lex as lex

#states = (('comment','exclusive'))


# fazer precisao para real double e extended

tokens = ["read","if","write","while","VAR","NUM"]

literals = ["(",")",">","<","*","-","+"]



def t_read(t):
    r"read"
    return t

def t_if(t):
    r"if"
    return t

def t_write(t):
    r"write"
    return t

def t_while(t):
    r"while"
    return t

def t_VAR(t):
    r"[A-Za-z][A-Za-z\_\d]*"
    return t

def t_NUM(t):
    r"\d+"
    return t


def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)

t_ignore = '\t '
def t_error(t):
    print('Carácter desconhecido: ', t.value[0], 'Linha: ',t.lexer.lineno)
    t.lexer.skip(1)


lexer = lex.lex()
