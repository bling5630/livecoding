module BomGen.Render.Export where

import BasicPrelude
import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Data.Bom
import BomGen.Pretty.Bom ()

renderExport :: Bom -> IO ()
renderExport bom = do
    putStrLn "EXPORT:"
    putStrLn $ tshow (pretty bom)
