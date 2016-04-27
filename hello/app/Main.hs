--
-- How do I want to handle imports?
--
-- I could import everything explicitly even from prelude?  And
-- when there's a name collision import those symbols qualified.
--
-- This would mean you could read the imports and know where
-- everything comes from even if you're not familiar
--
-- In the example below `lookup` is explicitly imported twice
-- form different modules, so it's qualified where everything
-- else is only imported once so it's not qualified.
--
-- This seems the best comprimise.  Only things used more than
-- once end up using longer names
--
module Main where

-- import qualified Prelude
-- import           Prelude           (print, ($), putStrLn, (+),(*))
--
-- import qualified Data.List as List (lookup)
-- import qualified Data.Map  as Map  (lookup)
-- import           Data.Map          (fromList)

bar x = x + 33


foo x = if 1 < x && x > 99 then 1 else 0

main = print "hello"

-- map1 = [(1, 'a'), (2, 'b')]
-- map2 = fromList [(1, 'c'), (2, 'd')]
--
-- main = do
--     print $ map1
--     print $ List.lookup 1 map1
--     putStrLn "--------"
--     print $ map2
--     print $ Map.lookup 1 map2
--     print $ 1 + 1
