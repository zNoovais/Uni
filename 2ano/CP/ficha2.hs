import Cp



--1.

fcir :: ((Bool,Bool),Bool) -> Bool
fcir ((p,q),r) = (/=) ((&&) p q) r

data X = B Bool | P (Bool,Int)

