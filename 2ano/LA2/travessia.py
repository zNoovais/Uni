

def dijkstra(adj,o):
    pai = {}
    dist = {}
    dist[o] = 0
    orla = {o}
    while orla:
        v = min(orla,key=lambda x:dist[x])
        orla.remove(v)
        for d in adj[v]:
            if d not in dist:
                orla.add(d)
                dist[d] = float("inf")
            if dist[v] + adj[v][d] < dist[d]:
                pai[d] = v
                dist[d] = dist[v] + adj[v][d]
    return dist


def marcaCaminho(co,grafo,mapa,altura,largura):
    
    (y,x) = co
    o = int(mapa[y][x])
    grafo[co] = dict()
    
    if not(y+1 >= altura or abs(o-int(mapa[y+1][x])) > 2) :
        grafo[co][(y+1,x)] = abs(o-int(mapa[y+1][x])) +1
    
    if not(y-1 <= 0 or abs(o-int(mapa[y-1][x])) > 2):
        grafo[co][(y-1,x)] = abs(o-int(mapa[y-1][x])) +1
    
    if not(x+1 >= largura or abs(o-int(mapa[y][x+1])) > 2):
        grafo[co][y,x+1] = abs(o-int(mapa[y][x+1])) +1
    
    if not(x-1 <= 0 or abs(o-int(mapa[y][x-1])) > 2):
        grafo[co][(y,x-1)] = abs(o-int(mapa[y][x-1])) +1
        
        
    return
    
    

def travessia(mapa):
    
    (altura,largura) = (len(mapa),len(mapa[0]))
    print((altura,largura))

    grafo = dict()
    
    for y in range(altura):
        for x in range(largura):
            
            co = (y,x)
            print(co)
            marcaCaminho(co,grafo,mapa,altura,largura)
            
    print(dijkstra(grafo,(0,3)))
    print()
    print()

    return grafo


mapa = [    "4563",
            "9254",
            "7234",
            "3231",
            "3881"]


print(travessia(mapa))

