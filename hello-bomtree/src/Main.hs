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


data PrimaryColor
    = Red
    | Blue
    deriving (Show)

data SecondaryColor
    = Black
    | White
    deriving (Show)


data Wagon = Wagon PrimaryColor SecondaryColor deriving (Show)

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

data WagonBed = WagonBed PrimaryColor deriving (Show)
instance Bom WagonBed where
    bom qty' thisItem@(WagonBed Red)  = Node (BomItem{uOfM=Each, qty=qty', pn="1001R",  cost=(qty' * 1677), desc="wagon bed - red" }) []
    bom qty' thisItem@(WagonBed Blue) = Node (BomItem{uOfM=Each, qty=qty', pn="1001B",  cost=(qty' * 1677), desc="wagon bed - blue" }) []



data FrontBolsterKit = FrontBolsterKit SecondaryColor deriving (Show)
instance Bom FrontBolsterKit where
    bom qty' thisItem@(FrontBolsterKit Black)  = Node (BomItem{uOfM=Each, qty=qty', pn="1002B",  cost=(qty' * 1677), desc="front bolster kit - black" }) []
    bom qty' thisItem@(FrontBolsterKit White)  = Node (BomItem{uOfM=Each, qty=qty', pn="1002W",  cost=(qty' * 1677), desc="front bolster kit - white" }) []

data Decal = Decal SecondaryColor deriving (Show)
instance Bom Decal where
    bom qty' (Decal Black)  = Node (BomItem{uOfM=Each, qty=qty', pn="1003B",  cost=(qty' * 1289), desc="decal - black" }) []
    bom qty' (Decal White)  = Node (BomItem{uOfM=Each, qty=qty', pn="1003W",  cost=(qty' * 1289), desc="decal - white" }) []


data RearBolsterKit = RearBolsterKit SecondaryColor deriving (Show)
instance Bom RearBolsterKit where
    bom qty' (RearBolsterKit Black)  = Node (BomItem{uOfM=Each, qty=qty', pn="1004B",  cost=(qty' * 822) , desc="rear bolster kit - black"}) []
    bom qty' (RearBolsterKit White)  = Node (BomItem{uOfM=Each, qty=qty', pn="1004W",  cost=(qty' * 822) , desc="rear bolster kit - white"}) []


data Handle = Handle SecondaryColor deriving (Show)
instance Bom Handle where
    bom qty' (Handle Black)  = Node (BomItem{uOfM=Each, qty=qty', pn="1005B",  cost=(qty' * 1289), desc="handle - black" }) []
    bom qty' (Handle White)  = Node (BomItem{uOfM=Each, qty=qty', pn="1005W",  cost=(qty' * 1289), desc="handle - white" }) []


data HandleBall = HandleBall SecondaryColor deriving (Show)
instance Bom HandleBall where
    bom qty' (HandleBall Black)  = Node (BomItem{uOfM=Each, qty=qty', pn="1009B",  cost=(qty' * 142), desc="handle ball - black" }) []
    bom qty' (HandleBall White)  = Node (BomItem{uOfM=Each, qty=qty', pn="1009W",  cost=(qty' * 142), desc="handle ball - white" }) []


data SteeringColumn = SteeringColumn SecondaryColor deriving (Show)
instance Bom SteeringColumn where
    bom qty' (SteeringColumn Black)  = Node (BomItem{uOfM=Each, qty=qty', pn="1008B",  cost=(qty' * 668), desc="steering column - black" }) []
    bom qty' (SteeringColumn White)  = Node (BomItem{uOfM=Each, qty=qty', pn="1009W",  cost=(qty' * 668), desc="steerign column - white" }) []


items :: Map String Item
items = fromList
    [ ("1006", Item Each 1324 "wheel kit")
    , ("1007", Item Each 324  "steering limiter")
    , ("1010", Item Each 979  "hardware bag")
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



