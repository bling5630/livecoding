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


arrayFst a = a ! (fst(bounds a))
arrayLst a = a ! (snd(bounds a))

subArray bounds = ixmap (bounds) id

main = do
    print $ myArray ! 1
    print $ myArray ! (snd(bounds myArray))
    print $ arrayFst myArray
    print $ arrayLst myArray
    print $ fmap (const 999) myArray
    print $ mySubArray
    print $ fmap (const 42) $ subArray (5,15) myArray
    print $ myArray // [(1, 999)]
    putStrLn "--------------"
    mapM_ print foo
 where myArray = listArray (1,20) [x | x <- [1..20]]
       mySubArray = ixmap (5,15) id myArray
       subMap = ixmap ((2,2),(5,5)) id defaultGameMap
       foo = chunksOf 4 $ concat $ elems subMap

