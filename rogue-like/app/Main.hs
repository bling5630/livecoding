module Main where

import UI.NCurses
    ( Event(..)
    , runCurses
    , setEcho
    , defaultWindow
    , moveCursor
    , drawString
    , render
    , getEvent
    , updateWindow
    , clear
    , clearLine
    )

data GameState = GameState 
    { quitGame :: Bool
    , playerCol :: Int
    , playerRow :: Int
    } deriving (Eq, Show) 

defGameState = GameState
    { quitGame = False
    , playerCol = 0
    , playerRow = 0
    }


main :: IO ()
main = runCurses $ do
    setEcho False
    window <- defaultWindow
    gameLoop window defGameState


gameLoop window curGameState = do
    updateWindow window $ do
        moveCursor 1 10
        clearLine
        drawString $ show curGameState 
        moveCursor 3 10
        drawString "(press q to quit)"
    render
    event <- getEvent window Nothing
    case event of
        Nothing -> gameLoop window curGameState
        Just event' -> 
            let nxtGameState = updateGameState event' curGameState in 
            if quitGame nxtGameState
              then return ()
              else gameLoop window nxtGameState 


updateGameState :: Event -> GameState -> GameState
updateGameState (EventCharacter 'q') curGameState = curGameState{quitGame=True}
updateGameState (EventCharacter 'k') curGameState = curGameState{playerRow=(playerRow curGameState) + 1}
updateGameState (EventCharacter 'j') curGameState = curGameState{playerRow=(playerRow curGameState) - 1}
updateGameState (EventCharacter 'h') curGameState = curGameState{playerCol=(playerCol curGameState) - 1}
updateGameState (EventCharacter 'l') curGameState = curGameState{playerCol=(playerCol curGameState) + 1}
updateGameState _ curGameState = curGameState

