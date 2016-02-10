{-# LANGUAGE OverloadedStrings #-}

module Main where

-- import qualified Data.Text.Encoding as T
-- import qualified Data.ByteString.Lazy as B
-- import Data.Aeson
-- 
-- 
-- main = do
--     let x = (encode (1 :: Integer) :: T.Text)
--     T.putStrLn $ T.decodeUtf8 $ B.toStrict $ encode ([1,2,3] :: [Int])

-- import qualified Data.Text.Lazy.IO as T
-- import qualified Data.Text.Lazy.Encoding as T
-- import qualified Data.Aeson as A
-- 
-- 
-- main = do
--     T.putStrLn $ T.decodeUtf8 $ A.encode (1 :: Integer)
--

import           Control.Monad
import           Data.Aeson
import qualified Data.ByteString.Lazy as B
import           Data.Text.Encoding

import qualified Data.Text as T
import qualified Data.Text.IO as T

data Person = Person
    { firstName  :: !T.Text
    , lastName   :: !T.Text
    , age        :: Integer
    , likesPizza :: Bool
    } deriving Show 

instance FromJSON Person where
    parseJSON (Object v) =
        Person <$> v .: "firstName"
               <*> v .: "lastName"
               <*> v .: "age"
               <*> v .: "likesPizza"
    parseJSON _ = mzero

getJSON :: IO B.ByteString
getJSON = B.readFile "sample.json" 

main = do
    d <- (decode <$> getJSON) :: IO (Maybe [Person])
    case d of
        Nothing -> Prelude.putStrLn "bang!"
        Just (p:ps)  -> T.putStrLn $ lastName p

-- http://blog.raynes.me/blog/2012/11/27/easy-json-parsing-in-haskell-with-aeson/
