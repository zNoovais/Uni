
lista = [1,2,3,4,7,8,8,9,10]

def e_primo(lista): 
    soma = 0
    for x in lista: 
        soma += x

    for y in range(2,soma):
        if soma % y == 0:
            return False
    
    
    return True

       


if e_primo(lista): 
    print("aloooo")

else:
    print("nao deu mano")

