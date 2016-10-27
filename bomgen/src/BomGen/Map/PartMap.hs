module BomGen.Map.PartMap where

import BasicPrelude hiding          ((<>), readFile)
import Data.Csv                     (FromNamedRecord, parseNamedRecord, decodeByName, (.:), FromField, parseField)
import Data.ByteString.Lazy         (readFile)
import qualified Data.Map.Lazy as Map
import Data.Vector                  (Vector, toList)

import BomGen.Data.Bom
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


loadPartMap :: FilePath -> IO (Either Text PartMap)
loadPartMap filePath =
    catch go (\e -> return (Left (tshow (e :: IOError))))
  where go = do
          contents <- readFile filePath
          case decodeByName contents of
              Left err           -> return $ Left (tshow err)
              Right (_, csvRows) -> return $ Right (mkPartMap csvRows)

