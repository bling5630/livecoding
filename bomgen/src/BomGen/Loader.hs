{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module BomGen.Loader where

import BasicPrelude

import Control.Monad.Except
import Control.Monad.Reader

import BomGen.Config

type LoaderErr = Text

newtype Loader a =
    Loader { unLoader :: ReaderT Config (ExceptT LoaderErr IO) a
        } deriving
            ( Functor
            , Applicative
            , Monad
            , MonadReader Config
            , MonadError LoaderErr
            , MonadIO
            )

runDataLoader :: Loader a -> Config -> IO (Either LoaderErr a)
runDataLoader loader env = runExceptT (runReaderT (unLoader loader) env)
