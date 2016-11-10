module BomGen.Render.Export where

import BasicPrelude
import Data.ByteString.Lazy (toStrict)
import Data.Csv (encodeByName)
import Text.PrettyPrint.Leijen.Text (pretty, putDoc, line, Doc)

import BomGen.Data.Bom
import BomGen.Data.SyteLine
import BomGen.Csv.SytelineItem
import BomGen.Csv.SytelineMaterial
import BomGen.Csv.SytelineOperation
import BomGen.Pretty.Bom ()
import BomGen.Pretty.Syteline ()


putDocLn :: Doc -> IO ()
putDocLn doc = putDoc (doc <> line)


renderExport :: Bom -> IO ()
renderExport bom = do
    putStrLn "Items"
    putDocLn $ pretty (nub (sortItems (toSytelineItemList bom))) <> line
    putStrLn $ decodeUtf8.toStrict $ encodeByName sytelineItemHeader (nub (toSytelineItemList bom))
    putStrLn "Operations"
    putDocLn $ pretty (nub (sortOperations (toSytelineOperationList bom))) <> line
    putStrLn $ decodeUtf8.toStrict $ encodeByName sytelineOperationHeader (nub (sortOperations (toSytelineOperationList bom)))
    putStrLn "Materials"
    putDocLn $ pretty (nub (sortMaterials (toSytelineMaterialList bom))) <> line
    putStrLn $ decodeUtf8.toStrict $ encodeByName sytelineMaterialHeader (nub (toSytelineMaterialList bom))
  where
    sortItems = sortBy cmpItem
    cmpItem a b = compare (sliItem a) (sliItem b)
    sortOperations = sortBy cmpOperation
    cmpOperation a b = if sloItem a == sloItem b
        then compare (sloOpNum a) (sloOpNum b)
        else compare (sloItem a) (sloItem b)
    sortMaterials  = sortBy cmpMaterial
    cmpMaterial a b = if slmCol000 a == slmCol000 b
        then if slmCol002 a == slmCol002 b
            then compare (slmCol004 a) (slmCol004 b)
            else compare (slmCol002 a) (slmCol002 b)
        else compare (slmCol000 a) (slmCol000 b)


toSytelineItemList :: Item -> [SytelineItem]
toSytelineItemList (SkippedItem _d) = []
toSytelineItemList EmptyItem        = []
toSytelineItemList Item{..}         =
    mkSytelineItem itemHeader : concat (fmap toSytelineItemList (concat (fmap items operations)))

toSytelineOperationList :: Item -> [SytelineOperation]
toSytelineOperationList (SkippedItem _d) = []
toSytelineOperationList EmptyItem        = []
toSytelineOperationList Item{..}  = concat (fmap (go itemHeader) operations)
  where go ih Operation{..} = (mkSytelineOperation ih operationHeader) : concat (fmap toSytelineOperationList items)


toSytelineMaterialList :: Item -> [SytelineMaterial]
toSytelineMaterialList (SkippedItem _d) = []
toSytelineMaterialList EmptyItem        = []
toSytelineMaterialList item             = concat (fmap (go item) (operations item))
    where go pitem operation = (fmap (mkSytelineMaterial pitem operation) (items operation)) ++ concat (fmap toSytelineMaterialList (items operation))

  --where go item operation = [] --fmap (mkSytelineMaterial item operation) (items operations)


mkSytelineItem :: ItemHeader -> SytelineItem
mkSytelineItem ItemHeader{..} = defSytelineItem
    { sliItem = itemPn
    , sliUoM  = (ifUoM  itemFields)
    , sliDesc = (ifDesc itemFields)
    }

mkSytelineOperation :: ItemHeader -> OperationHeader -> SytelineOperation
mkSytelineOperation itemHeader OperationHeader{..} = defSytelineOperation
    { sloItem   = itemPn itemHeader
    , sloOpNum  = opNum
    }

mkSytelineMaterial :: Item -> Operation -> Item -> SytelineMaterial
mkSytelineMaterial parent operation item =
    defSytelineMaterial
    { slmCol000 = itemPn (itemHeader parent)
    , slmCol001 = ifDesc (itemFields (itemHeader parent))
    , slmCol002 = opNum (operationHeader operation)
    , slmCol004 = itemPn (itemHeader item)
    , slmCol005 = ifDesc (itemFields (itemHeader item))
    }


