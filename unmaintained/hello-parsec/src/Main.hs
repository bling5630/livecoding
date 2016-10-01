{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}

module Main where

import qualified Text.Parsec as Parsec --(parse, char, string, (<?>), label)
import qualified Text.Parsec.Token as Parsec


parse p = Parsec.parse p "(source)"

--parseH :: String -> Either Parsec.ParseError Char
parseH = Parsec.char 'h'

parseHs = (Parsec.many (Parsec.char 'h'))

--parseH = parse $ do
--    Parsec.char 'h'


parseHs1 = Parsec.many1 (Parsec.char 'h')

parseHello = Parsec.string "hello"

parseSeqChars = do
    c1 <- Parsec.char 'h'
    c2 <- Parsec.char 'e'
    c3 <- Parsec.char 'l'
    c4 <- Parsec.char 'l'
    c5 <- Parsec.char 'o'
    return [c1, c2, c3, c4, c5]

-- skip parser as many times as it exists
parseSkipXs = do
    Parsec.skipMany (Parsec.char 'x')
    Parsec.string "hello"

parseSkip1Xs = do
    Parsec.skipMany1 (Parsec.char 'x')
    Parsec.string "hello"


parseCount3Xs = do
    Parsec.count 3 (Parsec.char 'x')


-- --parseXBetweenParens :: String -> Either Parsec.ParseError Char
parseHBetweenParens = do
    Parsec.between (Parsec.char '(') (Parsec.char ')') parseHello


parseOption = do
    Parsec.option "fail" parseHello

parseOptionMaybe = do
    Parsec.optionMaybe parseHello


-- skip the optional parser 1 time if it exists
-- skip exactly that parser or nothing
parseOptionalXs = do
    Parsec.optional (Parsec.string "xxx")
    parseHello

main = do
    print $ parse parseH "hello"
    print $ parse parseHs "hhhhello"
    print $ parse parseHs "ello"
    print $ parse parseHs1 "ello"
    print $ parse parseHello "hello"
    print $ parse parseSeqChars "hello"
    print $ parse parseSkipXs "xxxxxhello"
    print $ parse parseSkip1Xs "hello"
    print $ parse parseCount3Xs "xxx"
    print $ parse parseHBetweenParens "(hello)"
    print $ parse parseOption "hello"
    print $ parse parseOptionMaybe "hello"
    print $ parse parseOptionalXs "xxxhello"


-- -- http://unbui.lt/#!/post/haskell-parsec-basics
--
--
-- import Foo (foo)
-- import Data.Tree
-- import qualified Text.Parsec as Parsec
-- import           Text.Parsec              ((<?>))
-- import           Control.Applicative
-- import           Control.Monad.Identity   (Identity)
--
-- parseH source = parse (Parsec.char 'H') source
--
--
-- parseHello source = parse (Parsec.string "Hello") source
--
--
-- parse rule text = Parsec.parse rule "(source)" text
--
-- main = do
--     --print $ parseH "H"
--     --print $ parseH "Not Hello"
--     --print $ parseHello "Hello"
--     print $ parse (Parsec.char 'H') "Hello"
--     print $ parse (Parsec.string "Hello") "Hello"
--     print $ parse (Parsec.oneOf "abcde") "c"
--     print $ parse (Parsec.many (Parsec.char 'h')) "hhhhello"
