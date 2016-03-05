module Main where

--
-- constructor using tuple 
--
data Foo a b = Foo (a , b) deriving Show

--
-- create a function to extract the tuple from a Foo
--
runFoo :: Foo a b -> (a, b)
runFoo (Foo (a, b)) = (a, b)

--
-- use record syntax to do the same all in one shot 
--
data Bar a b = Bar { runBar :: (a, b) } deriving Show

--
--
--
data Point a b = Point { pointX :: a, pointY :: b } deriving Show

main = do
    print $ someFoo
    print $ runFoo someFoo
    print $ someBar1
    print $ runBar someBar1
    print $ someBar2 
    print $ runBar someBar2
    print $ somePoint1
    print $ somePoint2
    return ()
  where someFoo = Foo(1, "bingo")
        -- you can create a bar with record syntax
        -- or you can create it with tuple syntax
        someBar1 = Bar{runBar=(1,"bingo")} 
        someBar2 = Bar(1, "bingo")
        -- this is true of all records.  records
        -- just create accessor to functions but
        -- still define the datatype the same
        somePoint1 = Point{pointX=17, pointY=19} :: Point Int Int
        somePoint2 = Point 17 19 :: Point Int Int
