module BomGen.Csv.SytelineMaterial where

import BasicPrelude

import Data.Csv (ToNamedRecord(..), (.=), namedRecord)

data SytelineMaterial = SytelineMaterial
    { slmCol000 :: !Text -- Item
    , slmCol001 :: !Text -- Item Description
    , slmCol002 :: !Text -- Operation
    , slmCol003 :: !Text -- WC
    , slmCol004 :: !Text -- Material
    , slmCol005 :: !Text -- Material Description
    , slmCol006 :: !Text -- Quantity
    , slmCol007 :: !Text -- U/M
    , slmCol008 :: !Text -- Scrap Factor
    , slmCol009 :: !Text -- Backflush
    , slmCol010 :: !Text -- Backflush Location
    , slmCol011 :: !Text -- Per
    , slmCol012 :: !Text -- Alt Group
    , slmCol013 :: !Text -- Alt Group Rank
    , slmCol014 :: !Text -- Cost
    , slmCol015 :: !Text -- Ref
    , slmCol016 :: !Text -- Material Cost
    , slmCol017 :: !Text -- Labor Cost
    , slmCol018 :: !Text -- Outside Cost
    , slmCol019 :: !Text -- Fixed Overhead Cost
    , slmCol020 :: !Text -- Variable Overhead Cost
    , slmCol021 :: !Text -- Effect Date
    , slmCol022 :: !Text -- Obsolete Date
    , slmCol023 :: !Text -- Type
    , slmCol024 :: !Text -- Seq
    , slmCol025 :: !Text -- Manufacturer
    , slmCol026 :: !Text -- Manufacturer Name
    , slmCol027 :: !Text -- Manufacturer Item
    , slmCol028 :: !Text -- Manufacturer Item Description
    , slmCol029 :: !Text -- BOM Seq
    , slmCol030 :: !Text -- Feature
    , slmCol031 :: !Text -- Option Code
    , slmCol032 :: !Text -- Probable
    , slmCol033 :: !Text -- Incremental Price
    , slmCol034 :: !Text -- Estimated Break Date
    , slmCol035 :: !Text -- Date of Last Report
    , slmCol036 :: !Text -- Fixed Material
    , slmCol037 :: !Text -- Variable Material
    , slmCol038 :: !Text -- WC Description
    } deriving (Eq, Show)

defSytelineMaterial :: SytelineMaterial
defSytelineMaterial = SytelineMaterial
    { slmCol000 = ""
    , slmCol001 = ""
    , slmCol002 = ""
    , slmCol003 = ""
    , slmCol004 = ""
    , slmCol005 = ""
    , slmCol006 = ""
    , slmCol007 = ""
    , slmCol008 = ""
    , slmCol009 = ""
    , slmCol010 = ""
    , slmCol011 = ""
    , slmCol012 = ""
    , slmCol013 = ""
    , slmCol014 = ""
    , slmCol015 = ""
    , slmCol016 = ""
    , slmCol017 = ""
    , slmCol018 = ""
    , slmCol019 = ""
    , slmCol020 = ""
    , slmCol021 = ""
    , slmCol022 = ""
    , slmCol023 = ""
    , slmCol024 = ""
    , slmCol025 = ""
    , slmCol026 = ""
    , slmCol027 = ""
    , slmCol028 = ""
    , slmCol029 = ""
    , slmCol030 = ""
    , slmCol031 = ""
    , slmCol032 = ""
    , slmCol033 = ""
    , slmCol034 = ""
    , slmCol035 = ""
    , slmCol036 = ""
    , slmCol037 = ""
    , slmCol038 = ""
    }

instance ToNamedRecord SytelineMaterial where
    toNamedRecord SytelineMaterial {..} = namedRecord
        [ "Item"                          .= slmCol000
        , "Item Description"              .= slmCol001
        , "Operation"                     .= slmCol002
        , "WC"                            .= slmCol003
        , "Material"                      .= slmCol004
        , "Material Description"          .= slmCol005
        , "Quantity"                      .= slmCol006
        , "U/M"                           .= slmCol007
        , "Scrap Factor"                  .= slmCol008
        , "Backflush"                     .= slmCol009
        , "Backflush Location"            .= slmCol010
        , "Per"                           .= slmCol011
        , "Alt Group"                     .= slmCol012
        , "Alt Group Rank"                .= slmCol013
        , "Cost"                          .= slmCol014
        , "Ref"                           .= slmCol015
        , "Material Cost"                 .= slmCol016
        , "Labor Cost"                    .= slmCol017
        , "Outside Cost"                  .= slmCol018
        , "Fixed Overhead Cost"           .= slmCol019
        , "Variable Overhead Cost"        .= slmCol020
        , "Effect Date"                   .= slmCol021
        , "Obsolete Date"                 .= slmCol022
        , "Type"                          .= slmCol023
        , "Seq"                           .= slmCol024
        , "Manufacturer"                  .= slmCol025
        , "Manufacturer Name"             .= slmCol026
        , "Manufacturer Item"             .= slmCol027
        , "Manufacturer Item Description" .= slmCol028
        , "BOM Seq"                       .= slmCol029
        , "Feature"                       .= slmCol030
        , "Option Code"                   .= slmCol031
        , "Probable"                      .= slmCol032
        , "Incremental Price"             .= slmCol033
        , "Estimated Break Date"          .= slmCol034
        , "Date of Last Report"           .= slmCol035
        , "Fixed Material"                .= slmCol036
        , "Variable Material"             .= slmCol037
        , "WC Description"                .= slmCol038
        ]
