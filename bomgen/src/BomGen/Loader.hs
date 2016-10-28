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

runLoader :: Loader a -> Config -> IO (Either LoaderErr a)
runLoader loader env = runExceptT (runReaderT (unLoader loader) env)
