{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}

-- http://unbui.lt/#!/post/haskell-parsec-basics

module Main where

import Data.Tree


data Handle
    = RedHandle
    | GreenHandle
    | BlueHandle
    deriving (Show)


data Wheel
    = Wheel3Inch
    | Wheel4Inch
    | Wheel5Inch
    deriving (Show)


data PizzaCutter = PizzaCutter Handle Wheel deriving (Show)


bomOfHandle h = case h of
    RedHandle   -> Node "pn-1000 : red handle" []
    GreenHandle -> Node "pn-1001 : green handle" []
    BlueHandle  -> Node "pn-1002 : blue handle" []


bomOfWheel w = case w of
    Wheel3Inch  -> Node "pn-2000 : 3 inch wheel" []
    Wheel4Inch  -> Node "pn-2001 : 4 inch wheel" []
    Wheel5Inch  -> Node "pn-2002 : 5 inch wheel" []


bomOfPizzaCutter (PizzaCutter h w) = Node "pn-configured-pizza-cutter" [bomOfHandle h, bomOfWheel w]


main :: IO ()
main = do
    print $ PizzaCutter RedHandle Wheel3Inch
    print $ bomOfHandle BlueHandle
    print $ bomOfWheel Wheel4Inch
    putStrLn ""
    putStrLn $ drawTree $ bomOfPizzaCutter $ PizzaCutter RedHandle Wheel4Inch
