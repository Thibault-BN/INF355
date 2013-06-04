module Td2 where 

import Data.Ratio

data Prob a = Prob { getList :: [(a, Rational)]} deriving (Show)

sameProbability :: [a] -> Prob a
sameProbability l = Prob [(x, 1%(toInteger $ length l)) | x <- l]

conc :: Prob a -> Prob a -> Prob a
conc (Prob l1) (Prob l2) = Prob (l1 ++ l2)

instance Functor Prob where
  fmap f (Prob [(a,r)]) = Prob [(f a, r)]
  fmap f (Prob (x : xs)) = (fmap f (Prob [x])) `conc` (fmap f (Prob xs))
  
instance Monad Prob where
  return x = Prob [(x, 1)]
  Prob [] >>= _ = Prob []
  Prob [(a,r)] >>= f = Prob [(x, y * r) | (x, y) <- (getList (f a))]