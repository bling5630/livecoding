{-# LANGUAGE OverloadedStrings #-}

module Main where

-- import qualified Data.Text as T
-- import qualified Data.Text.IO as T
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

import qualified Data.Aeson as A
import Data.ByteString.Lazy as B

main = do
    B.putStrLn $ A.encode(1 :: Integer)
