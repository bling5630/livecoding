module Main where

import System.IO
import Data.Text

import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.Maybe


greet :: IO ()
greet = do
    putStr "What is your name? "
    hFlush stdout
    n <- getLine
    putStrLn $ "Hello, " ++ n

mgreet :: MaybeT IO ()
mgreet = do
    liftIO $ putStr "What is your name? "
    liftIO $ hFlush stdout
    n <- liftIO $ getLine
    liftIO $ putStrLn $ "Hello, " ++ n

mcolor :: MaybeT IO String
mcolor = do
    liftIO $ putStr "What is your favorite color? "
    liftIO $ hFlush stdout
    color <- liftIO $ getLine
    if color /= "" 
        then MaybeT (return (Just color))
        else MaybeT (return Nothing)

main = do
    color <- runMaybeT mcolor 
    case color of
        Just c -> putStrLn $ "You like " ++ c
        Nothing -> putStrLn $ "no way to get here right now?"
    
