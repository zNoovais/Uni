import Data.Maybe

type Var = String
type Numero = Integer
type Booleano = Bool

--------- FICHA 1 ---------

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

--------- FICHA 2 ----------
data StmSOS = SkipSOS | CompSOS StmSOS StmSOS | AtriSOS Var Aexp | IfSOS Bexp StmSOS StmSOS | WhileSOS Bexp StmSOS | EndSOS
    deriving Show

--stepSOS. (COMO funciona o comp1 e o comp2????!?!?)

stSOS = [(x,0),(y,0),(z,0)]

codigoSOS = CompSOS (AtriSOS z (N 10)) (CompSOS (WhileSOS (Menor (V x) (V z)) (AtriSOS x (Mais (V x) (N 1)))) (CompSOS (AtriSOS y (Mais (V x) (N 0))) EndSOS))

x1 = (codigoSOS,stSOS)

stepSOS :: (StmSOS,St) -> (StmSOS,St)

stepSOS (EndSOS,s) = (EndSOS,s)
stepSOS (SkipSOS,s) = (SkipSOS,s)
stepSOS (AtriSOS var exp,s) = (SkipSOS,subs s var exp)

stepSOS (CompSOS SkipSOS stm2,s) = (stm2, s) 
stepSOS (CompSOS stm1 stm2,s) = (CompSOS (fst (stepSOS (stm1,s)) ) stm2, snd (stepSOS (stm1,s)))


stepSOS (IfSOS b stm1 stm2,s) = if semanticsBool s b then (stm1,s) else (stm2,s)
stepSOS (WhileSOS b stm,s) = (IfSOS b (CompSOS stm (WhileSOS b stm)) SkipSOS, s)

nstepsSOS :: Int -> (StmSOS,St) -> (StmSOS,St)
nstepsSOS 0 c = c
nstepsSOS n c = nstepsSOS (n-1) (stepSOS c)

evalSOS :: (StmSOS,St) -> St
evalSOS (EndSOS,s) = s
evalSOS c = evalSOS (stepSOS c)




--função do chat que imprime tudo.
showSteps :: Int -> (StmSOS,St) -> IO ()
showSteps n conf = mapM_ printStep (zip [0..n] (take (n+1) (iterate stepSOS conf)))
  where
    printStep (i,(stm,st)) = do
        putStrLn ("Step " ++ show i)
        putStrLn ("  Stm: " ++ show stm)
        putStrLn ("  St : " ++ show st)
        putStrLn ""