module BomGen.Render.Summary where

import BasicPrelude
import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Data.Item
import BomGen.Pretty.Item ()

renderSummary :: Bom -> IO ()
renderSummary bom = do
    putStrLn "Summary:"
    putStrLn $ tshow (pretty bom)
