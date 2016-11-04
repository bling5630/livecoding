module BomGen.Data.Item where

import BasicPrelude

import BomGen.Data.ItemHeader

type Bom = Item

data Item
    = SkippedItem Description
    | EmptyItem
    | Item
        { itemHeader :: ItemHeader
        , operations :: [Operation]
        } deriving (Show)

data OperationHeader = OperationHeader { opNum :: Integer } deriving (Show)

data Operation = Operation
    { operationHeader :: OperationHeader
    , items :: [Item]
    } deriving (Show)

