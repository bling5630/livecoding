module BomGen.Data.Bom where

import BasicPrelude

import BomGen.Data.Part

type Bom = Item

data Item
    = SkippedItem Description
    | NullItem
    | Item
        { itemPn         :: PartNumber
        , itemUoM        :: UnitOfMeasure
        , itemDesc       :: Description
        , itemOperations :: [Operation]
        } deriving (Show)

data Operation = Operation
      { opNum         :: Integer
      , materials     :: [Item]
      } deriving (Show)


type Hours = Double

