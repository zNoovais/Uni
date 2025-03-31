"""

Um ladrão assalta uma casa e, dado que tem uma capacidade de carga limitada, 
tem que decidir que objectos vai levar por forma a maximizar o potencial lucro. 

Implemente uma função que ajude o ladrão a decidir o que levar.
A função recebe a capacidade de carga do ladrão (em Kg) seguida de uma lista 
dos objectos existentes na casa, sendo cada um um triplo com o nome, o valor de 
venda no mercado negro, e o seu peso. Deve devolver o máximo lucro que o ladrão
poderá  obter para a capacidade de carga especificada.

"""

def ladraoRec(capacidade,objectos,total,d):
    
    c = (capacidade, tuple(objectos), total)
    if c in d.keys():
        return d[c]
    
    
    elif len(objectos) == 0 or capacidade == 0:
        r = total
        
    elif capacidade-objectos[0][2] < 0:
        r = ladraoRec(capacidade,objectos[1:],total,d)
    
    
    else: 
        r = max( ladraoRec(capacidade-(objectos[0])[2],objectos[1:],total + objectos[0][1],d) , ladraoRec(capacidade,objectos[1:],total,d) )
    
    d[c] = r
    
    return r
    
    
def ladrao(capacidade,objectos):
    
    d = dict()
    
    return ladraoRec(capacidade,objectos,0,d)
    
    
    
    
    