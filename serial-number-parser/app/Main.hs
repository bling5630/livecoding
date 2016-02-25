module Main where

import SerialNumberParser 

main = do
    print $ SerialNumber { manfCode = ManfCode {country = Just "US", manf = "XYZ" }, serialId = "12345", month = 'A', buildYear = '6', modelYear = "16" }   
