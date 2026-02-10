import ply.lex as lex


tokens = (
   'NUM',
   'MUL',
   'DIV',
   'PA',
   'PF',
   'READ',
   'ATRIB',
   'VIRG',
   'ID'
)

# Regular expression rules for simple tokens
t_READ    = r'\?'
t_ATRIB   = r'='
t_MUL     = r'\*'
t_DIV     = r'\/'
t_PA      = r'\('
t_PF      = r'\)'
t_VIRG    = r','

# A regular expression rule with some action code
def t_NUM(t):
    r'\d+'
    t.value = int(t.value)
    return t

def t_ID(t):
    r'[a-zA-Z_]\w*'
    return t

# Define a rule so we can track line numbers
def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)

# A string containing ignored characters (spaces and tabs)
t_ignore  = ' \t'

# Error handling rule
def t_error(t):
    print(f"Illegal character {t.value[0]}")
    t.lexer.skip(1)

# Build the lexer
lexer = lex.lex()

#lexer.input(texto)
#for tok in lexer:
#    print(tok)