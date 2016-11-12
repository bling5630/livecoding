module Main where

import           Data.Map (Map(..))
import qualified Data.Map as Map

import Data.Key

theMap :: Map (Integer,Integer) [Integer]
theMap = Map.fromList [((1,1),[100, 101, 102]), ((2,2),[200])]

foo (row, col) values = do
    print (row, col)
    print values

main = do
    mapWithKeyM_ foo theMap

