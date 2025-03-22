import Cp

alpha :: Either a a -> (Bool,a)
alpha (Left x) = split (const False) id x
alpha (Right x)  = split (const True) id x 


out :: Int -> Either () Int
out 0 = Left ()
out x = Right (x-1)