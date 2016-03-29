module Main where

import Control.Monad.Reader
import Control.Monad.State

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


type AppConfig = Window

type AppState  = Int


type App = ReaderT AppConfig (StateT AppState Curses)


defState :: AppState
defState = 42


main = runCurses $ do
    setEcho False
    window <- defaultWindow
    runStateT (runReaderT (renderScreen) window) defState
    runStateT (runReaderT (mainLoop) window) defState

liftCurses = lift . lift


mainLoop :: App ()
mainLoop = do
    window <- ask
    event <- liftCurses $ getEvent window Nothing
    case event of
        Nothing                   -> mainLoop
        Just (EventCharacter 'q') -> return ()
        Just event'               -> do 
                                        modify (updateState event')
                                        renderScreen
                                        mainLoop


renderScreen :: App ()
renderScreen = do
    state <- get
    window <- ask
    liftCurses $ updateWindow window $ do
        moveCursor 0 0
        clearLine
        drawString $ show state
    liftCurses $ render


updateState :: Event -> AppState -> AppState
updateState (EventCharacter 'h') curState = curState - 1
updateState (EventCharacter 'l') curState = curState + 1 
updateState _ curState = curState

