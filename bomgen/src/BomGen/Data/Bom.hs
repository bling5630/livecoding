module BomGen.Data.Bom where

import BasicPrelude

type Bom = Item

data Item
    = SkippedItem Description
    | EmptyItem
    | Item
        { itemHeader :: ItemHeader
        , operations :: [Operation]
        } deriving (Show)

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

data Operation = Operation
    { operationHeader :: OperationHeader
    , items :: [Item]
    } deriving (Show)

data OperationHeader = OperationHeader
    { opNum  :: Int
    } deriving (Show)


