module BomGen.Data.ItemHeader where

import BasicPrelude

data ItemHeader = ItemHeader
    { itemPn     :: ItemNumber
    , itemFields :: ItemFields
    } deriving (Show)

type ItemNumber = Text

data ItemFields = ItemFields
    { ifUoM   :: UnitOfMeasure
    , ifDesc  :: Description
    } deriving (Show)

data UnitOfMeasure
    = Each
    | Pair
    deriving (Show)

type Description = Text
