module Main where

import Data.List
import Data.List.Split
import Data.Array

-- 
-- 
--        . . . . . . . . .  
--        . . . . . . . . .
--        . . * * * * . . .
--        . . * * * * . . .
--        . . * * * * . . .
--        . . . . . . . . .
--        . . . . . . . . .
-- 
-- 

mapRows = 10
mapCols = 10
mapLowerBounds = (0, 0)
mapUpperBounds = (mapRows - 1, mapCols - 1)
mapBounds = (mapLowerBounds, mapUpperBounds)

defaultGameMap = listArray mapBounds 
    [ "#", "#", "#", "#", "#", "#", "#", "#", "#", "#"
    , "#", "1", ".", ".", ".", ".", ".", ".", ".", "# "
    , "#", ".", "2", ".", ".", ".", ".", ".", ".", "# "
    , "#", ".", ".", "3", ".", ".", ".", ".", ".", "# "
    , "#", ".", ".", ".", ".", ".", ".", ".", ".", "# "
    , "#", ".", ".", ".", ".", ".", ".", ".", ".", "# "
    , "#", ".", ".", ".", ".", ".", ".", ".", ".", "# "
    , "#", ".", ".", ".", ".", ".", ".", ".", ".", "# "
    , "#", ".", ".", ".", ".", ".", ".", ".", ".", "# "
    , "#", ".", ".", ".", ".", ".", ".", ".", ".", "# "
    , "#", "#", "#", "#", "#", "#", "#", "#", "#", "# " ]


main = do
    let subMap = ixmap ((2,2),(5,5)) id defaultGameMap 
    let foo = splitEvery 4 $ concat $ elems subMap 
    mapM_ print foo

