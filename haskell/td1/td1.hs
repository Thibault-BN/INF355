module Td1 where

type Stack = [Int]
type Operator = Stack -> Stack

parseOp :: String -> Operator
parseOp "+" = \s -> [head s + (s !! 1)] ++ (drop 2 s)
parseOp "*" = \s -> [head s * (s !! 1)] ++ (drop 2 s)
parseOp "-" = \s -> [head s - (s !! 1)] ++ (drop 2 s)
parseOp "/" = \s -> [head s `div` (s !! 1)] ++ (drop 2 s)
parseOp "dup" = \s -> [head s] ++ s
parseOp "swap" = \s -> [(s !! 1), head s] ++ (drop 2 s)
parseOp "drop" = \s -> tail s
parseOp "depth" = \s -> [length s] ++ s
parseOp "pick" = \s -> [s !! (head s + 1)] ++ tail s
parseOp x = \s -> [(read x) :: Int] ++ s