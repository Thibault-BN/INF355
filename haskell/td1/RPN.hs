module RPN where

import System.IO

type Stack = [Integer]
type Operator = Stack -> Stack

parseOp :: String -> Operator
parseOp "+" = \s -> [head s + (s !! 1)] ++ (drop 2 s)
parseOp "*" = \s -> [head s * (s !! 1)] ++ (drop 2 s)
parseOp "-" = \s -> [(s !! 1) - head s] ++ (drop 2 s)
parseOp "/" = \s -> [(s !! 1) `div` head s] ++ (drop 2 s)
parseOp "dup" = \s -> [head s] ++ s
parseOp "swap" = \s -> [(s !! 1), head s] ++ (drop 2 s)
parseOp "drop" = \s -> tail s
parseOp "depth" = \s -> [toInteger(length s)] ++ s
parseOp "pick" = \s -> [s !! fromInteger(head s + 1)] ++ tail s
parseOp "clear" = \s -> []
parseOp x = \s -> [(read x) :: Integer] ++ s

eval :: a -> [a -> a] -> a
eval s [] = s
eval s (x : xs) = eval (x s) xs

parse :: String -> [Operator]
parse line = map (parseOp) (words line)

repl :: Stack -> IO ()
repl stack = do
  putStr "> "
  hFlush stdout
  line <- getLine
  newstack <- return $ eval stack (parse line)
  putStrLn $ show $ reverse newstack
  repl newstack
--main = repl []


  
  