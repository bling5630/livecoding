module Main where

import Text.PrettyPrint

class Pretty a where
    pretty :: a -> Doc


data Point = Point { _x :: Double, _y :: Double } deriving (Show)

instance Pretty Point where
    --pretty point = text (show point)
    pretty (Point{_x=x,_y=y})
        =   text "Point"
        <+> vcat [ lbrace <+> text "_x" <+> equals <+> double x
                 , comma  <+> text "_y" <+> equals <+> double y
                 , rbrace
                 ]




point = Point { _x = 3, _y = 4 }

main :: IO ()
main = putStrLn . render
    $  vcat [ text "Hello 1"
            , nest 5 ( vcat [ text "Hello 2a"
                            , text "Hello 2b"
                            , text "Hello 3b"
                            , pretty point
                            ]
                     )
            , text "Hello 3"
            , text "Hello 4"
            , pretty point
            ]
