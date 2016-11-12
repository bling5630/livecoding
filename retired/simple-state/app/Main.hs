module Main where

import Control.Monad.State

tick :: State Int Int




tick = do n <- get
          put (n+1)
          return n

-- tick = get >>= (\n ->
--         put (n + 1) >>= (\_ ->
--             return n))
-- 
-- tick = (>>=) get (\n ->
--          (>>=) (put (n + 1)) (\_ ->
--             return n ))
-- 
-- xbind = (>>=)
-- tick = xbind get (\n -> xbind (put (n + 1)) (\_ -> return n )) 


main = do 
    --print $ execState foo 
    --print $ (execState (State (\x -> (0,0)))) 3
    print $ (execState tick) 3
