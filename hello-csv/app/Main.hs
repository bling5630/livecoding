{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

data Sample = Sample
    { permaLink      :: !String
    , company        :: !String
    , numEmps        :: !String
    , category       :: !String
    , city           :: !String
    , state          :: !String
    , fundedDate     :: !String
    , raisedAmt      :: !String
    , raisedCurrency :: !String
    , round          :: !String
    }

instance FromNamedRecord Sample where
    parseNamedRecord r = Sample
        <$> r .: "permaLink"
        <*> r .: "company"
        <*> r .: "numEmps"
        <*> r .: "category"
        <*> r .: "city"
        <*> r .: "state"
        <*> r .: "fundedDate"
        <*> r .: "raisedAmt"
        <*> r .: "raisedCurrency"
        <*> r .: "round"

main :: IO ()
main = do
    csvData <- BL.readFile "sample.csv"
    case decodeByName csvData of
        Left err     -> putStrLn err
        Right (_, v) -> V.forM_ v $ \p ->
            putStrLn $ company p ++ " " ++ raisedAmt p
