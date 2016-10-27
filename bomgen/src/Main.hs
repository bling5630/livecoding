module Main where

import BasicPrelude          hiding (lookup)
import System.Exit                  (exitFailure, exitSuccess)
import Text.PrettyPrint.Leijen.Text (pretty)

import Data.Map                     (lookup)

import BomGen.Config
import BomGen.Data.Bom
import BomGen.Data.Part
import BomGen.Data.ProductDescription
import BomGen.Pretty.Bom ()
import BomGen.Csv.Part
import BomGen.Map.PartMap


app :: Config -> PartMap -> ProductDescription -> IO ()
app config partMap prodDesc = do
    let bom = mkFoo partMap prodDesc
    case config of
        Config{forceErrors=Just _}  -> do
            -- if any errors exist in bom
            -- only print the errors and
            -- exit
            putStrLn "errors"
            exitFailure
        Config{forceErrors=Nothing} -> do
            putStrLn $ tshow (pretty bom)
            exitSuccess



main :: IO ()
main = do
    config <- loadConfig

    partMap1 <- loadPartMap "data/parts.csv"
    partMap2 <- loadPartMap "data/parts.csv"
    partMap3 <- loadPartMap "data/parts.csv"

    case partitionEithers [partMap1, partMap2, partMap3] of
        ([], (m1:_m2:_m3:_)) -> do
            app config m1 fooDesc
            exitSuccess
        (errors, _)    -> do
            putStrLn "BANG!"
            mapM_ print errors
            exitFailure
  where
    fooDesc = ProductDescription
        { barOption = Green
        , bazOption = Just Red
        }



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
