{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
import Cp
import Data.Bifunctor
import Data.List (groupBy, mapAccumL, nub, sortBy)
import Data.Map (fromListWith)
import Data.Map qualified as Map
import Data.Ratio (denominator)
import Data.String
import List
import Nat (cataNat)


dobro :: Num a => a -> a
dobro x = x+x

store :: (Eq a) => a -> [a] -> [a]
store c = take 10 . nub . (c :)

myacronym :: String -> String
myacronym = concatMap (take 1) . words

myshort :: String -> String
myshort = uncurry (++) . (id >< (++) " ") . split head last . words

newtype Aut = Aut String

newtype Key = Key String

newtype Pag = Pag Int

newtype Bib = Bib [(Key, [Aut])]

newtype Aux = Aux [(Pag, [Key])]

newtype Ind = Ind [(Aut, [Pag])]

-- ((Key,Aut*)*,(Pag,Key*)*) -> (Aut,Pag*)*

-- TODO
mkInd :: (Num p, Ord a, Eq c) => ([(c, [a])], [(p, [c])]) -> [(a, [p])]
mkInd = juntaR . associaChave . (map swap >< map swap) . (concatMap separateR >< concatMap separateR)

-- 72
-- associa :: [(a,[b])] -> [(b,[a])]
-- associa = fromListWith (++) . map swap . concatMap separateR

-- a :: Bib
-- a = [(1,["Jose","Antonio"]),(12,["Andre","Jose"]),(1434,["Jose","Afonso"])]

hB = [(1, ["A", "B"]), (1, ["B", "D"]), (2, ["C", "A", "F", "E"]), (3, ["D", "B"]), (4, ["E"]), (4, ["F", "D", "E"])]

hP = [(11, [1, 3, 5]), (17, [2, 3, 4]), (21, [1, 2, 5]), (32, [2, 3, 4]), (31, [2]), (29, [1, 6]), (90, [3]), (33, [3, 5]), (42, [4, 2])]

hB2 = map swap hB

associaChave :: (Eq b) => ([(a, b)], [(b, c)]) -> [(a, c)]
associaChave (auts, pags) = [(autor, pag) | (autor, key1) <- auts, (key2, pag) <- pags, key1 == key2]

juntaR :: (Eq a) => [(a, b)] -> [(a, [b])]
juntaR = map (split (head . map fst) (map snd)) . groupBy (\(a1, _) (a2, _) -> a1 == a2)

separateR2 :: (a, [b]) -> [(a, b)]
separateR2 (_, []) = []
separateR2 (key, h : t) = (key, h) : separateR (key, t)

separateR :: (a, [b]) -> [(a, b)]
separateR = uncurry zip . (uncurry replicate . swap >< id) . split (id >< length) p2

--t = ([("a", 10), ("b", 20), ("c", 30)], [(1.2, 10), (1.3, 21), (1.4, 31)])

glue :: ([(k1, v)], [(k2, v)]) -> [(Either k1 k2, v)]
glue = uncurry (++) . (map (i1 >< id) >< map (i2 >< id))

concatTuple :: [([a], [b])] -> ([a], [b])
concatTuple [] = ([], [])
concatTuple (x : xs) = (fst x ++ fst (concatTuple xs), snd x ++ snd (concatTuple xs))

unglue :: [(Either k1 k2, v)] -> ([(k1, v)], [(k2, v)])
unglue = concatTuple . map (either (split singl nil) (split nil singl) . distl)

tiraDaLista :: (Eq a) => [a] -> (a, [a]) -- NAO é assim que se faz isso nao funciona direito mas a base é a funçao mynub...
tiraDaLista = either (split head tail . p2) id . grd (uncurry elem) . split head tail

mynub :: (Eq a) => [a] -> [a]
mynub = either nil cons . (id -|- (id >< mynub) . tiraDaLista) . grd null

mysuffixes :: [a] -> [[a]]
mysuffixes = anaList ((id -|- split cons p2) . outList)

auxarea :: (Int, (Int, Int)) -> Int -- f
auxarea = uncurry (*) . (either p2 p1 >< id) . (grd (uncurry (>)) >< id) . assocl

area :: (Int, [Int]) -> Int
area = maximumInt . map auxarea . uncurry zip . (uncurry replicate . swap >< id) . split (id >< length) p2 . (id >< map swap . zip [1 ..])

maximumInt :: [Int] -> Int
maximumInt = cataList (either (const 0) (uncurry max))

mostwater :: [Int] -> Int
-- pool = hyloList (either (const 0) (uncurry max) . (id -|- (area . split head tail) >< id )) ((id -|- split cons p2) . outList)
mostwater = hyloList (either (const 0) (uncurry max . ((area . split head tail) >< id))) ((id -|- split cons p2) . outList)

auxR :: ((a, s) -> Bool) -> ((a, s) -> (c, s)) -> ([a], ([c], s)) -> ([c], s)
auxR h f = either (swap . (id >< uncurry (:)) . assocr . (swap >< id) . p2) (swap . (p2 >< id) . p2) . grd p1 . (h >< (f >< id)) . split (id >< p2) (assocl . (id >< swap)) . (head >< id)

auxL :: ((a, s) -> Bool) -> ((a, s) -> (c, s)) -> ([a], ([a], s)) -> ([c], ([a], s))
auxL h f = either ((singl >< id) . p2) ((nil >< id) . p2) . grd p1 . (id >< ((id >< swap) . assocr)) . assocr . (split h f >< id) . assocl . (head >< swap)

--------- fazendo a base do LP list Pair ([a],s)

outLP ([], s) = i1 ((), s)
outLP (h : t, s) = i2 (singl h, (t, s))

inLP = either (nil >< id) ((uncurry (++) >< id) . assocl)

recLP f = id -|- (id >< f)

cataLP g = g . recLP (cataLP g) . outLP

anaLP g = inLP . recLP (anaLP g) . g

hyloLP = cataLP . anaLP

mapAccumRfilter :: ((a, s) -> Bool) -> ((a, s) -> (c, s)) -> ([a], s) -> ([c], s)
-- mapAccumLfilterR h f = either (nil >< id) (aux h f) . (id -|- (id >< mapAccumLfilterR h f )) . outLP
mapAccumRfilter h f = cataLP (either (nil >< id) (auxR h f))

mapAccumLfilter :: ((a, s) -> Bool) -> ((a, s) -> (c, s)) -> ([a], s) -> ([c], s)
mapAccumLfilter h f = anaLP (((nil >< id) -|- auxL h f) . outLP)

-- tudo isto a baixo foi uma tentativa...
-- mapAccumLfilter :: ((a,s) -> Bool) -> ((a,s) -> (c,s)) -> ([a],s) -> ([c],s)
-- mapAccumLfilter h f =  either nil aux . (id -|- (id >< mapAccumLfilter h f)) .  (id -|- ( assocr . (split head tail >< id))) . grd (null . p1)

-- cataList (either (const 0) (uncurry max) . (id -|- (area . split head tail) >< id ) ) . anaList ((id -|- split cons p2) . outList)
-- maximumInt . map (area . split head tail) . mysuffixes

-- mapAccL :: ((a,s) -> (c,s)) -> ([a],s) -> [(c,s)]
-- mapAccL g = anaList((p1 -|- split (g . p1 . assocl . (id >< swap) . assocr) ((id >< p2 . g) . assocr . (swap >< id) )) . distl . (outList >< id))

for :: (a -> a) -> a -> Int -> a
for b i 0 = i
for b i x = b (for b i (x - 1)) -- Corrigimos a ordem das operações

piloop :: (Fractional a) => Int -> a
piloop = undefined

pical :: Int -> Float
pical 0 = 2
pical n = f n / fromIntegral (g n) + pical (n - 1)
  where
    f 0 = 2
    f k = 2 * fromIntegral k * fromIntegral k * f (k - 1)
    g 0 = 1
    g k = (2 * k + 1) * g (k - 1)
---------- LEI --------
fatorial2 0 = 1
fatorial2 n = n * fatorial2 (n - 1)

numerador n = ((fatorial2 n) ^ 2) * 2 ^ (n + 1)

denom n = fatorial2 ((2 * n) + 1)

func n = (fromIntegral (numerador n)) / (fromIntegral (denom n))

fire n
  | n < 0 = func 0
  | otherwise = func (n - 1)

loop1 (fire, ice) = (fire, fire + fire)

y = for loop1 (1, 1)



--discollect [] = []
--discollect (h:t) = f h ++ discollect t

----------------


picalc :: Fractional a => Integer -> a
picalc 0 = 2
picalc n = fromIntegral (fac n)^2 * 2^(n+1) / fromIntegral (fac (2*n+1)) + picalc (n-1)

picalc2 :: Fractional a => Integer -> a
picalc2 0 = 2
picalc2 n = fromIntegral (f (n-1)^2 * t (n-1)) / fromIntegral (g (n-1))  +  picalc2 (n-1) where
  f 0 = 1
  f n = (n+1)*f (n-1)
  g 0 = 6
  g n = (2*n + 2) * (2*n + 3) * g (n - 1)
  t 0 = 4
  t n = 2^(n + 2)


    --teste com o fac recursivo aka f

facc 0 = 1
facc n = mul (facc (n-1), facc2 (n-1))

facc2 0 = 2
facc2 n = succ (p2 (facc (n-1),facc2 (n-1)))

faca 0 = 6
faca n = (2*n + 2)*(2*n + 3)*faca (n-1)

faca1 0 = 4
faca1 n = 2*n +4

faca2 0 = 5
faca2 n = 2*n + 5



faccM = cataNat (split (either (const 1) mul) (either (const 2) (succ . p2)))

facaM = cataNat (split (either (const 6) (mul . (id >< mul)) ) (split (either (const 4) (succ.succ.p1.p2)) (either (const 5) (succ.succ.p2.p2)) ))

termoM = cataNat (split (either (const 4) mul) (either (const 0) p2))


-- a maior piada de mal gosto:
picalcM :: Integer -> (Double,     (Integer, (Integer, (Integer, (Integer, (Integer, Integer))))))
picalcM = cataNat (split (either (const 2) (uncurry (+) . (id >< ( uncurry (/) . (fromIntegral . mul >< fromIntegral) . (( id >< (^2)) >< id) . swap . (id >< (id >< p1)) ))) ) (split (either (const 6) (mul . (id >< (mul . (p2.p2.p2))) . p2 )) (split (either (const 4) (dobro.p1.p2.p2) ) (split (either (const 1) (mul . (id >< p1) . p2 . p2 . p2) ) (split (either (const 2) (succ . p1 . p2 . p2 . p2 . p2)) (split (either (const 4) (succ . succ . p1 . p2 . p2 . p2 . p2 . p2)) (either (const 5) (succ.succ.p2.p2.p2.p2.p2.p2)  ) ) ) ) ) ) )

picalcMP = p1 . picalcM

picalcMF = for loop inic where
  inic = (2,6,4,1,2,4,5)
  loop (s,g,t,f,f2,g1,g2) = (s + fromIntegral (f^2*t)/fromIntegral g, g*g1*g2, dobro t, f*f2, succ f2, g1+2, g2+2)

h = wrapper . picalcMF

wrapper (x,_,_,_,_,_,_) = x



--funçao do gon pro exc dele

geraAreas :: [[(Int,Int)]] -> [Int]
geraAreas = cataList (either nil (cons . (maximum . map (uncurry (*) ) >< id) ) )

---



data Vec a = V {outV :: [(a,Int)] } deriving (Show)

data X = X1 | X2 | X3 deriving (Eq,Show,Ord)

{-
   X1  X2   X3 
  
F   1  -1   2
T   0  -3   1

-}


mat :: X -> Vec Bool
mat X1 = V [(False,1),(True,0)]
mat X2 = V [(False,-1),(True,-3)]
mat X3 = V [(False,2),(True,1)]

neg :: Bool -> Vec Bool
neg False = V [(False,0),(True,1)]
neg True  = V [(False,1),(True,0)]


instance Functor Vec where
    fmap f = V . map (f >< id) . outV

instance Applicative Vec where
    pure = return
    (<*>) = aap


instance Monad Vec where
   x >>= f = miuV (fmap f x)
   return = V . singl . split id (const 1)



miuaux :: ([(a,Int)],Int) -> [(a,Int)]
miuaux = map ((id >< uncurry (*)) . assocr). uncurry zip . (id >< uncurry replicate) . assocr . (split id length >< id)

miuV :: Vec (Vec a) -> Vec a
miuV = V . concatMap (miuaux . (outV >< id)) . outV
