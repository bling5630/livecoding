module BomGen.Data.Part where

import BasicPrelude

type PartNumber = Text

data PartFields = PartFields
    { pfUoM   :: UnitOfMeasure
    , pfDesc  :: Description
    } deriving (Show)

type Description = Text

data UnitOfMeasure
    = Each
    | Pair
    deriving (Show)

