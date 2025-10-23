from p_lexer import lexer

prox_symb = None # S -> (S)S | E

def process(tipo):
   global prox_symb
   if tipo == prox_symb.type : 
      prox_symb = lexer.token()

   else:
      raise ValueError("ERRROOOOOO")
      

def rec_S():
   
   global prox_symb
   
   if prox_symb is None or prox_symb.type == "PF":
        pass
   elif prox_symb.type == "PA":
        process("PA")
        rec_S()
        process("PF")
        rec_S()

def parser(str):
    global prox_symb
    lexer.input(str)
    prox_symb = lexer.token()
    rec_S()

parser("()()")
