module Main where

import BasicPrelude hiding          ((<>))
import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Data.Bom
import BomGen.Pretty.Bom ()

data Color = Red | Blue | Green

data ProductDescription = ProductDescription
    {  barOption :: Color
    ,  bazOption :: Maybe Color
    }


main :: IO ()
main = do
    let bom = mkFoo fooDesc
    putStrLn $ tshow (pretty bom)
  where
    fooDesc = ProductDescription
        { barOption = Red
        , bazOption = Just Blue
        }

mkFoo :: ProductDescription -> Bom
mkFoo desc =
    Item { pn="1000",uom=Each, desc="item foo", operations = fooOps}
  where
    barItem = mkBar (barOption desc)
    bazItem = mkBaz (bazOption desc)
    quxItem = Item { pn="4000",uom=Each, desc="qux item", operations=[]}
 item    fooOps = [ Operation { opNum=10, materials = [barItem] }
             , Operation { opNum=20, materials = [barItem] ++ [bazItem] }
             , Operation { opNum=30, materials = [barItem, quxItem]}
             ]

mkBaz :: Maybe Color -> Bom
mkBaz color =
    case color of
        Just Red   -> Item { pn="3001",uom=Each, desc="red   baz", operations=[]}
        Just Green -> Item { pn="3002",uom=Each, desc="green baz", operations=[]}
        Just Blue  -> Item { pn="3003",uom=Each, desc="Blue  baz", operations=[]}
        _          -> NullItem


mkBar :: Color -> Bom
mkBar color =
    case color of
        Red   -> Item { pn="2001",uom=Each, desc="red bar",   operations=barOps}
        Green -> Item { pn="2002",uom=Each, desc="green bar", operations=barOps}
        Blue  -> Item { pn="2002",uom=Each, desc="blue bar",  operations=barOps}
  where
    quxItem = Item { pn="4000",uom=Each, desc= "qux item", operations=[]}
    barOps  = [ Operation { opNum=10, materials = [ quxItem ] } ]
