module BomGen.Render.Tree where

import BasicPrelude
import Text.PrettyPrint.Leijen.Text (pretty)

import BomGen.Data.Bom
import BomGen.Pretty.Bom ()

renderTree :: Bom -> IO ()
renderTree bom = do
    putStrLn "Tree:"
    putStrLn $ tshow (pretty bom)
