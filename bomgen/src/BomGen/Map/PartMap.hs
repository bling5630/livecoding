module BomGen.Map.PartMap where

import BasicPrelude hiding            ((<>), readFile)
import Data.Vector                    (Vector, toList)
import qualified Data.Map.Lazy as Map

import BomGen.Data.Part
import BomGen.Csv.Part

mkPartMapRow :: CsvPart -> (PartNumber, PartFields)
mkPartMapRow r =
    (csvPn r, PartFields{..})
  where pfUoM  = csvUoM  r
        pfDesc = csvDesc r

mkPartMap :: Vector CsvPart -> Map PartNumber PartFields
mkPartMap rows = Map.fromList $ toList (fmap mkPartMapRow rows)

type PartMap = Map PartNumber PartFields
