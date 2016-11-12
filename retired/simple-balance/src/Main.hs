{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

import BasicPrelude
import Control.Applicative
import Control.Monad.Loops

import Data.Monoid

import System.IO (hFlush, stdout)

promptLine msg = do
    putStr $ msg <> ": "
    hFlush stdout
    getLine

promptNumber :: Text -> IO (Maybe Integer)
promptNumber msg = do
    line <- promptLine msg
    return $ readMay line



xuntil action mytest balance = do
    newBalance <- action balance
    if mytest newBalance
        then return (newBalance)
        else xuntil action mytest newBalance


main = do
    startingBalance <- untilJust $ promptNumber "Enter opening balance"
    endingBalance <- xuntil foo (\x -> x > 100) startingBalance
    putStrLn $ "Ending balance " ++ (show endingBalance)
    where
        foo init = do
            putStrLn $ "initial balance = " ++ (show init)
            deposit <- untilJust $ promptNumber "Enter amount to deposit"
            return $ init + deposit
