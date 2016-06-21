module Main where

--
-- generate a bill of material for a radio flayer wagon that can
-- be red or blue.  Also allow the secondary color to be selected
-- from white or black.
--
-- parts and info derived from here
--    http://www.radioflyer.com/shop/wagons.html?pid=4&cid=12
--    http://www.instructables.com/id/Refinish-your-old-Radio-Flyer-wagon/
--
--
-- example parts lists:
--
--    pn-1001 wagon bed         - 50.00 x 1   Red   / Blue
--    pn-1002 front bolster kit - 16.77 x 1   Black / White
--    pn-1003 decal             - 12.89 x 1   Black / White
--    pn-1004 rear bolster kit  -  8.22 x 1   Black / White
--    pn-1005 handle            - 13.99 x 1   Black / White
--    pn-1006 WheelKit          - 13.24 x 4   NONE
--    pn-1007 Steering Limiter  -  3.24 x 1   NONE
--    pn-1008 Steering Column   -  6.68 x 1   Black / White
--    pn-1009 Handle ball       -  1.42 x 1   Black / White
--    pn-1010 Hardware Bag      -  9.79 x 1   NONE

import Data.Tree
import Data.Map (Map(..),fromList, (!))


data BomItem = BomItem
    { pn :: PartNumber
    , uOfM :: UofM
    , qty :: Quantity
    , cost :: Amount
    , desc :: String
    } deriving (Show)

type Quantity = Integer

type Amount = Integer

type PartNumber = String

class (Show a) => Bom a where
    bom :: Integer -> a -> Tree BomItem


data Item = Item
    { _uOfM :: UofM
    , _cost :: Amount
    , _desc :: String
    }

item qty' pn' =
    Node BomItem{uOfM=(_uOfM item'), qty=qty', pn=pn', cost=((_cost item') * qty'), desc=(_desc item')} []
  where item' = items ! pn'

data UofM
    = Each
    | Sqft
    | Ft
    deriving (Show)

--
-- The stuff below this point defines the product and it's bom.
--

data PrimaryColor
    = Red
    | Blue
    deriving (Show)

data SecondaryColor
    = Black
    | White
    deriving (Show)

data Wagon = Wagon PrimaryColor SecondaryColor deriving (Show)

--
-- This is an example of a configured BOM.  To create a Wagon you need to
-- know botht he primary and secondary color.  Then the child items may
-- depend on both, one or none of those parameters
--
instance Bom Wagon where
    bom qty' wagon@(Wagon prmColor sndColor) = Node (BomItem{uOfM=Each, qty=qty', pn="configured-wagon", cost=0, desc=(show wagon) })
        [ bom qty' (WagonBed prmColor)
        , bom qty' (FrontBolsterKit sndColor)
        , bom qty' (Decal sndColor)
        , bom qty' (RearBolsterKit sndColor)
        , bom qty' (Handle sndColor)
        , item (qty' * 4) "1006"
        , item (qty' * 1) "1007"
        , bom qty' (HandleBall sndColor)
        , bom qty' (SteeringColumn sndColor)
        , item (qty' * 1) "1010"
        ]

--
-- examples of selecting a standard part based on a parameter
--
data WagonBed = WagonBed PrimaryColor deriving (Show)
instance Bom WagonBed where
    bom qty' (WagonBed Red) = item 1 "1001R"
    bom qty' (WagonBed Blue) = item 1 "1001B"

data FrontBolsterKit = FrontBolsterKit SecondaryColor deriving (Show)
instance Bom FrontBolsterKit where
    bom qty' (FrontBolsterKit Black) = item 1 "1002B"
    bom qty' (FrontBolsterKit White) = item 1 "1002W"


data Decal = Decal SecondaryColor deriving (Show)
instance Bom Decal where
    bom qty' (Decal Black) = item 1 "1003B"
    bom qty' (Decal White) = item 1 "1003W"


data RearBolsterKit = RearBolsterKit SecondaryColor deriving (Show)
instance Bom RearBolsterKit where
    bom qty' (RearBolsterKit Black) = item 1 "1004B"
    bom qty' (RearBolsterKit White) = item 1 "1004W"


data Handle = Handle SecondaryColor deriving (Show)
instance Bom Handle where
    bom qty' (Handle Black) = item 1 "1005B"
    bom qty' (Handle White) = item 1 "1005W"


data HandleBall = HandleBall SecondaryColor deriving (Show)
instance Bom HandleBall where
    bom qty' (HandleBall Black) = item 1 "1009B"
    bom qty' (HandleBall White) = item 1 "1009W"


data SteeringColumn = SteeringColumn SecondaryColor deriving (Show)
instance Bom SteeringColumn where
    bom qty' (SteeringColumn Black) = item 1 "1008B"
    bom qty' (SteeringColumn White) = item 1 "1008W"

--
-- A map of unconfigured items allows you to define them all in the same place
--
items :: Map String Item
items = fromList
    [ ("1001R", Item Each 2500 "wagon bed - red")
    , ("1001B", Item Each 2500 "wagon bed - blue")
    , ("1002B", Item Each 1677 "front bolster kit - black")
    , ("1002W", Item Each 1677 "front bolster kit - white")
    , ("1003B", Item Each 1289 "decal - black")
    , ("1003W", Item Each 1289 "decal- white")
    , ("1004B", Item Each  822 "rear bolster kit - black")
    , ("1004W", Item Each  822 "rear bolster kit - white")
    , ("1005W", Item Each 1289 "handle - white")
    , ("1005B", Item Each 1289 "handle - black")
    , ("1006",  Item Each 1324 "wheel kit")
    , ("1007",  Item Each  324 "steering limiter")
    , ("1008W", Item Each  668 "steering column - white")
    , ("1008B", Item Each  668 "steering column - black")
    , ("1009B", Item Each  142 "handle ball - black")
    , ("1009W", Item Each  142 "handle ball - white")
    , ("1010",  Item Each  979 "hardware bag")
    ]

renderBom qty x = putStrLn $ drawTree $ fmap show (bom qty x)

main :: IO ()
main = do
    renderBom 1 (Wagon Blue White)
    putStrLn "--------------------"
    renderBom 1 (Wagon Red Black)

--
-- Example output:
--
--   BomItem {pn = "configured-wagon", uOfM = Each, qty = 1, cost = 0, desc = "Wagon Blue White"}
--   |
--   +- BomItem {pn = "1001B", uOfM = Each, qty = 1, cost = 1677, desc = "wagon bed - blue"}
--   |
--   +- BomItem {pn = "1002W", uOfM = Each, qty = 1, cost = 1677, desc = "front bolster kit - white"}
--   |
--   +- BomItem {pn = "1003W", uOfM = Each, qty = 1, cost = 1289, desc = "decal - white"}
--   |
--   +- BomItem {pn = "1004W", uOfM = Each, qty = 1, cost = 822, desc = "rear bolster kit - white"}
--   |
--   +- BomItem {pn = "1005W", uOfM = Each, qty = 1, cost = 1289, desc = "handle - white"}
--   |
--   +- BomItem {pn = "1006", uOfM = Each, qty = 4, cost = 1324, desc = "wheel kit"}
--   |
--   +- BomItem {pn = "1007", uOfM = Each, qty = 1, cost = 324, desc = "steering limiter"}
--   |
--   +- BomItem {pn = "1009W", uOfM = Each, qty = 1, cost = 142, desc = "handle ball - white"}
--   |
--   +- BomItem {pn = "1009W", uOfM = Each, qty = 1, cost = 668, desc = "steerign column - white"}
--   |
--   `- BomItem {pn = "1010", uOfM = Each, qty = 1, cost = 979, desc = "hardware bag"}
--
--   --------------------
--   BomItem {pn = "configured-wagon", uOfM = Each, qty = 1, cost = 0, desc = "Wagon Red Black"}
--   |
--   +- BomItem {pn = "1001R", uOfM = Each, qty = 1, cost = 1677, desc = "wagon bed - red"}
--   |
--   +- BomItem {pn = "1002B", uOfM = Each, qty = 1, cost = 1677, desc = "front bolster kit - black"}
--   |
--   +- BomItem {pn = "1003B", uOfM = Each, qty = 1, cost = 1289, desc = "decal - black"}
--   |
--   +- BomItem {pn = "1004B", uOfM = Each, qty = 1, cost = 822, desc = "rear bolster kit - black"}
--   |
--   +- BomItem {pn = "1005B", uOfM = Each, qty = 1, cost = 1289, desc = "handle - black"}
--   |
--   +- BomItem {pn = "1006", uOfM = Each, qty = 4, cost = 1324, desc = "wheel kit"}
--   |
--   +- BomItem {pn = "1007", uOfM = Each, qty = 1, cost = 324, desc = "steering limiter"}
--   |
--   +- BomItem {pn = "1009B", uOfM = Each, qty = 1, cost = 142, desc = "handle ball - black"}
--   |
--   +- BomItem {pn = "1008B", uOfM = Each, qty = 1, cost = 668, desc = "steering column - black"}
--   |
--   `- BomItem {pn = "1010", uOfM = Each, qty = 1, cost = 979, desc = "hardware bag"}



