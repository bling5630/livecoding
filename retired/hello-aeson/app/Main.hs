{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Monad
import           Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as B
import qualified Text.Show.ByteString       as B
import           Data.Text.Encoding

import qualified Data.Text    as T
import qualified Data.Text.IO as T

data Pizza = Cheese | Sausage deriving Show

data PizzaOrder = PizzaOrder
    { quantity :: !Integer
    , pizza    :: Maybe Pizza
    } deriving Show

data Person = Person
    { firstName  :: !T.Text
    , lastName   :: !T.Text
    , age        :: Integer
    , pizzaOrder :: PizzaOrder
    } deriving Show 


instance ToJSON Pizza where
    toJSON _ = "a pizza of some kind"

instance ToJSON PizzaOrder where
    toJSON (PizzaOrder quantity pizza) =
        object [ "quantity" .= quantity
               , "pizza"    .= pizza
               ]

instance FromJSON PizzaOrder where
    parseJSON (Object v) =
        PizzaOrder <$> v .: "quantity"
                   <*> liftM parsePizza (v .: "pizza")
    parseJSON _ = mzero

instance FromJSON Person where
    parseJSON (Object o) =
        Person <$> o .: "firstName"
               <*> o .: "lastName"
               <*> o .: "age"
               <*> o .: "pizzaOrder" 
    parseJSON _ = mzero

instance ToJSON Person where
 toJSON (Person firstName lastName age pizzaOrder) =
    object [ "firstName"  .= firstName
           , "lastName"   .= lastName
           , "age"        .= age
           , "pizzaOrder" .= pizzaOrder
           ]    

parsePizza :: String -> Maybe Pizza
parsePizza "cheese"  = Just Cheese
parsePizza "sausage" = Just Sausage
parsePizza _         = Nothing 

getJSON :: IO B.ByteString
getJSON = B.readFile "sample2.json" 

main = do
    decodedPerson <- (decode <$> getJSON) :: IO (Maybe Person)
    B.putStrLn $ encode decodedPerson
