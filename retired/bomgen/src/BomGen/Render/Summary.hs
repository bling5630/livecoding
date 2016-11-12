module BomGen.Render.Summary where

import BasicPrelude
import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Data.Bom
import BomGen.Pretty.Bom ()

renderSummary :: Bom -> IO ()
renderSummary bom = do
    putStrLn "Summary:"
    putStrLn $ tshow (pretty bom)
