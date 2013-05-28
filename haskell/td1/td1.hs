module Td1 where

type Stack = [Int]
type Operator = Stack -> Stack

parseOp :: String -> Operator
parseOp "+" = \s -> if (length s > 1)
                       then [(s !! 0) + (s !! 1)] ++ (drop 2 s) else s
parseOp "*" = \s -> if (length s > 1)
                       then [(s !! 0) * (s !! 1)] ++ (drop 2 s) else s
parseOp "-" = \s -> if (length s > 1)
                       then [(s !! 0) - (s !! 1)] ++ (drop 2 s) else s
parseOp "/" = \s -> if (length s > 1)
                       then [(s !! 0) `div` (s !! 1)] ++ (drop 2 s) else s
parseOp "dup" = \s -> if (length s > 0)
                         then [s !! 0] ++ s else s
parseOp "swap" = \s -> if (length s > 1)
                          then [(s !! 1), (s !! 0)] ++ (drop 2 s) else s
parseOp "drop" = \s -> if (length s > 1)
                          then drop 1 s else []