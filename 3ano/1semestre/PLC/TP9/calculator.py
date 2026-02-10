from parser import parser
import sys

 
for linha in sys.stdin:
    # Análise do texto
    parser.parse(linha)
    if parser.success:
        pass
    else:
        print("Frase inválida... Corrija e tente novamente!")