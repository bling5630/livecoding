module BomGen.Loader where

import BasicPrelude hiding (readFile)

import Control.Monad.Except
import Control.Monad.Reader
import Data.Csv (decodeByName)
import Data.ByteString.Lazy           (readFile)

import BomGen.Data.Config
import BomGen.Data.AppData
import BomGen.Map.PartMap

type DataLoaderErr = Text

newtype DataLoader a =
    DataLoader { unLoader :: ReaderT Config (ExceptT DataLoaderErr IO) a
        } deriving
            ( Functor
            , Applicative
            , Monad
            , MonadReader Config
            , MonadError DataLoaderErr
            , MonadIO
            )

runDataLoader :: DataLoader a -> Config -> IO (Either DataLoaderErr a)
runDataLoader loader env = runExceptT (runReaderT (unLoader loader) env)


loadData :: DataLoader AppData
loadData = do
    partMap      <- loadPartMap
    operationMap <- loadPartMap
    materialMap  <- loadPartMap
    return AppData{..}


loadPartMap :: DataLoader PartMap
loadPartMap = do
    config <- ask
    contents <- liftIO $ readFile ((dataPath config) ++ "/parts.csv")
    case decodeByName contents of
        Left err           -> throwError (tshow err)
        Right (_, csvRows) -> return $ mkPartMap csvRows
