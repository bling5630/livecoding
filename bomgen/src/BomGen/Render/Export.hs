module BomGen.Render.Export where

import BasicPrelude
import Data.List (nub)

import BomGen.Data.Item
import BomGen.Data.ItemHeader
import BomGen.Pretty.Item ()

import BomGen.Csv.SytelineItem

--import Data.Csv          (toNamedRecord, encodeByName)
--import Text.PrettyPrint.Leijen.Text (pretty)


renderExport :: Bom -> IO ()
renderExport bom = do
    --encodeByName sytelineItemHeader $ toItemList bom
    --mapM_ print $ fmap mkSytelineItem $ nub $ toItemList bom
    mapM_ print $ nub $ toItemList bom
    putStrLn ""
  where


toItemList :: Item -> [ItemHeader]
toItemList (SkippedItem _d) = []
toItemList EmptyItem        = []
toItemList Item{..}         = itemHeader : concat (fmap toItemList (concat (fmap items operations)))


mkSytelineItem :: ItemHeader -> SytelineItem
mkSytelineItem ItemHeader{..} = defSytelineItem {sliItem=itemPn}
