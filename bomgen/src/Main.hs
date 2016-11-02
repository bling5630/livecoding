module Main where

import BasicPrelude hiding (lookup)
import System.Exit (exitFailure, exitSuccess)
import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Config
import BomGen.Data.ProductDescription
import BomGen.Pretty.Bom ()
import BomGen.Map.PartMap
import BomGen.Foo

import BomGen.Loader

data AppData = AppData
    { partMap      :: PartMap
    , operationMap :: PartMap
    , materialMap  :: PartMap
    }

renderSummary :: Config -> AppData -> ProductDescription -> IO ()
renderSummary _ _ _ =
    putStrLn $ "rendering the summary"

renderTree :: Config -> AppData -> ProductDescription -> IO ()
renderTree _config appData prodDesc =
    putStrLn $ tshow (pretty bom)
  where
    bom = mkFoo (partMap appData) prodDesc


renderExport :: Config -> AppData -> ProductDescription -> IO ()
renderExport _ _ _ =
    putStrLn $ "rendering the export"


app :: Config -> AppData -> ProductDescription -> IO ()
app config appData prodDesc = do
    case config of
        Config{renderFormat=RenderSummary} -> do
            renderSummary config appData prodDesc
            exitSuccess
        Config{renderFormat=RenderTree}    -> do
            renderTree config appData prodDesc
            exitSuccess
        Config{renderFormat=RenderExport}  -> do
            renderExport config appData prodDesc
            exitSuccess


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
