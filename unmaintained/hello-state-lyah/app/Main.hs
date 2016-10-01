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
    state (\s -> (1, [42]))
    modify (\s -> [10,11,12,13])
    push 3
    push 2
    push 1
    n <- pop
    return n
    
main = print $ runState stackStuff [] 
