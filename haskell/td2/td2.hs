module Td2 where 

import Data.Ratio

data Prob a = Prob [(a, Rational)] deriving (Show)

createCouple l x = (x, 1%l)

sameProbability :: [a] -> Prob a
sameProbability [] = Prob []
sameProbability l = Prob (map (\x -> (x, 1%(toInteger $ length l))) l)