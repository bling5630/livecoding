module Main where

import Control.Monad.Reader

type Environment = [Integer]

foo :: Environment -> Integer
foo e = runReader sumEnvironment e

sumEnvironment :: Reader Environment Integer
sumEnvironment = do
    env <- ask
    return $ foldr (+) 0 env    

bar :: Environment -> Integer
bar e = runReader headEnvironment e

headEnvironment :: Reader Environment Integer
headEnvironment = do
    n <- asks head
    return n

baz :: Environment -> Integer
baz e = runReader sumModifiedEnvironment e

--
-- local takes a reader to reader function to modifiy
-- the environment 
--
sumModifiedEnvironment :: Reader Environment Integer
sumModifiedEnvironment = local (\r -> r ++ [4,5,6]) sumEnvironment


printReaderContent :: ReaderT String IO ()
printReaderContent = do
    content <- ask
    liftIO $ putStrLn ("The Reader Content: " ++ content)

main = do
    putStrLn $ show (foo sampleEnvironment)
    putStrLn $ show (bar sampleEnvironment)
    putStrLn $ show (baz sampleEnvironment)
    putStrLn "Say something: "
    line <- getLine
    runReaderT printReaderContent line 
  where sampleEnvironment = [1,2,3,4]

