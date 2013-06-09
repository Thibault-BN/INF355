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
                      
probability :: Eq a => a -> Prob a -> Rational
probability x (Prob l) = let res = lookup x $ getList (canonize $ Prob l)
                         in case res of
                           Nothing -> 0
                           Just y -> y
                           
dice = sameProbability [1 .. 6]

double :: Prob Bool
double = do
  x <- dice
  y <- dice
  return $ x == y
  
pair :: Prob Int
pair = do
  x <- dice
  y <- dice
  return $ x + y
  
sick = Prob [(True, 1%100000), (False, 99999%100000)] 

positive :: Bool -> Prob Bool
positive True = Prob [(True, 999%1000), (False, 1%1000)]
positive False = Prob [(True, 1%1000), (False, 999%1000)]

renormalize :: Prob a -> Prob a
renormalize (Prob l) = Prob [(a, r / (sumProb l)) | (a, r) <- l]

results :: Prob Bool
results = renormalize $ do
  x <- sick
  y <- positive x
  if y then return x
       else fail ""