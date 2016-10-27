module BomGen.Csv.Part where

import BasicPrelude hiding          ((<>), readFile)
import Data.Csv                     (FromNamedRecord, parseNamedRecord, decodeByName, (.:), FromField, parseField)
import Data.ByteString.Lazy         (readFile)
import qualified Data.Map.Lazy as Map
import Data.Vector                  (Vector, toList)

import BomGen.Data.Bom
import BomGen.Data.Part

data CsvPart = CsvPart
    { csvPn    :: PartNumber
    , csvUoM   :: UnitOfMeasure
    , csvDesc  :: Description
    } deriving (Show)

instance FromNamedRecord CsvPart where
    parseNamedRecord r = do
        csvPn    <- r .: "pn"
        csvUoM   <- r .: "uom"
        csvDesc  <- r .: "desc"
        return CsvPart{..}

instance FromField UnitOfMeasure where
    parseField "Each" = pure Each
    parseField "Pair" = pure Pair
    parseField _      = mzero
