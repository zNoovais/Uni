

### RSA

o padding do RSA Cumpre duas coisas

- aleatoriedade!!!!!
- adicionamos redundancia (sanity-check)

dois esquemas:

RSA-OAEP: *public key Encryption*

RSA-OPP: 

### El-Gamal

params: p, g;

sk: x \[1,... q]
pk: g^k

Enc(pk,m) = +k, <g^k, m\*pk>

Dec(sk,<C1,C2>) = C2/C1^(sk) = m 

*isto segue o protocolo Diffiei-Hellman*





