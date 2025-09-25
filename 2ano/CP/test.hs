import Cp


dobro :: Int -> Int
dobro x = x+x


pLogic1 :: (a,b) -> Either a b
pLogic1 (x,y) = Left p1 (x,y)

pLogic2 :: (a,b) -> Either a b
pLogic2 (x,y) = Right p2 (x,y)



not :: ((a,b) -> Either a b) -> Either a b
not x = x . swap
