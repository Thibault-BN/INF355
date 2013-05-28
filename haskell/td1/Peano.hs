module Peano where

data Peano = Zero | Succ Peano deriving (Eq, Read, Ord)

instance Num Peano where
  a + Zero = a
  a + Succ b = Succ (a + b)
  
  _ * Zero = Zero
  a * Succ b = a + (a * b)
  
  a - Zero = a
  --case needed for mul div test
  Zero - b = b
  Succ a - Succ b = (a - b)
  
  abs a = a
  
  fromInteger 0 = Zero 
  fromInteger i = Succ (fromInteger (i - 1))
  
  signum Zero = 0
  signum _ = 1
  
instance Show Peano where
  show Zero = "Zero"
  show (Succ Zero) = "Succ Zero"
  show (Succ a) = "Succ (" ++ (show a) ++ ")"
  
instance Enum Peano where
  toEnum 0 = Zero
  toEnum i = Succ (toEnum (i-1))
  
  fromEnum Zero = 0
  fromEnum (Succ a) = 1 + (fromEnum a)
  
instance Integral Peano where
  toInteger Zero = 0
  toInteger (Succ a) = 1 + (toInteger a)
  
  quotRem Zero _ = (Zero, Zero)
  quotRem a b = (fromInteger(toInteger(a) `div` toInteger(b)), fromInteger(toInteger(a) `rem` toInteger(b)))
  
instance Real Peano where
  toRational Zero = 0
  toRational (Succ a) = 1 + (toRational a)