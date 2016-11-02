module BomGen.Render.Export where

import BasicPrelude
--import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Data.Bom
import BomGen.Pretty.Bom ()

import BomGen.Csv.SytelineItem
import BomGen.Csv.SytelineOperation
import BomGen.Csv.SytelineMaterial

renderExport :: Bom -> IO ()
renderExport _bom = do
    putStrLn "EXPORT:"
    print item
    putStrLn "--"
    print operation
    putStrLn "--"
    print material
  where
    item      = defSytelineItem { sliCol000 = "bingo" }
    operation = defSytelineOperation { sloCol000 = "bingo" }
    material  = defSytelineMaterial { slmCol000 = "bingo" }
