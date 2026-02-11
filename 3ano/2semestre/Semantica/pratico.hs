import Data.Maybe



type Var = String
type Numero = Integer
type Booleano = Bool

data Aexp = N Numero | V Var | Mais Aexp Aexp | Mult Aexp Aexp | Menos Aexp Aexp | Prox Var | Suc Var
    deriving (Show, Eq, Ord)


data Bexp = B Booleano| Or Bexp Bexp | And Bexp Bexp 
 | Igual Aexp Aexp | Not Bexp | Menor Aexp Aexp
    deriving Show

type St = [(Var,Numero)] -- state atual de uma maquina

state :: St -> Var -> Maybe Numero
state [] v = Nothing
state (h:t) v = if fst h == v then Just (snd h) else state t v

x = "x"
y = "y"
z = "z"
s = [(x,0),(y,1),(z,3)]

codigo = Comp (Atri x (Mais (N 2) (V x))) 
        (While (Menor (V x) (N 16)) (Atri x (Mais (V x) (N 1)))) 

subs :: St -> Var -> Aexp -> St
subs s x v = (x,semanticsArit s v) : filter ((/=x) . fst) s 

semanticsArit :: St -> Aexp -> Numero
semanticsArit s (N x) = x
semanticsArit s (V x) = fromMaybe 0 (state s x)
semanticsArit s (Mais a b) = semanticsArit s a + semanticsArit s b
semanticsArit s (Mult a b) = semanticsArit s a * semanticsArit s b
semanticsArit s (Menos a b) = semanticsArit s a - semanticsArit s b


semanticsBool :: St -> Bexp -> Booleano
semanticsBool s (B b) = b
semanticsBool s (Not a) = not (semanticsBool s a)
semanticsBool s (Or a b) =  semanticsBool s a || semanticsBool s b
semanticsBool s (And a b) = semanticsBool s a && semanticsBool s b
semanticsBool s (Igual a b) = semanticsArit s a == semanticsArit s b
semanticsBool s (Menor a b) = semanticsArit s a < semanticsArit s b

data Stm = Skip | Comp Stm Stm | Atri Var Aexp | If Bexp Stm Stm | While Bexp Stm
    deriving Show

code :: St -> Stm -> St
code s Skip = s
code s (Atri x v) = subs s x v  
code s (Comp c1 c2) = code (code s c1) c2 
code s (If b c1 c2) = if semanticsBool s b then code s c1 else code s c2
code s (While b c) = if semanticsBool s b then code s (Comp c (While b c)) else s





