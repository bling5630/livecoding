module Main where

import Prelude

data Item
    = EmptyItem
    | Item
        { part :: Part
        , operations :: [Operation]
        } deriving (Show)

data Operation = Operation
    { operation :: Integer
    , items :: [Item]
    } deriving (Show)

data Part = Part
    { partPn     :: String
    , partFields :: PartFields
    } deriving (Show)

data PartFields = PartFields
    { pfldDesc :: String
    } deriving (Show)


type Bom = Item

itemList :: Item -> [Part]
itemList EmptyItem  = []
itemList Item{..} = [part] ++ (concat (fmap itemList (concat (fmap items operations))))


indexedItemList :: Item -> [(Int, Part)]
indexedItemList EmptyItem  = []
indexedItemList item = go 0 item
  where go n Item{..}  = [(n, part)] ++ (concat (fmap (go (n + 1)) (concat (fmap items operations))))
        go n EmptyItem = []


mapItem :: (Part -> Part) -> Bom -> Bom
mapItem _f EmptyItem = EmptyItem
mapItem f Item{..}  = Item (f part) (fmap (\o -> Operation{operation=(operation o),items=(fmap (mapItem f) (items o))}) operations)


filterItem :: (Part -> Bool) -> Bom -> Bom
filterItem _p EmptyItem = EmptyItem
filterItem p Item{..} =
    if p part then Item part (fmap (\o -> Operation{operation=(operation o),items=(fmap (filterItem p) (items o))}) operations)
              else EmptyItem


main = do
    mapM_ print $ itemList item3
    let item4 = mapItem (\p -> p{partPn=(partPn p) ++ "!"}) item3

    putStrLn "--"
    mapM_ print $ itemList item4

    putStrLn "--"
    mapM_ print $ indexedItemList item3

    putStrLn "--"
    let item5 = filterItem (\p -> (partPn p) /= "200") item3
    mapM_ print $ indexedItemList item5
  where
    item3 = Item{part=Part "300" (PartFields "FIZ"), operations= [op1, op2]}

    op1  = Operation 10 [item0]
    item0 = Item{part=Part "000" (PartFields "BAZ"), operations= []}
    op2  = Operation 20 [item1, item2]
    item1 = Item{part=Part "100" (PartFields "FOO"), operations= []}
    item2 = Item{part=Part "200" (PartFields "BAR"), operations= [op3]}
    op3 = Operation 30 [item4]
    item4 = Item{part=Part "400" (PartFields "BUZ"), operations= []}
