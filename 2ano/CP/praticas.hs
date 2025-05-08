import Cp
import Data.List (nub, sortBy, groupBy, mapAccumL)
import Data.Map (fromListWith)
import qualified Data.Map as Map
import Data.String
import Data.Bifunctor
import List


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


   --((Key,Aut*)*,(Pag,Key*)*) -> (Aut,Pag*)*

--TODO
mkInd :: (Num p, Ord a, Eq c) => ([(c,[a])],[(p,[c])]) -> [(a,[p])]
mkInd  =  juntaR . associaChave . (map swap >< map swap) .  (concatMap separateR >< concatMap separateR)

--72
--associa :: [(a,[b])] -> [(b,[a])]
--associa = fromListWith (++) . map swap . concatMap separateR

-- a :: Bib
--a = [(1,["Jose","Antonio"]),(12,["Andre","Jose"]),(1434,["Jose","Afonso"])]

hB = [(1,["A","B"]),(1,["B","D"]),(2,["C","A","F","E"]),(3,["D","B"]),(4,["E"]),(4,["F","D","E"])]
hP = [(11,[1,3,5]),(17,[2,3,4]),(21,[1,2,5]),(32,[2,3,4]),(31,[2]),(29,[1,6]),(90,[3]),(33,[3,5]),(42,[4,2])]

hB2 = map swap hB

associaChave :: Eq b => ([(a,b)],[(b,c)]) -> [(a,c)]
associaChave (auts,pags) = [(autor,pag) | (autor,key1) <- auts, (key2,pag) <- pags, key1 == key2]

juntaR :: Eq a => [(a,b)] -> [(a,[b])]
juntaR = map (split (head.map fst) (map snd)) . groupBy (\ (a1,_) (a2,_) -> a1 == a2)


separateR2 :: (a, [b]) -> [(a, b)]
separateR2 (_, []) = []
separateR2 (key, h : t) = (key, h) : separateR (key, t)


separateR :: (a, [b]) -> [(a, b)]
separateR = uncurry zip . (uncurry replicate . swap >< id) . split (id >< length) p2

for :: (a -> a) -> a -> Int -> a
for b i 0 = i
for b i x = b (for b i (x - 1))  -- Corrigimos a ordem das operações

t =([("a",10),("b",20),("c",30)],[(1.2,10),(1.3,21),(1.4,31)])

glue :: ([(k1,v)],[(k2,v)]) -> [(Either k1 k2,v)]
glue = uncurry (++) . (map (i1 >< id) >< map (i2 >< id))

concatTuple :: [([a], [b])] -> ([a], [b])
concatTuple [] = ([],[])
concatTuple (x:xs) = (fst x ++ fst (concatTuple xs), snd x ++ snd (concatTuple xs))

unglue :: [(Either k1 k2,v)] -> ([(k1,v)],[(k2,v)])
unglue = concatTuple .  map (either (split singl nil) (split nil singl) . distl)

tiraDaLista :: Eq a => [a] -> (a,[a])   -- NAO é assim que se faz isso nao funciona direito mas a base é a funçao mynub...
tiraDaLista = either (split head tail . p2) id . grd (uncurry elem) . split head tail

mynub :: Eq a => [a] -> [a]
mynub = either nil cons . (id -|- ( id >< mynub) . tiraDaLista) . grd null

mysuffixes :: [a] -> [[a]]
mysuffixes = anaList ((id -|- split cons p2) . outList)

auxarea :: (Int,(Int,Int)) -> Int
auxarea = uncurry (*) . (either p2 p1 >< id) . (grd (uncurry (>)) >< id) . assocl

area :: (Int,[Int]) -> Int
area = maximumInt . map auxarea . uncurry zip . (uncurry replicate . swap >< id ) . split (id >< length) p2  . (id >< map swap . zip [1..])


maximumInt :: [Int] -> Int
maximumInt = cataList (either (const 0) (uncurry max))

pool :: [Int] -> Int
--pool = hyloList (either (const 0) (uncurry max) . (id -|- (area . split head tail) >< id )) ((id -|- split cons p2) . outList)
pool = hyloList (either (const 0) (uncurry max . ((area . split head tail) >< id)))  ((id -|- split cons p2) . outList)




aux :: ((a,s) -> Bool) -> ((a,s) -> (c,s)) -> (a,([c],s)) -> ([c],s)
aux h f =  either (swap . ( id >< uncurry (:) ) . assocr . (swap >< id) . p2) ( swap . (p2 >< id ) . p2) . grd p1 . (h >< (f >< id)) . split (id >< p2) (assocl . (id >< swap))

outLP :: ([a],s) -> Either ((),s) (a,([a],s))
outLP ([],s) = i1 ((),s)
outLP (h:t,s) = i2 (h,(t,s)) 




mapAccumLfilter :: ((a,s) -> Bool) -> ((a,s) -> (c,s)) -> ([a],s) -> ([c],s)
mapAccumLfilter h f = either (nil >< id) (aux h f) . (id -|- (id >< mapAccumLfilter h f )) . outLP





--tudo isto a baixo foi uma tentativa...
--mapAccumLfilter :: ((a,s) -> Bool) -> ((a,s) -> (c,s)) -> ([a],s) -> ([c],s)
--mapAccumLfilter h f =  either nil aux . (id -|- (id >< mapAccumLfilter h f)) .  (id -|- ( assocr . (split head tail >< id))) . grd (null . p1)

--cataList (either (const 0) (uncurry max) . (id -|- (area . split head tail) >< id ) ) . anaList ((id -|- split cons p2) . outList)
--maximumInt . map (area . split head tail) . mysuffixes

--mapAccL :: ((a,s) -> (c,s)) -> ([a],s) -> [(c,s)]
--mapAccL g = anaList((p1 -|- split (g . p1 . assocl . (id >< swap) . assocr) ((id >< p2 . g) . assocr . (swap >< id) )) . distl . (outList >< id))
