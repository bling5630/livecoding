module Main where

import System.IO (hFlush, stdout)

import Data.Time.Clock
import Data.Time.LocalTime
import Data.Time.Format
--import Data.Time.Calendar



-- main = do
--     putStr "What is your name? "
--     hFlush stdout
--     line <- getLine
--     putStrLn $ "Hello, " ++ line ++ ", nice to meet you!"
--     return ()
--

-- main = do
--     putStr "What is the input string? "
--     hFlush stdout
--     line <- getLine
--     putStrLn $ "Homer has " ++ (show (length line)) ++ " characters"
--     return ()
--
--

-- main = do
--     quote <- getInput "What is the quote?"
--     author <- getInput "Who said it?"
--     putStrLn $ author ++ " says, \"" ++ quote ++ "\""

-- main = do
--     noun <- getInput "Enter a noun:"
--     verb <- getInput "Enter a verb:"
--     adjective <- getInput "Enter an adjective:"
--     adverb <- getInput "Enter an adverb:"
--     putStrLn $ "Do you " ++ verb ++ " your " ++ adjective ++ " " ++ noun ++ " " ++ adverb ++ "? That's hilarious!"
--
--main = do
--    n1 <- getInt "What is the first number?"
--    n2 <- getInt "What is the second number?"
--    putStrLn $ (show n1) ++ " + " ++ (show n2) ++ " = " ++ (show(n1 + n2))
--    putStrLn $ (show n1) ++ " - " ++ (show n2) ++ " = " ++ (show(n1 - n2))
--    putStrLn $ (show n1) ++ " * " ++ (show n2) ++ " = " ++ (show(n1 * n2))
--    putStrLn $ (show n1) ++ " / " ++ (show n2) ++ " = " ++ (show(n1 `div` n2))
--    return ()

--
-- main = do
--     t <- getZonedTime
--     let year = read (formatTime defaultTimeLocale "%Y" t) :: Int
--     age <- getInt "What is your current age?"
--     retirementAge <- getInt "At what age would you like to retire?"
--     let r1 = show (retirementAge - age)
--     let r2 = show (retirementAge - age + year)
--     putStrLn $ "You have " ++ r1 ++ " years left until you can retire."
--     putStrLn $ "It's " ++ (show year) ++ ", so you can retire in " ++ r2 ++ "."
--     return ()
--
-- main = do
--     l <- getInt "What is the length of the room in feet?"
--     w <- getInt "What is the width of the room in feet?"
--     let sqft = l * w
--     let sqm = (fromIntegral sqft) * 0.092903
--     putStrLn $ "You entered dimensions of " ++ (show l) ++ "feet by " ++ (show w) ++ " feet."
--     putStrLn $ "The area is "
--     putStrLn $ (show sqft) ++ " square feet" 
--     putStrLn $ (show sqm) ++ " square meters" 
--
-- main = do
--     numPeople <- getInt "How many people?"
--     numPizza <- getInt "How many pizzas do you have?"
--     numSlices <- getInt "How many slices per pizza?"
--     let totalSlices = numPizza * numSlices
--     let q = totalSlices `div` numPeople
--     let r = totalSlices `rem` numPeople 
--     putStrLn $ (show numPeople) ++ " people with " ++ (show numPizza) ++" pizzas"
--     putStrLn $ "Each person gets " ++ (show q) ++ " pieces of pizza."
--     putStrLn $ "There are " ++ (show r) ++ " leftover pieces."


getInput :: String -> IO String
getInput prompt = do
    putStr $ prompt ++ " "
    hFlush stdout
    getLine


getInt :: String -> IO Int
getInt prompt = do
    putStr $ prompt ++ " "
    hFlush stdout
    line <- getLine
    return $ (read line :: Int)

main = print "bingo"




