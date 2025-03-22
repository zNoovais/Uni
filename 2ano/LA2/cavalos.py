'''

Implemente uma função que calcula o preço mais barato para fazer uma viagem de
autocarro entre duas cidades. A função recebe (para além das duas cidades) uma
lista de rotas de autocarro, onde cada rota é uma sequência de cidades por onde
passa o autocarro, intercalada com o custo para viajar entre cada par de cidades.
Assuma que cada rota funciona nos dois sentidos.

                            
                                
'''

def dijkstra(adj,o):
    pai = {}
    dist = {}
    dist[o] = 0
    orla = {o}
    while orla:
        v = min(orla,key=lambda x:dist[x])
        orla.remove(v)
        for d in adj.get(v,{}):
            if d not in dist:
                orla.add(d)
                dist[d] = float("inf")
            if dist[v] + adj[v][d] < dist[d]:
                pai[d] = v
                dist[d] = dist[v] + adj[v][d]
    return dist

def viagem(rotas, o, d):
    
    grafo = dict()
    
    for rota in rotas:
        for i in range(len(rota)):
            if i % 2 == 0:
                if rota[i] not in grafo.keys():
                    grafo[rota[i]] = dict()
                if i + 2 < len(rota):
                    grafo[rota[i]][rota[i+2]] = rota[i+1]
                if i - 2 >= 0:
                    grafo[rota[i]][rota[i-2]] = rota[i-1]
                
    
    
    
    
    return dijkstra(grafo,o)[d]

