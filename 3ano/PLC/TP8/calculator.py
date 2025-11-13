from parser import parser
import sys

 
for linha in sys.stdin:
    # Análise do texto
    parser.parse(linha)
    if parser.success:
        print("Frase válida: ", linha)
    else:
        print("Frase inválida... Corrija e tente novamente!")