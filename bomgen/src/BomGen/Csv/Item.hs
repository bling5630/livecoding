module BomGen.Csv.Item where

import BasicPrelude hiding          ((<>), readFile)
import Data.Csv                     (FromNamedRecord, parseNamedRecord, (.:), FromField, parseField)

import BomGen.Data.ItemHeader

data CsvItem = CsvItem
    { csvPn    :: ItemNumber
    , csvUoM   :: UnitOfMeasure
    , csvDesc  :: Description
    } deriving (Show)

instance FromNamedRecord CsvItem where
    parseNamedRecord r = do
        csvPn    <- r .: "pn"
        csvUoM   <- r .: "uom"
        csvDesc  <- r .: "desc"
        return CsvItem{..}

instance FromField UnitOfMeasure where
    parseField "Each" = pure Each
    parseField "Pair" = pure Pair
    parseField _      = mzero
