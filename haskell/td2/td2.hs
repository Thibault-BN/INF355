module Td2 where 

import Data.Ratio

data Prob a = Prob [(a, Rational)] deriving (Show)

sameProbability :: [a] -> Prob a
sameProbability l = Prob (map (\x -> (x, 1%(toInteger $ length l))) l)

