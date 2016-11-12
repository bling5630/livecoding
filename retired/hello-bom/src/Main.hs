{-# LANGUAGE TemplateHaskell #-}

module Main where

import Data.Tree

import Control.Lens (makeLenses, view, set, (^.), (&), (.~), (%~), (+~), (-~))

data Item = Item
    { _pn :: PartNumber
    , _uom :: UnitOfMeasure
    , _qty :: Quantity
    , _cost :: Amount
    , _desc :: String
    } deriving (Eq, Show)

type PartNumber = String

type Quantity = Double

type Amount = Int

data UnitOfMeasure
    = Each
    | Halfs
    deriving (Eq, Show)

makeLenses ''Item

defItem = Item
    { _pn = "default pn"
    , _uom = Each
    , _qty = 1
    , _cost = 1
    , _desc = "default desc"
    }


main :: IO ()
main = do
    -- Data.Function (&) :: a -> (a -> b) -> b
    --    reverse application operator.  It's precedence is one higher
    --    than the forward application operator $ which allows & to
    --    be nested in $
    putStrLn "(&)"
    print $ _qty defItem
    print $ defItem & _qty
    -- the _qty function takes a single argument
    -- which is an Item... so bassing that value
    -- then & and then a function works

    putStrLn "view"
    print $ view qty defItem
    print $ defItem ^. qty

    putStrLn "set"
    print $ set qty 42 defItem
    print $ defItem & qty .~ 42
    print $ (.~) qty 42 defItem
    --    qty is a partially applied function waiting for a defItem
    --    but it's passed to .~ along with 42 which makes the result
    --    of that a partially applied function waiting for an Item it
    --    can extract the qty from and replace it with a 42

    putStrLn "update"
    print $ defItem & qty %~ (+ 42)
    print $ (%~) qty (+42) defItem

    putStrLn "increment"
    print $ defItem & qty +~ 1.5
    print $ (+~) qty 1.5 defItem

    putStrLn "decrement"
    print $ defItem & qty -~ 0.5
    print $ (-~) qty 0.5 defItem



--
-- Data.Function (&)  - reverse application operator
--                      it's precedence is one higher than the forward
--                      operator $ which allows & to be nested in $
--
--     so $ takes a function (a -> b) as the first param
--     and the value a and returns b
--
--     ($) :: (a -> b) -> a -> b
--
--     where & takes the value a and then a function a -> b
--     and returns b
