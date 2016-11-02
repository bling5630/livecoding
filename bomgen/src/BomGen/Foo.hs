module BomGen.Foo where

import BasicPrelude hiding (lookup)
import Data.Map (lookup)

import BomGen.Data.Bom
import BomGen.Data.Part
import BomGen.Data.ProductDescription
import BomGen.Pretty.Bom ()
import BomGen.Map.PartMap


mkFoo :: PartMap -> ProductDescription -> Bom
mkFoo pm desc =
    case (lookup "1000" pm) of
        Nothing -> SkippedItem ""
        Just p  -> Item { itemPn="1000",itemUoM=Each, itemDesc=pfDesc p, itemOperations = fooOps}
  where
    barItem = mkBar (barOption desc)
    bazItem = mkBaz (bazOption desc)
    quxItem = Item { itemPn="4000",itemUoM=Each, itemDesc="qux item", itemOperations=[]}
    fooOps = [ Operation { opNum=10, materials = [barItem] }
             , Operation { opNum=20, materials = [barItem] ++ [bazItem] }
             , Operation { opNum=30, materials = [barItem, quxItem]}
             ]


mkBaz :: Maybe Color -> Bom
mkBaz color =
    case color of
        Just Red   -> Item { itemPn="3001",itemUoM=Each, itemDesc="red   baz", itemOperations=[]}
        Just Green -> Item { itemPn="3002",itemUoM=Each, itemDesc="green baz", itemOperations=[]}
        Just Blue  -> Item { itemPn="3003",itemUoM=Each, itemDesc="Blue  baz", itemOperations=[]}
        _          -> NullItem


mkBar :: Color -> Bom
mkBar color =
    case color of
        Red   -> Item { itemPn="2001", itemUoM=Each, itemDesc="red bar",   itemOperations=barOps}
        Green -> Item { itemPn="2002", itemUoM=Each, itemDesc="green bar", itemOperations=barOps}
        Blue  -> Item { itemPn="2002", itemUoM=Each, itemDesc="blue bar",  itemOperations=barOps}
  where
    quxItem = Item { itemPn="4000", itemUoM=Each, itemDesc= "qux item", itemOperations=[]}
    barOps  = [ Operation { opNum=10, materials = [ quxItem ] } ]
