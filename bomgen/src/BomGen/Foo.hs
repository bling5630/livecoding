module BomGen.Foo where

import BasicPrelude hiding (lookup)
import Data.Map (lookup)

import BomGen.Data.Bom
import BomGen.Data.AppData
import BomGen.Data.Config
import BomGen.Data.ProductDescription
import BomGen.Pretty.Bom ()


mkFoo :: Config -> AppData -> ProductDescription -> Bom
mkFoo _config appData desc =
    case (lookup "1000" (partMap appData)) of
        Nothing -> SkippedItem ""
        Just p  -> Item { itemHeader=ItemHeader{itemPn="1000",itemFields=ItemFields{ifUoM=Each, ifDesc=ifDesc p}}, operations = fooOps }
  where
    barItem = mkBar (barOption desc)
    bazItem = mkBaz (bazOption desc)
    quxItem = Item { itemHeader=ItemHeader{itemPn="4000",itemFields=ItemFields{ifUoM=Each, ifDesc="qux item"}}, operations = []}
    fooOps = [ Operation { operationHeader=OperationHeader{opNum=10}, items = [barItem] }
             , Operation { operationHeader=OperationHeader{opNum=20}, items = [barItem] ++ [bazItem] }
             , Operation { operationHeader=OperationHeader{opNum=30}, items = [barItem, quxItem]}
             ]


mkBaz :: Maybe Color -> Bom
mkBaz color =
    case color of
        Just Red   -> Item { itemHeader=ItemHeader{itemPn="3001",itemFields=ItemFields{ifUoM=Each, ifDesc="red baz"  }}, operations = []}
        Just Green -> Item { itemHeader=ItemHeader{itemPn="3002",itemFields=ItemFields{ifUoM=Each, ifDesc="green baz"}}, operations = []}
        Just Blue  -> Item { itemHeader=ItemHeader{itemPn="3003",itemFields=ItemFields{ifUoM=Each, ifDesc="blue baz" }}, operations = []}
        _          -> SkippedItem "No color specified"


mkBar :: Color -> Bom
mkBar color =
    case color of
        Red   -> Item { itemHeader=ItemHeader{itemPn="2001",itemFields=ItemFields{ifUoM=Each, ifDesc="red bar"   }}, operations = barOps}
        Green -> Item { itemHeader=ItemHeader{itemPn="2002",itemFields=ItemFields{ifUoM=Each, ifDesc="green bar" }}, operations = barOps}
        Blue  -> Item { itemHeader=ItemHeader{itemPn="2003",itemFields=ItemFields{ifUoM=Each, ifDesc="blue bar"  }}, operations = barOps}
  where
    quxItem = Item { itemHeader=ItemHeader{itemPn="4000",itemFields=ItemFields{ifUoM=Each, ifDesc="qux item"  }}, operations = []}
    barOps  = [ Operation { operationHeader=OperationHeader{opNum=10}, items = [ quxItem ] } ]
