
Client-Server Arquiteturas:
server: host (ip permanent)
clients: comunicam com o server e nao se comunicam entre si
para a distribuiçao de files temos que fazer um upload de N copias
para N peers 
ent nos tems o tempo de distribuição para distribuir F para N clientes
$D\ge max \left\{ F/u_{s},F/d_{min},NF/\left( u_{s}+\sum  \right) \right\}$

P2P Arquiterura: (TORRENT)
posso nao tem server
eu falo diretamente com a pessoa **peer to peer**
ele é mais complexo e menos seguro 
e depende muito dos seus peers.....



Sockets: process

temos o TCP UDP QUIC

que atuam sobre protocolos diferentes como HTTP1 SIP DASH 


**Segurança no TCP**:
TLS: trás encriptação do TCP
fazendo o HTTPS que usa o TLS (tudo cifrado)



### Peer to Peer:
O arquivo é dividido em chunks


### Multimedia (videos):
DASH: é usado para streaming de multimedia
*Dynamic Adaptive Streaming over HTTP*
ele é safo então ele pode diminuir qualidade do video ou ir por um lugar melhor!


### Socket programming
Obj: comunicar client server usando socket

socket: é uma porta entre aplicações e end-end-transport protocol

dois tipos de sockets: **UDP** e **TCP**

**UDP**:
no "connection" between client&client
é pequeno e unreliable










