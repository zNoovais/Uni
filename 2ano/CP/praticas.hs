import Cp
import Data.List (nub, sortBy, groupBy)
import Data.Map (fromListWith)
import qualified Data.Map as Map
import Data.String

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