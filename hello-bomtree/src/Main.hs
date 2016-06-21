

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

type Quantity = Double

type Amount = Double

type PartNumber = String

data UofM
    = Each
    | Halfs
    | Sqft
    | Ft
    deriving (Show)

class (Show a) => Bom a where
    bom :: UofM -> Double -> a -> Tree BomItem


data Item = Item
    { _uOfM :: UofM
    , _cost :: Amount
    , _desc :: String
    }

item uOfM' qty' pn' =
    Node BomItem{uOfM=(_uOfM item'), qty=(uomMul uOfM' (_uOfM item') qty'), pn=pn', cost=((_cost item') * qty'), desc=(_desc item')} []
  where item' = items ! pn'


uomMul src dst qty = (uomRatio src dst) * qty


uomRatio Each  Each  = 1.0
uomRatio Each  Halfs = 2.0
uomRatio Halfs Each  = 0.5
uomRatio _ _ = error "undefined uom conversion ratio"

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
    bom Each qty' wagon@(Wagon prmColor sndColor) =
        Node (BomItem{uOfM=Each, qty=qty', pn="configured-wagon", cost=0, desc=(show wagon) })
            [ bom  Each  (qty' * 1) (WagonBed prmColor)
            , bom  Each  (qty' * 1) (FrontBolsterKit sndColor)
            , bom  Halfs (qty' * 1) (Decal sndColor)
            , bom  Each  (qty' * 1) (RearBolsterKit sndColor)
            , bom  Each  (qty' * 1) (Handle sndColor)
            , item Each  (qty' * 4) "1006"
            , item Each  (qty' * 1) "1007"
            , bom  Each  (qty' * 1) (HandleBall sndColor)
            , bom  Each  (qty' * 1) (SteeringColumn sndColor)
            , item Each  (qty' * 1) "1010"
            ]

--
-- examples of selecting a standard part based on a parameter
--
data WagonBed = WagonBed PrimaryColor deriving (Show)
instance Bom WagonBed where
    bom uom qty' (WagonBed Red)  = item Each qty' "1001R"
    bom uom qty' (WagonBed Blue) = item Each qty' "1001B"

data FrontBolsterKit = FrontBolsterKit SecondaryColor deriving (Show)
instance Bom FrontBolsterKit where
    bom uom qty' (FrontBolsterKit Black) = item Each qty' "1002B"
    bom uom qty' (FrontBolsterKit White) = item Each qty' "1002W"


data Decal = Decal SecondaryColor deriving (Show)
instance Bom Decal where
    bom uom qty' (Decal Black) = item uom qty' "1003B"
    bom uom qty' (Decal White) = item uom qty' "1003W"


data RearBolsterKit = RearBolsterKit SecondaryColor deriving (Show)
instance Bom RearBolsterKit where
    bom uom qty' (RearBolsterKit Black) = item Each qty' "1004B"
    bom uom qty' (RearBolsterKit White) = item Each qty' "1004W"


data Handle = Handle SecondaryColor deriving (Show)
instance Bom Handle where
    bom uom qty' (Handle Black) = item Each qty' "1005B"
    bom uom qty' (Handle White) = item Each qty' "1005W"


data HandleBall = HandleBall SecondaryColor deriving (Show)
instance Bom HandleBall where
    bom uom qty' (HandleBall Black) = item Each qty' "1009B"
    bom uom qty' (HandleBall White) = item Each qty' "1009W"


data SteeringColumn = SteeringColumn SecondaryColor deriving (Show)
instance Bom SteeringColumn where
    bom uom qty' (SteeringColumn Black) = item Each qty' "1008B"
    bom uom qty' (SteeringColumn White) = item Each qty' "1008W"

--
-- A map of unconfigured items allows you to define them all in the same place
--
items :: Map String Item
items = fromList
    [ ("1001R", Item Halfs 2500 "wagon bed - red")
    , ("1001B", Item Halfs 2500 "wagon bed - blue")
    , ("1002B", Item Each  1677 "front bolster kit - black")
    , ("1002W", Item Each  1677 "front bolster kit - white")
    , ("1003B", Item Each  1289 "decal - black")
    , ("1003W", Item Each  1289 "decal- white")
    , ("1004B", Item Each   822 "rear bolster kit - black")
    , ("1004W", Item Each   822 "rear bolster kit - white")
    , ("1005W", Item Each  1289 "handle - white")
    , ("1005B", Item Each  1289 "handle - black")
    , ("1006",  Item Halfs 1324 "wheel kit")
    , ("1007",  Item Each   324 "steering limiter")
    , ("1008W", Item Each   668 "steering column - white")
    , ("1008B", Item Each   668 "steering column - black")
    , ("1009B", Item Each   142 "handle ball - black")
    , ("1009W", Item Each   142 "handle ball - white")
    , ("1010",  Item Each   979 "hardware bag")
    ]

renderBom uom qty x = putStrLn $ drawTree $ fmap show (bom uom qty x)

main :: IO ()
main = do
    renderBom Each 1 (Wagon Blue White)
    putStrLn "--------------------"
    renderBom Each 2 (Wagon Red Black)

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


-- so I always want to express a quantity as a (uofm quantity)
