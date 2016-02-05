{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

main :: IO ()
main = do
    csvData <- BL.readFile "../sample.csv"
    case decode NoHeader csvData of
        Left err -> putStrLn err
        Right v -> V.forM_ v $ \ (permalink :: String, company :: String, numEmps :: String, category :: String, city :: String, state :: String, fundedDate :: String, raisedAmt :: String, raisedCurrency :: String, round :: String) ->
            putStrLn $ company ++ " " ++ raisedAmt

