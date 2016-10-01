{-# LANGUAGE ScopedTypeVariables #-}
module Main where


import System.Environment
import System.IO
import System.IO.Error
import Control.Exception

main = do

    --
    -- CATCH
    --
    home <- catch (getEnv "HOME")                                        -- computation to run
            (\(e :: IOException) -> return "some error message")         -- error handler
    print home


    --
    -- CATCHJUST
    --
    -- The value of the Just from the predicate function is the argument e
    -- in the handler... so in the example below in the `then Just e` code
    -- has the effect of just handing the exception `e` to the the handler
    -- function
    --
    home' <- catchJust (\e -> if isDoesNotExistError e then Just e else Nothing)   -- predicate
                       (getEnv "HOMExxxx")                                         -- the computation to run
                       (\e -> return (show e))                                     -- the handler
    print home'


    --
    -- TRY
    --
    home <- try $ getEnv "HOME"
    case home of
        Left  exception -> putStrLn $ show (exception :: IOException)
        Right home      -> putStrLn home


    --
    -- TRYJUST
    --
    home <- tryJust (\e -> if isDoesNotExistError e then Just e else Nothing)  -- predicate to filter exceptions
                    (getEnv "HOME")                                            -- computation to run
    case home of
        Left  exception -> putStrLn $ show exception
        Right home      -> putStrLn home


    --
    -- BRACKET
    --
    bracket
        (openFile "LICENSE" ReadMode)                -- computation to run first
        (hClose)                                     -- computation to run last
        (\fileHandle -> do                           -- computation to run in between
            size <- hFileSize fileHandle
            print size)
