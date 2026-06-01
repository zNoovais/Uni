
*código de um comprimento de uma lista:*
letrec comp = $\lambda$l. listcase l of (0,$\lambda$h.$\lambda$.t 1 + comp t)


letrec fact $\equiv$ $\lambda$n.if n=0 then 1 else n\*fact(n-1) in fact

abs = $\lambda$x. if x $\ge$ 0 then x else -x in 


montar um tipo novo com o tipo: **data Tree Int**

\<type> ::= ...|Tree
\<exp> ::= ...| Empty | Node \<exp> \<exp> \<exp>
			 | treecase \<exp> of (\<exp>,\<exp>) 

tipos:

.-----------------.
$\Gamma$ |- Empty : Tree


$\Gamma$ |- e : Int, $\Gamma$ |- e1 : Tree, $\Gamma$ |- e2 : Tree
.---------------------------------------------.
     $\Gamma$ |-  Node e e1 e2 : Tree

$\Gamma$ |- e : Tree,  $\Gamma$ |- e1 : $\sigma$ ,  $\Gamma$ |- e2 : Int -> Tree -> Tree -> $\sigma$ 
.-----------------------------------------------------------------.
     $\Gamma$ |-  treecase e of (e1,e2) : $\sigma$

CBV
\<cfm> ::= ... | Empty | Node \<cfm> \<cfm> \<cfm>

.--------------------.
   Empty -> Empty
e => z, e1 => z1, e2 => z2
.-----------------------------------.
   Node e e1 e2 => Node z z1 z2