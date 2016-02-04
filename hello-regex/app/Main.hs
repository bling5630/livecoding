module Main where

import System.IO
import Data.Char
import Text.Regex.Posix

gsub :: String -> String -> String -> String
gsub regex replacement source =
    case (source =~ regex) of
        (_, "", _) -> source
        (before, _, after) -> before ++ replacement ++ (gsub regex after replacement)


process :: FilePath -> FilePath -> (String -> String) -> IO ()
process fileIn fileOut f = do
    x <- fmap lines $ readFile fileIn
    writeFile fileOut $ unlines $ map f x 


main = process "haiku.txt" "out.txt" $ gsub "s" "$"
