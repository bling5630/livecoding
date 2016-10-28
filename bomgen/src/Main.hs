
module Main where

import BasicPrelude          hiding (lookup)
import System.Exit                  (exitFailure, exitSuccess)
import Text.PrettyPrint.Leijen.Text (pretty)

import Control.Monad.Reader         (ask)
import Control.Monad.Except         (throwError)

import Data.Map                     (lookup)

import BomGen.Config
import BomGen.Data.Bom
import BomGen.Data.Part
import BomGen.Data.ProductDescription
import BomGen.Pretty.Bom ()
import BomGen.Csv.Part
import BomGen.Map.PartMap

import BomGen.Loader


app :: Config -> AppData -> ProductDescription -> IO ()
app config appData prodDesc = do
    let bom = mkFoo (partMap appData) prodDesc
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

data AppData = AppData
    { partMap :: PartMap
    , operationMap :: PartMap
    , materialMap :: PartMap
    }


loadMaps :: Loader AppData
loadMaps = do
    config <- ask
    p <- liftIO $ runLoader loadPartMap config
    o <- liftIO $ runLoader loadPartMap config
    m <- liftIO $ runLoader loadPartMap config
    case (partitionEithers [p,o,m]) of
        ([], (p:o:m:[])) -> return $ AppData {partMap=p, operationMap=o, materialMap=m}
        _                -> throwError "BANG!"


main :: IO ()
main = do
    config <- loadConfig
    result <- runLoader loadMaps config
    case result of
        Left  err -> do
            putStrLn $ "failure: " ++ err
            exitFailure
        Right appData -> do
            app config appData fooDesc
            exitSuccess
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
