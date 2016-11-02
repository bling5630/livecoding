module BomGen.Render.Export where

import BasicPrelude
import Data.Csv          (toNamedRecord)
--import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Data.Bom
import BomGen.Pretty.Bom ()

import BomGen.Csv.SytelineItem

renderExport :: Bom -> IO ()
renderExport bom = do
    renderItems bom
    putStrLn ""


renderItems :: Item -> IO ()
renderItems (SkippedItem desc) = putStrLn $ "skipped: " ++ desc
renderItems NullItem           = putStrLn "null"
renderItems item               = do
    print $ toNamedRecord $ defSytelineItem { sliCol000 = (itemPn item) }
    mapM_ go (itemOperations item)
 where go op = mapM_ renderItems (materials op)
