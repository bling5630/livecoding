module BomGen.Render.Export where

import BasicPrelude --hiding (decodeUtf8)
import Data.List (nub)

import BomGen.Data.Bom
import BomGen.Data.SyteLine
import BomGen.Pretty.Bom ()

import BomGen.Csv.SytelineItem

import Data.ByteString.Lazy (toStrict)

import Data.Csv          (encodeByName)
--import Text.PrettyPrint.Leijen.Text (pretty)


renderExport :: Bom -> IO ()
renderExport bom = do
    --mapM_ print $ nub $ toItemList bom
    putStrLn $ decodeUtf8.toStrict $ encodeByName sytelineItemHeader (fmap mkSytelineItem (nub (toItemList bom)))
  where


toItemList :: Item -> [ItemHeader]
toItemList (SkippedItem _d) = []
toItemList EmptyItem        = []
toItemList Item{..}         = itemHeader : concat (fmap toItemList (concat (fmap items operations)))


mkSytelineItem :: ItemHeader -> SytelineItem
mkSytelineItem ItemHeader{..} = defSytelineItem
    { sliItem = itemPn
    , sliUoM  = (ifUoM  itemFields)
    , sliDesc = (ifDesc itemFields)
    }

