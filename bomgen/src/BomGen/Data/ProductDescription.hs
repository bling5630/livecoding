module BomGen.Data.ProductDescription where

import BasicPrelude

data Color = Red | Blue | Green

data ProductDescription = ProductDescription
    {  barOption :: Color
    ,  bazOption :: Maybe Color
    }
