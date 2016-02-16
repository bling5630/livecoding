module Main where

import HelloWriterMonad (foo)

import Control.Monad.Writer

f :: Integer -> Writer [String] Integer
f x = do
    tell ["f: " ++ show x]
    t <- g x 
    return $ t + 1 

g :: Integer -> Writer [String] Integer
g x = do
    tell ["g: " ++ show x]
    t <- h x
    return $ t + 10

-- 
-- same as g but unsugared syntax
--
h :: Integer -> Writer [String] Integer
h x = return x >>= \y ->
        tell ["h: " ++ show x] >>= \_ -> 
           return $ y + 10

--
-- deleteOn takes two arguments p and m.  The p is a predicate function
-- that's used to filter the writer monad that's passed as m.  The function
-- 'pass' takes a tuple of the value and a writer to writer function wrapped
-- in Writer.
--
-- in this case below it either returns mempty of the mappended value of x
-- 2 times depending on the predicate funciton
--
-- the listen just unwraps m to get value and writer
-- 
--
deleteOn :: (Monoid w) => (w -> Bool) -> Writer w a -> Writer w a
deleteOn p m = pass $ do
    (a, w) <- listen m
    if p w
        then return (a, (\x -> x <> x <> x))
        else return (a, const mempty)

--
-- just create a log entry nothing else
--
logOne :: Writer [String] ()
logOne = do
    deleteOn ((> 2) . length . head) $ tell ["logOne"]



main = do
    -- execWriter only returns the log
    putStrLn . show $ execWriter $ f 1 
    -- runWriter returns the (value, log) tuple
    putStrLn . show $ runWriter $ f 1 
    --
    -- example to demonstate 'pass' and 'listen' 
    putStrLn . show $ execWriter $ logOne
    
