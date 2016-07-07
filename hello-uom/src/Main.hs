{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

module Main where



data Count
    = Each
    | Half
    deriving (Show)


data Length
    = Inch
    | Feet
    deriving (Show)

data Quantity b a = Quantity b a deriving (Show)

--data Length a = Length Length a deriving (Show)


m = Quantity Each 1.0
n = Quantity Half 2.0

mulQty :: Quantity Count Double -> Quantity Count Double -> Quantity Count Double
mulQty (Quantity Each a) (Quantity Each b) = Quantity Each (a * b)
mulQty (Quantity Each a) (Quantity Half b) = Quantity Each (a * (b * 0.5))

--
-- x = Length 3.0
-- y = Length 5.0
--
--
-- mulQty (Quantity a) (Quantity b) = Quantity (a * b)
-- mulLen (Length a) (Length b) = Length (a * b)


main :: IO ()
main = do
      print "start"
      print $ m `mulQty` n
--    print $ x `mulLen` y


--mul (v1,u1) (v2,u2)



-- data Quantity = Quantity deriving (Show)
--
-- data Length = Length deriving (Show)
--
--
--
-- data Quantity uom = Quantity uom Double deriving (Show)
--
-- m = Quantity Length 3.0
-- n = Quantity Length 4.0
--
-- x = Quantity Quantity 2.0
-- y = Quantity Quantity 5.0
--
--
-- mul (Quantity Quantity a) (Quantity Quantity b) = Quantity Quantity (a * b)
-- mul (Quantity Length a) (Quantity Length b) = Quantity Length (a * b)
--
-- main :: IO ()
-- main = do
--     print $ m `mul` n
-- --    print $ x `mul` y



-- mul (Quantity a) (Quantity b) = Quantity (a * b)
-- mul (Length a) (Length b) = Length (a * b)
--
--
-- m = Quantity 2
-- n = Quantity 7
--
-- x = Length 3.0
-- y = Length 5.0



-- main :: IO ()
-- main = do
--     print $ m `mul` n
--     print $ x `mul` y
--     print $ m `mul` x

