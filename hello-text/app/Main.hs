module Main where

import System.IO (hFlush, stdout)

import qualified Data.Text as T
import qualified Data.Char as C

--
-- functions with side effects must return IO types.
-- is it because I used do?
-- not possible to include
--
getTextLine :: IO T.Text
getTextLine = do
    getLine >>= \x -> (return (T.pack x))


main :: IO ()
main = do
    putStr "enter text: "
    line <- getTextLine
    print line
    print (T.length line)
    print (T.reverse line)
    print (T.null line)
    print (T.toUpper line)
    print (T.toLower line)
    print (T.justifyLeft 20 '.' line)
    print (T.justifyRight 20 '.' line)
    print (T.center 20 '.' line)
    print (T.any C.isDigit line)
    print (T.all C.isDigit line)
