module BomGen.Render.Tree where

import BasicPrelude
import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Data.Item
import BomGen.Pretty.Item ()

renderTree :: Bom -> IO ()
renderTree bom = do
    putStrLn "Tree:"
    putStrLn $ tshow (pretty bom)
