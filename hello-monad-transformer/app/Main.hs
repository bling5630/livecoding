module Main where

import Control.Monad.Reader

import UI.NCurses
    ( Event(..)
    , Window(..)
    , Curses(..)
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
    , Update(..)
    )


type AppState  = Int
type AppConfig = Int

defState :: AppState
defState = 42

defConfig :: AppConfig
defConfig = 5


main = runCurses $ do
    setEcho False
    window <- defaultWindow
    runReaderT (renderScreen defState) window
    runReaderT (mainLoop defState) window


mainLoop :: AppState -> ReaderT Window Curses ()
mainLoop curState = do
    window <- ask
    event <- lift $ getEvent window Nothing
    case event of
        Nothing                   -> mainLoop curState
        Just (EventCharacter 'q') -> return ()
        Just event'               -> let nxtState = updateState event' curState in
                                       do renderScreen nxtState
                                          mainLoop nxtState


renderScreen :: AppState -> ReaderT Window Curses ()
renderScreen state = do
    window <- ask
    lift $ updateWindow window $ do
        moveCursor 0 0
        clearLine
        drawString $ show state
    lift $ render


updateState :: Event -> AppState -> AppState
updateState (EventCharacter 'h') curState = curState - 1
updateState (EventCharacter 'l') curState = curState + 1 
updateState _ curState = curState




--mainLoop :: Window -> AppState -> Curses ()
--mainLoop window curState = do
--    event <- getEvent window Nothing
--    case event of
--        Nothing                   -> mainLoop window curState
--        Just (EventCharacter 'q') -> return ()
--        Just event'               -> let nxtState = updateState event' curState in
--                                       do renderScreen window nxtState
--                                          mainLoop window nxtState

-- renderScreen :: Window -> AppState -> Curses ()
-- renderScreen window state = do
--     updateWindow window $ do
--         moveCursor 0 0
--         clearLine
--         drawString $ show state
--     render

