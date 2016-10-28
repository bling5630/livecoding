module BomGen.Map.PartMap where

import BasicPrelude hiding          ((<>), readFile)
import Data.Csv                     (FromNamedRecord, parseNamedRecord, decodeByName, (.:), FromField, parseField)
import Data.ByteString.Lazy         (readFile)
import qualified Data.Map.Lazy as Map
import Data.Vector                  (Vector, toList)
import Data.Maybe

import Control.Monad.Reader         (ask)
import Control.Monad.Except         (throwError)

import BomGen.Data.Bom
import BomGen.Data.Part
import BomGen.Csv.Part
import BomGen.Config
import BomGen.Loader


mkPartMapRow :: CsvPart -> (PartNumber, PartFields)
mkPartMapRow r =
    (csvPn r, PartFields{..})
  where pfUoM  = csvUoM  r
        pfDesc = csvDesc r

mkPartMap :: Vector CsvPart -> Map PartNumber PartFields
mkPartMap rows = Map.fromList $ toList (fmap mkPartMapRow rows)

type PartMap = Map PartNumber PartFields


loadPartMap :: Loader PartMap
loadPartMap = do
    config <- ask
    case (dataPath config) of
        Nothing -> throwError "missing data path"
        Just p  -> do
            contents <- liftIO $ readFile (p ++ "/parts.csv")
            case decodeByName contents of
                Left err           -> throwError (tshow err)
                Right (_, csvRows) -> return $ mkPartMap csvRows
