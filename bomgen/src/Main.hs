module Main where

import BasicPrelude hiding (lookup)
import System.Exit (exitFailure, exitSuccess)

import BomGen.Config
import BomGen.Data.AppData
import BomGen.Data.Config
import BomGen.Data.ProductDescription
import BomGen.Foo
import BomGen.Map.PartMap
import BomGen.Pretty.Bom ()
import BomGen.Render.Export
import BomGen.Render.Summary
import BomGen.Render.Tree

import BomGen.Loader


app :: Config -> AppData -> ProductDescription -> IO ()
app config appData prodDesc = do
    case config of
        Config{renderFormat=RenderSummary} -> do
            renderSummary bom
            exitSuccess
        Config{renderFormat=RenderTree}    -> do
            renderTree bom
            exitSuccess
        Config{renderFormat=RenderExport}  -> do
            renderExport bom
            exitSuccess
  where
    bom = mkFoo config appData prodDesc


loadData :: Loader AppData
loadData = do
    partMap      <- loadPartMap
    operationMap <- loadPartMap
    materialMap  <- loadPartMap
    return AppData{..}


main :: IO ()
main = do
    config <- runConfigure configure
    case config of
        Left err -> do
            putStrLn $ "failure: " ++ err
            exitFailure
        Right cfg -> do
           appData <- runDataLoader loadData cfg
           case appData of
                Left err   -> do
                    putStrLn $ "failure: " ++ err
                    exitFailure
                Right dat -> app cfg dat fooDesc
  where
    fooDesc = ProductDescription
        { barOption = Green
        , bazOption = Just Red
        }
