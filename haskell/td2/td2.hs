module Td2 where 

import Data.Ratio
import Data.List

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
  Prob (x : xs) >>= f = Prob [(a, r * (snd x)) | (a, r) <- (getList (f $ fst x))] `conc` ((Prob xs) >>= f)
  fail = const $ Prob []
  
predic :: Eq a => (a, Rational) -> (a, Rational) -> Bool
predic x = (\y -> fst x == fst y)   

sumProb :: [(a, Rational)] -> Rational
sumProb [] = 0
sumProb (x : xs) = snd x + sumProb xs 

canonize :: Eq a => Prob a -> Prob a
canonize (Prob []) = Prob []
canonize (Prob l) = let (eq, noneq) = partition (predic $ head l) l
                    in Prob [(fst $ head $ eq, sumProb eq)] `conc` canonize (Prob noneq)
                      

  