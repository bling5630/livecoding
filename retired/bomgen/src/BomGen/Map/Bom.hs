module BomGen.Map.Bom where

import BasicPrelude hiding            ((<>), readFile)
import Data.Vector                    (Vector, toList)
import qualified Data.Map.Lazy as Map

import BomGen.Data.Bom
import BomGen.Csv.Bom

mkPartMapRow :: CsvItem -> (ItemNumber, ItemFields)
mkPartMapRow r =
    (csvPn r, ItemFields{..})
  where ifUoM  = csvUoM  r
        ifDesc = csvDesc r

mkPartMap :: Vector CsvItem -> Map ItemNumber ItemFields
mkPartMap rows = Map.fromList $ toList (fmap mkPartMapRow rows)

type PartMap = Map ItemNumber ItemFields
