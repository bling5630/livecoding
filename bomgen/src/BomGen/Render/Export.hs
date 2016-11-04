module BomGen.Render.Export where

import BasicPrelude
--import Data.Csv          (toNamedRecord)
--import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Data.Item
import BomGen.Pretty.Item ()

--import BomGen.Csv.SytelineItem

renderExport :: Bom -> IO ()
renderExport _bom = do
    --renderItems bom
    --encodeByName sytelineItemHeader $ toItemList bom
    putStrLn ""
  where


-- Bom -> [SytelineItems]


--renderItems :: Item -> IO ()
--renderItems (SkippedItem desc) = putStrLn $ "skipped: " ++ desc
--renderItems EmptyItem          = putStrLn "null"
--renderItems item               = do
--    print $ toNamedRecord $ defSytelineItem { sliCol000 = (itemPn item) }
--    mapM_ go (itemOperations item)
-- where go op = mapM_ renderItems (materials op)
