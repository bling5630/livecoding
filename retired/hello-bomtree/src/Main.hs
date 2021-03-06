--
-- This program generates a bill of material for a configurable
-- radio flyer wagon.  The wagon can have a primary color of
-- red or blue and a secondary color of white or black.  The items
-- in the bill of material are defined with a unit of measure that
-- can differ (as long as they're convertable) from the parts list
--
-- The parts lists was inspired by this info
--
-- parts and info derived from here
--    http://www.radioflyer.com/shop/wagons.html?pid=4&cid=12
--    http://www.instructables.com/id/Refinish-your-old-Radio-Flyer-wagon/
--

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
-- know both the primary and secondary color.  Then the child items may
-- depend on one or both of those values
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

