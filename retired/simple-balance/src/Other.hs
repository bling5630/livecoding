{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

import BasicPrelude
import Control.Monad.Loops
import Control.Monad.State

import System.IO (hFlush, stdout)


data AppState = AppState { balance :: Integer } deriving (Eq, Show)

newtype App a =
    App { unApp :: StateT AppState IO a
        } deriving
            ( Functor
            , Applicative
            , Monad
            , MonadIO
            , MonadState AppState
            )

execApp :: AppState -> App a -> IO AppState
execApp state app = (execStateT . unApp) app state

prog :: App Integer
prog = do
    deposit <- liftIO $ untilJust $ promptNumber "Enter amount to deposit"
    state <- get
    put $ AppState{balance=(balance state) + deposit}
    return $ balance state

promptLine msg = do
    putStr $ msg <> ": "
    hFlush stdout
    getLine

promptNumber :: Text -> IO (Maybe Integer)
promptNumber msg = do
    line <- promptLine msg
    return $ readMay line

main = do
    startingBalance <- untilJust $ promptNumber "Enter an opening balance"
    let state = AppState startingBalance
    result <- execApp state prog
    print $ balance result
