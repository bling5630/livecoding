module BomGen.ConfigLoader where

import System.Environment           (lookupEnv)
import BasicPrelude hiding          ((<>), readFile)
import Data.Text                    (toUpper)
import Control.Monad.Except

import BomGen.Data.Config

type SetupErr = Text

newtype Setup a =
    Setup { unSetup :: ExceptT SetupErr IO a
        } deriving
            ( Functor
            , Applicative
            , Monad
            , MonadError Text
            , MonadIO
            )


runConfigLoader :: Setup a -> IO (Either SetupErr a)
runConfigLoader = runExceptT . unSetup


lookupRenderFormat :: Setup RenderFormat
lookupRenderFormat = do
    format <- liftIO $ lookupEnv "BOMGEN_FORMAT"
    case (fmap (toUpper . fromString) format) of
        Nothing  -> return $ RenderSummary
        Just fmt -> case fmt of
            "SUMMARY" -> return $ RenderSummary
            "EXPORT"  -> return $ RenderExport
            "TREE"    -> return $ RenderTree
            ""        -> return $ RenderTree
            _         -> throwError "unknown value for BOMGEN_FORMAT"


loadConfig :: Setup Config
loadConfig = do
    format       <- liftIO $ lookupEnv "BOMGEN_FORMAT"
    werror       <- liftIO $ lookupEnv "BOMGEN_WERROR"
    dataPath'    <- liftIO $ lookupEnv "BOMGEN_DATAPATH"
    renderFormat <- lookupRenderFormat
    case dataPath' of
        Nothing       -> throwError "missing BOMGEN_DATAPATH"
        Just dataPath -> return Config {..}
