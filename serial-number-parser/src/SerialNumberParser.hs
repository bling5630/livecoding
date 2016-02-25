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
module SerialNumberParser
    ( parseSerial
    , SerialNumber(..)
    , ManfCode(..)
    ) where


import Data.Maybe
import Text.ParserCombinators.Parsec

data SerialNumber = SerialNumber 
    { manfCode     :: ManfCode
    , serialId     :: String
    , month        :: Char
    , buildYear    :: Char
    , modelYear    :: String
    } deriving (Eq, Show)

data ManfCode = ManfCode
    { country :: Maybe String
    , manf    :: String
    } deriving (Eq, Show)

serialString :: GenParser Char st SerialNumber
serialString = SerialNumber
            <$> manfRecord
            <*> serialIdString
            <*> monthLetter
            <*> buildYearDigit
            <*> modelYearDigits
            <*  newline

manfRecord :: GenParser Char st ManfCode
manfRecord =  try longManfString
          <|> shortManfString
          <?> "manf designator with optional country code"

longManfString :: GenParser Char st ManfCode
longManfString = ManfCode . Just <$> count 2 letter
                                 <*> count 3 letter

shortManfString :: GenParser Char st ManfCode
shortManfString = ManfCode Nothing <$> count 3 letter

serialIdString :: GenParser Char st String
serialIdString = count 5 digit

monthLetter :: GenParser Char st Char
monthLetter = oneOf "abcdefghijklABCDEFGHIJKL"

buildYearDigit :: GenParser Char st Char
buildYearDigit = digit

modelYearDigits :: GenParser Char st String
modelYearDigits = count 2 digit

parseSerial :: String -> Either ParseError SerialNumber
parseSerial = parse serialString "unknown"
