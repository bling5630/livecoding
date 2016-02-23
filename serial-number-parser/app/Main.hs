--
-- US PPP DDDDD M y YY
--
-- US    - country code
-- MANF   - manf. designation
-- DDDDD - 5 digit serialId 
-- M     - [A-L] leter code designating a month
-- y     - single year of manufacture
-- YY    - model year
--
--
module Main where

import Data.Maybe
import Text.ParserCombinators.Parsec

data SerialNumber = SerialNumber 
    { manfCode     :: ManfCode
    , serialId     :: String
    , month        :: Char
    , buildYear    :: Char
    , modelYear    :: String
    } deriving Show

data ManfCode = ManfCode
    { country :: Maybe String
    , manf    :: String
    } deriving Show

serialString :: GenParser Char st SerialNumber 
serialString = do
    mc <- manfRecord
    s  <- serialIdString
    m  <- monthLetter
    by <- buildYearDigit
    my <- modelYearDigits
    newline
    return SerialNumber 
        { manfCode = mc
        , serialId = s
        , month = m
        , buildYear = by
        , modelYear = my
        }

manfRecord :: GenParser Char st ManfCode
manfRecord = do
    (c, d) <-  try longManfString
           <|> shortManfString 
           <?> "manf designator with optional country code"
    return ManfCode { country = c, manf = d }

longManfString :: GenParser Char st (Maybe String, String)
longManfString = do
    c <- count 2 letter
    d <- count 3 letter
    return (Just c, d)

shortManfString :: GenParser Char st (Maybe String, String)
shortManfString = do
    d <- count 3 letter
    return (Nothing, d)

serialIdString :: GenParser Char st String
serialIdString = return =<< count 5 digit

monthLetter :: GenParser Char st Char
monthLetter = return =<< oneOf "abcdefghijklABCDEFGHIJKL"

buildYearDigit :: GenParser Char st Char
buildYearDigit = return =<< digit

modelYearDigits :: GenParser Char st String
modelYearDigits = return =<< count 2 digit

parseSerial :: String -> Either ParseError SerialNumber
parseSerial input = parse serialString "unknown" input

main = print $ parseSerial "XYZ12345l616\n"
