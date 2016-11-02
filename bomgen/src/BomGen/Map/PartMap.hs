module BomGen.Map.PartMap where

import BasicPrelude hiding            ((<>), readFile)
import Control.Monad.Except           (throwError)
import Control.Monad.Reader           (ask)
import Data.ByteString.Lazy           (readFile)
import Data.Csv                       (decodeByName )
import Data.Vector                    (Vector, toList)
import qualified Data.Map.Lazy as Map

import BomGen.Data.Part
import BomGen.Csv.Part
import BomGen.Data.Config
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
    contents <- liftIO $ readFile ((dataPath config) ++ "/parts.csv")
    case decodeByName contents of
        Left err           -> throwError (tshow err)
        Right (_, csvRows) -> return $ mkPartMap csvRows
