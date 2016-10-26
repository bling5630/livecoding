module BomGen.Data.Bom where

import BasicPrelude


type Bom = Item

data Item
    = SkippedItem Description
    | NullItem
    | Item
        { pn         :: PartNumber
        , uom        :: UnitOfMeasure
        , desc       :: Description
        , operations :: [Operation]
        } deriving (Show)

data Operation = Operation
      { opNum         :: Integer
      , materials     :: [Item]
      } deriving (Show)

type PartNumber = Text

type Description = Text

data UnitOfMeasure
    = Each
    | Pairs
    deriving (Show)

type Hours = Double

