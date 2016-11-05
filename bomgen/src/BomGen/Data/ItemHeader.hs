module BomGen.Data.ItemHeader where

import BasicPrelude

data ItemHeader = ItemHeader
    { itemPn     :: ItemNumber
    , itemFields :: ItemFields
    } deriving (Show, Eq)

type ItemNumber = Text

data ItemFields = ItemFields
    { ifUoM   :: UnitOfMeasure
    , ifDesc  :: Description
    } deriving (Show, Eq)

data UnitOfMeasure
    = Each
    | Pair
    deriving (Show, Eq)

type Description = Text
