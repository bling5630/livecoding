module BomGen.Config where

import System.Environment           (lookupEnv)
import BasicPrelude hiding          ((<>), readFile)

data Config = Config
    { format      :: Maybe String
    , forceErrors :: Maybe String
    , dataPath    :: Maybe FilePath
    } deriving (Show)


loadConfig :: IO Config
loadConfig = Config <$> lookupEnv "BOMGEN_FORMAT"
                    <*> lookupEnv "BOMGEN_ERROR"
                    <*> lookupEnv "BOMGEN_DATAPATH"
