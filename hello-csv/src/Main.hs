module Main where

import Prelude hiding (getContents)
import Data.ByteString.Lazy (getContents, pack)
import Data.Csv hiding (Parser)
import Data.Vector (Vector, toList)
import Control.Monad
import Data.Maybe

import Text.Megaparsec
import Text.Megaparsec.ByteString

data Construction
    = Masonry
    | Wood
    | ReinforcedConcrete
    | ReinforcedMasonry
    | SteelFrame
    deriving (Show)

instance FromField Construction where
    parseField s = case parseMaybe pConstruction s of
        Nothing -> mzero
        Just c  -> pure c


pConstruction :: Parser Construction
pConstruction =
    try pMasonry             <|>
    try pWood                <|>
    try pReinforcedConcrete  <|>
    try pReinforcedMasonry   <|>
    try pSteelFrame          <?>
    "contstruction"

pMasonry = do
    _ <- string' "masonry"
    return Masonry

pWood = do
    _ <- string' "wood"
    return Wood

pReinforcedConcrete = do
    _ <- string' "reinforced concrete"
    return ReinforcedConcrete

pReinforcedMasonry = do
    _ <- string' "reinforced masonry"
    return ReinforcedMasonry

pSteelFrame = do
    _ <- string' "steel frame"
    return SteelFrame


data Portfolio = Portfolio
    { policyID         :: Integer
    , statecode        :: String
    , county           :: String
    , eqSiteLimit      :: Double
    , huSiteLimit      :: Double
    , flSiteLimit      :: Double
    , frSiteLimit      :: Double
    , tiv2011          :: Double
    , tiv2012          :: Double
    , eqSiteDeductible :: Double
    , huSiteDeductible :: Double
    , flSiteDeductible :: Double
    , frSiteDeductible :: Double
    , pointLatitude    :: Double
    , pointLongitude   :: Double
    , line             :: String
    , construction     :: Construction
    , pointGranularity :: Integer
    } deriving (Show)

instance FromNamedRecord Portfolio where
    parseNamedRecord r = do
        policyID         <- r .: "policyID"
        statecode        <- r .: "statecode"
        county           <- r .: "county"
        eqSiteLimit      <- r .: "eq_site_limit"
        huSiteLimit      <- r .: "hu_site_limit"
        flSiteLimit      <- r .: "fl_site_limit"
        frSiteLimit      <- r .: "fr_site_limit"
        tiv2011          <- r .: "tiv_2011"
        tiv2012          <- r .: "tiv_2012"
        eqSiteDeductible <- r .: "eq_site_deductible"
        huSiteDeductible <- r .: "hu_site_deductible"
        flSiteDeductible <- r .: "fl_site_deductible"
        frSiteDeductible <- r .: "fr_site_deductible"
        pointLatitude    <- r .: "point_latitude"
        pointLongitude   <- r .: "point_longitude"
        line             <- r .: "line"
        construction     <- r .: "construction"
        pointGranularity <- r .: "point_granularity"
        return Portfolio{..}


main :: IO ()
main = do
    contents <- getContents
    case decodeByName contents of
        Left err           -> putStrLn err
        Right (_, csvRows) -> mapM_ print (toList (csvRows :: Vector Portfolio))
