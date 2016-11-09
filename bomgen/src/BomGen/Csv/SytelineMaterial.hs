module BomGen.Csv.SytelineMaterial where

import BasicPrelude

import Data.Csv (ToNamedRecord(..), (.=), namedRecord, Header)
import Data.Vector (fromList)

import BomGen.Data.SyteLine
import BomGen.Csv.Bom


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


sytelineMaterialHeader :: Header
sytelineMaterialHeader = fromList
        [ "Item"
        , "Item Description"
        , "Operation"
        , "WC"
        , "Material"
        , "Material Description"
        , "Quantity"
        , "U/M"
        , "Scrap Factor"
        , "Backflush"
        , "Backflush Location"
        , "Per"
        , "Alt Group"
        , "Alt Group Rank"
        , "Cost"
        , "Ref"
        , "Material Cost"
        , "Labor Cost"
        , "Outside Cost"
        , "Fixed Overhead Cost"
        , "Variable Overhead Cost"
        , "Effect Date"
        , "Obsolete Date"
        , "Type"
        , "Seq"
        , "Manufacturer"
        , "Manufacturer Name"
        , "Manufacturer Item"
        , "Manufacturer Item Description"
        , "BOM Seq"
        , "Feature"
        , "Option Code"
        , "Probable"
        , "Incremental Price"
        , "Estimated Break Date"
        , "Date of Last Report"
        , "Fixed Material"
        , "Variable Material"
        , "WC Description"
        ]
