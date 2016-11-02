module BomGen.Data.Config where

import BasicPrelude

data Config = Config
    { format       :: Maybe String
    , forceErrors  :: Maybe String
    , dataPath     :: FilePath
    , renderFormat :: RenderFormat
    } deriving (Show)

data RenderFormat
    = RenderSummary
    | RenderTree
    | RenderExport
    deriving (Show)
