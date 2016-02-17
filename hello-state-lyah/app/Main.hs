module Main where
 
import Control.Monad.State

type AppValue = Int
type AppState = [Int]

push :: Int -> State AppState ()
push n = do
    stack <- get
    put ([n] ++ stack)
    return ()

pop :: State AppState Int
pop = do
    (h:t) <- get
    put t
    return h


stackStuff :: State AppState AppValue
stackStuff = do
    push 3
    push 2
    push 1
    n <- pop
    return n
    
main = print $ runState stackStuff [] 
