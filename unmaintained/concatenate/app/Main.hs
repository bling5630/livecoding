module Main where

append :: [a] -> [a] -> [a]
append []     ys = ys
append (x:xs) ys = x : xs `append` ys

concatenate :: [[a]] -> [a]
concatenate [] = []
concatenate (x:[]) = x
concatenate (x:xs) = x `append` concatenate xs 

main = do
    print $ concatenate ([]::[[Int]])
    print $ concatenate ([[]]::[[Int]])
    print $ concatenate ([[],[]]::[[Int]])
    print $ concatenate ([[1]]::[[Int]])
    print $ concatenate ([[1,2,3],[4,5,6],[7,8,9]]::[[Int]])
