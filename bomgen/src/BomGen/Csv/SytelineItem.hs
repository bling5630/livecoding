module BomGen.Csv.SytelineItem where

import BasicPrelude ()

import Data.Csv (ToNamedRecord(..), (.=), namedRecord, Header)
import Data.Vector (fromList)

import BomGen.Data.Bom
import BomGen.Data.SyteLine

import BomGen.Csv.Bom ()


defSytelineItem :: SytelineItem
defSytelineItem = SytelineItem
    { sliItem   = "undefined"
    , sliUoM    = Each
    , sliDesc   = "undefined"
    , sliCol003 = "undefined"
    , sliCol004 = "undefined"
    , sliCol005 = "undefined"
    , sliCol006 = "undefined"
    , sliCol007 = "undefined"
    , sliCol008 = "undefined"
    , sliCol009 = "undefined"
    , sliCol010 = "undefined"
    , sliCol011 = "undefined"
    , sliCol012 = "undefined"
    , sliCol013 = "undefined"
    , sliCol014 = "undefined"
    , sliCol015 = "undefined"
    , sliCol016 = "undefined"
    , sliCol017 = "undefined"
    , sliCol018 = "undefined"
    , sliCol019 = "undefined"
    , sliCol020 = "undefined"
    , sliCol021 = "undefined"
    , sliCol022 = "undefined"
    , sliCol023 = "undefined"
    , sliCol024 = "undefined"
    , sliCol025 = "undefined"
    , sliCol026 = "undefined"
    , sliCol027 = "undefined"
    , sliCol028 = "undefined"
    , sliCol029 = "undefined"
    , sliCol030 = "undefined"
    , sliCol031 = "undefined"
    , sliCol032 = "undefined"
    , sliCol033 = "undefined"
    , sliCol034 = "undefined"
    , sliCol035 = "undefined"
    , sliCol036 = "undefined"
    , sliCol037 = "undefined"
    , sliCol038 = "undefined"
    , sliCol039 = "undefined"
    , sliCol040 = "undefined"
    , sliCol041 = "undefined"
    , sliCol042 = "undefined"
    , sliCol043 = "undefined"
    , sliCol044 = "undefined"
    , sliCol045 = "undefined"
    , sliCol046 = "undefined"
    , sliCol047 = "undefined"
    , sliCol048 = "undefined"
    , sliCol049 = "undefined"
    , sliCol050 = "undefined"
    , sliCol051 = "undefined"
    , sliCol052 = "undefined"
    , sliCol053 = "undefined"
    , sliCol054 = "undefined"
    , sliCol055 = "undefined"
    , sliCol056 = "undefined"
    , sliCol057 = "undefined"
    , sliCol058 = "undefined"
    , sliCol059 = "undefined"
    , sliCol060 = "undefined"
    , sliCol061 = "undefined"
    , sliCol062 = "undefined"
    , sliCol063 = "undefined"
    , sliCol064 = "undefined"
    , sliCol065 = "undefined"
    , sliCol066 = "undefined"
    , sliCol067 = "undefined"
    , sliCol068 = "undefined"
    , sliCol069 = "undefined"
    , sliCol070 = "undefined"
    , sliCol071 = "undefined"
    , sliCol072 = "undefined"
    , sliCol073 = "undefined"
    , sliCol074 = "undefined"
    , sliCol075 = "undefined"
    , sliCol076 = "undefined"
    , sliCol077 = "undefined"
    , sliCol078 = "undefined"
    , sliCol079 = "undefined"
    , sliCol080 = "undefined"
    , sliCol081 = "undefined"
    , sliCol082 = "undefined"
    , sliCol083 = "undefined"
    , sliCol084 = "undefined"
    , sliCol085 = "undefined"
    , sliCol086 = "undefined"
    , sliCol087 = "undefined"
    , sliCol088 = "undefined"
    , sliCol089 = "undefined"
    , sliCol090 = "undefined"
    , sliCol091 = "undefined"
    , sliCol092 = "undefined"
    , sliCol093 = "undefined"
    , sliCol094 = "undefined"
    , sliCol095 = "undefined"
    , sliCol096 = "undefined"
    , sliCol097 = "undefined"
    , sliCol098 = "undefined"
    , sliCol099 = "undefined"
    , sliCol100 = "undefined"
    , sliCol101 = "undefined"
    , sliCol102 = "undefined"
    , sliCol103 = "undefined"
    , sliCol104 = "undefined"
    , sliCol105 = "undefined"
    , sliCol106 = "undefined"
    , sliCol107 = "undefined"
    , sliCol108 = "undefined"
    , sliCol109 = "undefined"
    , sliCol110 = "undefined"
    , sliCol111 = "undefined"
    , sliCol112 = "undefined"
    , sliCol113 = "undefined"
    , sliCol114 = "undefined"
    , sliCol115 = "undefined"
    , sliCol116 = "undefined"
    , sliCol117 = "undefined"
    , sliCol118 = "undefined"
    , sliCol119 = "undefined"
    , sliCol120 = "undefined"
    , sliCol121 = "undefined"
    , sliCol122 = "undefined"
    , sliCol123 = "undefined"
    , sliCol124 = "undefined"
    , sliCol125 = "undefined"
    , sliCol126 = "undefined"
    , sliCol127 = "undefined"
    , sliCol128 = "undefined"
    , sliCol129 = "undefined"
    , sliCol130 = "undefined"
    , sliCol131 = "undefined"
    , sliCol132 = "undefined"
    , sliCol133 = "undefined"
    , sliCol134 = "undefined"
    , sliCol135 = "undefined"
    , sliCol136 = "undefined"
    , sliCol137 = "undefined"
    , sliCol138 = "undefined"
    , sliCol139 = "undefined"
    , sliCol140 = "undefined"
    , sliCol141 = "undefined"
    , sliCol142 = "undefined"
    }

instance ToNamedRecord SytelineItem where
    toNamedRecord SytelineItem {..} = namedRecord
        [ "Item"                                       .= sliItem
        , "U/M"                                        .= sliUoM
        , "Description"                                .= sliDesc
        , "Quantity On Hand"                           .= sliCol003
        , "Safety Stock"                               .= sliCol004
        , "Type,Standard Unit Cost"                    .= sliCol005
        , "Current Unit Cost"                          .= sliCol006
        , "Stocked"                                    .= sliCol007
        , "Source"                                     .= sliCol008
        , "Planner Code"                               .= sliCol009
        , "Buyer"                                      .= sliCol010
        , "Product Code"                               .= sliCol011
        , "ABC Code"                                   .= sliCol012
        , "Cost Type"                                  .= sliCol013
        , "Cost Method"                                .= sliCol014
        , "Revision"                                   .= sliCol015
        , "Revision Track"                             .= sliCol016
        , "ECN"                                        .= sliCol017
        , "Drawing Number"                             .= sliCol018
        , "Alternate Item"                             .= sliCol019
        , "Show In Drop-Down Lists"                    .= sliCol020
        , "Created By"                                 .= sliCol021
        , "Create Date"                                .= sliCol022
        , "Lot Size"                                   .= sliCol023
        , "Unit Weight"                                .= sliCol024
        , "Weight Units"                               .= sliCol025
        , "Non-Nettable Stock"                         .= sliCol026
        , "Quantity Ordered"                           .= sliCol027
        , "Quantity WIP"                               .= sliCol028
        , "Allocated To Prod"                          .= sliCol029
        , "Allocated To Customer Orders"               .= sliCol030
        , "Reserved For Customer Orders"               .= sliCol031
        , "Low Level"                                  .= sliCol032
        , "Active for Data Integration"                .= sliCol033
        , "Shrink Factor"                              .= sliCol034
        , "Phantom Flag"                               .= sliCol035
        , "MPS Flag"                                   .= sliCol036
        , "Net Change"                                 .= sliCol037
        , "MPS Plan Fence"                             .= sliCol038
        , "Family Code"                                .= sliCol039
        , "Production Type"                            .= sliCol040
        , "Rate/Day"                                   .= sliCol041
        , "Inventory LCL %"                            .= sliCol042
        , "Inventory UCL %"                            .= sliCol043
        , "Supply Site"                                .= sliCol044
        , "Supply Whse"                                .= sliCol045
        , "Paper Work"                                 .= sliCol046
        , "Fixed Lead Time"                            .= sliCol047
        , "Expedited Fixed"                            .= sliCol048
        , "Dock-to-Stock"                              .= sliCol049
        , "Variable"                                   .= sliCol050
        , "Expedited Variable"                         .= sliCol051
        , "Separation"                                 .= sliCol052
        , "Release 1"                                  .= sliCol053
        , "Release 2"                                  .= sliCol054
        , "Release 3"                                  .= sliCol055
        , "MRP Item"                                   .= sliCol056
        , "Infinite"                                   .= sliCol057
        , "Planned Mfg Supply Switching"               .= sliCol058
        , "Accept Requirements"                        .= sliCol059
        , "Pass Requirements"                          .= sliCol060
        , "Must use future POs before creating PLNs"   .= sliCol061
        , "Supply Usage Tolerance"                     .= sliCol062
        , "Time Fence Rule"                            .= sliCol063
        , "Time Fence Value"                           .= sliCol064
        , "Setup Group"                                .= sliCol065
        , "Order Minimum"                              .= sliCol066
        , "Order Multiple"                             .= sliCol067
        , "Order Maximum"                              .= sliCol068
        , "Days Supply"                                .= sliCol069
        , "Use Reorder Point"                          .= sliCol070
        , "Reorder Point"                              .= sliCol071
        , "Fixed Order Qty"                            .= sliCol072
        , "Earliest Planned Purchase Receipt"          .= sliCol073
        , "Targeted Safety Stock Replenishment"        .= sliCol074
        , "Lot Track"                                  .= sliCol075
        , "Preassign Lots"                             .= sliCol076
        , "Lot Prefix"                                 .= sliCol077
        , "S/N Track"                                  .= sliCol078
        , "Preassign Serials"                          .= sliCol079
        , "S/N Prefix"                                 .= sliCol080
        , "Shelf Life"                                 .= sliCol081
        , "Issue By"                                   .= sliCol082
        , "Material Status"                            .= sliCol083
        , "Reason"                                     .= sliCol084
        , "Last Change"                                .= sliCol085
        , "User"                                       .= sliCol086
        , "Backflush"                                  .= sliCol087
        , "Backflush Location"                         .= sliCol088
        , "Preferred Co-product Mix"                   .= sliCol089
        , "Reservable"                                 .= sliCol090
        , "Tax-Free Imported Material"                 .= sliCol091
        , "Tax Free Days"                              .= sliCol092
        , "Safety Stock Percent"                       .= sliCol093
        , "Tariff Classification"                      .= sliCol094
        , "PO Tolerance Over"                          .= sliCol095
        , "PO Tolerance Under"                         .= sliCol096
        , "Kit"                                        .= sliCol097
        , "Print Kit Components on Customer Paperwork" .= sliCol098
        , "Std Due Period"                             .= sliCol099
        , "Commodity"                                  .= sliCol100
        , "Commodity Description"                      .= sliCol101
        , "Taxable"                                    .= sliCol102
        , "Tax Code Description"                       .= sliCol103
        , "Origin"                                     .= sliCol104
        , "Country"                                    .= sliCol105
        , "Preference Criterion"                       .= sliCol106
        , "Country Of Origin"                          .= sliCol107
        , "Producer"                                   .= sliCol108
        , "Subject To RVC Requirements"                .= sliCol109
        , "Purchased YTD"                              .= sliCol110
        , "Manufactured YTD"                           .= sliCol111
        , "Used YTD"                                   .= sliCol112
        , "Sold YTD"                                   .= sliCol113
        , "Subject To Excise Tax"                      .= sliCol114
        , "Excise Tax Percent"                         .= sliCol115
        , "Wholesale Price"                            .= sliCol116
        , "Includes Item Content"                      .= sliCol117
        , "Order Configurable"                         .= sliCol118
        , "Job Configurable"                           .= sliCol119
        , "Auto Job Generation"                        .= sliCol120
        , "Name Space"                                 .= sliCol121
        , "Configuration Flag"                         .= sliCol122
        , "Feature String"                             .= sliCol123
        , "Feature Template"                           .= sliCol124
        , "Last Import Date"                           .= sliCol125
        , "Save Current Revision Upon Import"          .= sliCol126
        , "Overview"                                   .= sliCol127
        , "Active For Customer Portal"                 .= sliCol128
        , "Featured Item"                              .= sliCol129
        , "Top Seller"                                 .= sliCol130
        , "Item Attribute Group"                       .= sliCol131
        , "Item Attribute Group Description"           .= sliCol132
        , "Lot Attribute Group"                        .= sliCol133
        , "Lot Attribute Group Description"            .= sliCol134
        , "Enable Pieces Inventory"                    .= sliCol135
        , "Piece Dimension Group"                      .= sliCol136
        , "Piece Dimension Group Description"          .= sliCol137
        , "Portal Pricing Enabled"                     .= sliCol138
        , "Portal Pricing Site"                        .= sliCol139
        , "Freight"                                    .= sliCol140
        , "Estimated Break Date"                       .= sliCol141
        , "Date of Last Report"                        .= sliCol142
        ]


--sytelineItemHeader :: Vector String
sytelineItemHeader :: Header
sytelineItemHeader = fromList
    [ "Item"
    , "U/M"
    , "Description"
    , "Quantity On Hand"
    , "Safety Stock"
    , "Type,Standard Unit Cost"
    , "Current Unit Cost"
    , "Stocked"
    , "Source"
    , "Planner Code"
    , "Buyer"
    , "Product Code"
    , "ABC Code"
    , "Cost Type"
    , "Cost Method"
    , "Revision"
    , "Revision Track"
    , "ECN"
    , "Drawing Number"
    , "Alternate Item"
    , "Show In Drop-Down Lists"
    , "Created By"
    , "Create Date"
    , "Lot Size"
    , "Unit Weight"
    , "Weight Units"
    , "Non-Nettable Stock"
    , "Quantity Ordered"
    , "Quantity WIP"
    , "Allocated To Prod"
    , "Allocated To Customer Orders"
    , "Reserved For Customer Orders"
    , "Low Level"
    , "Active for Data Integration"
    , "Shrink Factor"
    , "Phantom Flag"
    , "MPS Flag"
    , "Net Change"
    , "MPS Plan Fence"
    , "Family Code"
    , "Production Type"
    , "Rate/Day"
    , "Inventory LCL %"
    , "Inventory UCL %"
    , "Supply Site"
    , "Supply Whse"
    , "Paper Work"
    , "Fixed Lead Time"
    , "Expedited Fixed"
    , "Dock-to-Stock"
    , "Variable"
    , "Expedited Variable"
    , "Separation"
    , "Release 1"
    , "Release 2"
    , "Release 3"
    , "MRP Item"
    , "Infinite"
    , "Planned Mfg Supply Switching"
    , "Accept Requirements"
    , "Pass Requirements"
    , "Must use future POs before creating PLNs"
    , "Supply Usage Tolerance"
    , "Time Fence Rule"
    , "Time Fence Value"
    , "Setup Group"
    , "Order Minimum"
    , "Order Multiple"
    , "Order Maximum"
    , "Days Supply"
    , "Use Reorder Point"
    , "Reorder Point"
    , "Fixed Order Qty"
    , "Earliest Planned Purchase Receipt"
    , "Targeted Safety Stock Replenishment"
    , "Lot Track"
    , "Preassign Lots"
    , "Lot Prefix"
    , "S/N Track"
    , "Preassign Serials"
    , "S/N Prefix"
    , "Shelf Life"
    , "Issue By"
    , "Material Status"
    , "Reason"
    , "Last Change"
    , "User"
    , "Backflush"
    , "Backflush Location"
    , "Preferred Co-product Mix"
    , "Reservable"
    , "Tax-Free Imported Material"
    , "Tax Free Days"
    , "Safety Stock Percent"
    , "Tariff Classification"
    , "PO Tolerance Over"
    , "PO Tolerance Under"
    , "Kit"
    , "Print Kit Components on Customer Paperwork"
    , "Std Due Period"
    , "Commodity"
    , "Commodity Description"
    , "Taxable"
    , "Tax Code Description"
    , "Origin"
    , "Country"
    , "Preference Criterion"
    , "Country Of Origin"
    , "Producer"
    , "Subject To RVC Requirements"
    , "Purchased YTD"
    , "Manufactured YTD"
    , "Used YTD"
    , "Sold YTD"
    , "Subject To Excise Tax"
    , "Excise Tax Percent"
    , "Wholesale Price"
    , "Includes Item Content"
    , "Order Configurable"
    , "Job Configurable"
    , "Auto Job Generation"
    , "Name Space"
    , "Configuration Flag"
    , "Feature String"
    , "Feature Template"
    , "Last Import Date"
    , "Save Current Revision Upon Import"
    , "Overview"
    , "Active For Customer Portal"
    , "Featured Item"
    , "Top Seller"
    , "Item Attribute Group"
    , "Item Attribute Group Description"
    , "Lot Attribute Group"
    , "Lot Attribute Group Description"
    , "Enable Pieces Inventory"
    , "Piece Dimension Group"
    , "Piece Dimension Group Description"
    , "Portal Pricing Enabled"
    , "Portal Pricing Site"
    , "Freight"
    , "Estimated Break Date"
    , "Date of Last Report"
    ]
