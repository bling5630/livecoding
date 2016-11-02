module BomGen.Csv.SytelineItem where

import BasicPrelude

import Data.Csv (ToNamedRecord(..), (.=), namedRecord)

data SytelineItem = SytelineItem
    { sliCol000 :: !Text -- "Item"
    , sliCol001 :: !Text -- "U/M"
    , sliCol002 :: !Text -- "Description"
    , sliCol003 :: !Text -- "Quantity On Hand"
    , sliCol004 :: !Text -- "Safety Stock"
    , sliCol005 :: !Text -- "Type,Standard Unit Cost"
    , sliCol006 :: !Text -- "Current Unit Cost"
    , sliCol007 :: !Text -- "Stocked"
    , sliCol008 :: !Text -- "Source"
    , sliCol009 :: !Text -- "Planner Code"
    , sliCol010 :: !Text -- "Buyer"
    , sliCol011 :: !Text -- "Product Code"
    , sliCol012 :: !Text -- "ABC Code"
    , sliCol013 :: !Text -- "Cost Type"
    , sliCol014 :: !Text -- "Cost Method"
    , sliCol015 :: !Text -- "Revision"
    , sliCol016 :: !Text -- "Revision Track"
    , sliCol017 :: !Text -- "ECN"
    , sliCol018 :: !Text -- "Drawing Number"
    , sliCol019 :: !Text -- "Alternate Item"
    , sliCol020 :: !Text -- "Show In Drop-Down Lists"
    , sliCol021 :: !Text -- "Created By"
    , sliCol022 :: !Text -- "Create Date"
    , sliCol023 :: !Text -- "Lot Size"
    , sliCol024 :: !Text -- "Unit Weight"
    , sliCol025 :: !Text -- "Weight Units"
    , sliCol026 :: !Text -- "Non-Nettable Stock"
    , sliCol027 :: !Text -- "Quantity Ordered"
    , sliCol028 :: !Text -- "Quantity WIP"
    , sliCol029 :: !Text -- "Allocated To Prod"
    , sliCol030 :: !Text -- "Allocated To Customer Orders"
    , sliCol031 :: !Text -- "Reserved For Customer Orders"
    , sliCol032 :: !Text -- "Low Level"
    , sliCol033 :: !Text -- "Active for Data Integration"
    , sliCol034 :: !Text -- "Shrink Factor"
    , sliCol035 :: !Text -- "Phantom Flag"
    , sliCol036 :: !Text -- "MPS Flag"
    , sliCol037 :: !Text -- "Net Change"
    , sliCol038 :: !Text -- "MPS Plan Fence"
    , sliCol039 :: !Text -- "Family Code"
    , sliCol040 :: !Text -- "Production Type"
    , sliCol041 :: !Text -- "Rate/Day"
    , sliCol042 :: !Text -- "Inventory LCL %"
    , sliCol043 :: !Text -- "Inventory UCL %"
    , sliCol044 :: !Text -- "Supply Site"
    , sliCol045 :: !Text -- "Supply Whse"
    , sliCol046 :: !Text -- "Paper Work"
    , sliCol047 :: !Text -- "Fixed Lead Time"
    , sliCol048 :: !Text -- "Expedited Fixed"
    , sliCol049 :: !Text -- "Dock-to-Stock"
    , sliCol050 :: !Text -- "Variable"
    , sliCol051 :: !Text -- "Expedited Variable"
    , sliCol052 :: !Text -- "Separation"
    , sliCol053 :: !Text -- "Release 1"
    , sliCol054 :: !Text -- "Release 2"
    , sliCol055 :: !Text -- "Release 3"
    , sliCol056 :: !Text -- "MRP Item"
    , sliCol057 :: !Text -- "Infinite"
    , sliCol058 :: !Text -- "Planned Mfg Supply Switching"
    , sliCol059 :: !Text -- "Accept Requirements"
    , sliCol060 :: !Text -- "Pass Requirements"
    , sliCol061 :: !Text -- "Must use future POs before creating PLNs"
    , sliCol062 :: !Text -- "Supply Usage Tolerance"
    , sliCol063 :: !Text -- "Time Fence Rule"
    , sliCol064 :: !Text -- "Time Fence Value"
    , sliCol065 :: !Text -- "Setup Group"
    , sliCol066 :: !Text -- "Order Minimum"
    , sliCol067 :: !Text -- "Order Multiple"
    , sliCol068 :: !Text -- "Order Maximum"
    , sliCol069 :: !Text -- "Days Supply"
    , sliCol070 :: !Text -- "Use Reorder Point"
    , sliCol071 :: !Text -- "Reorder Point"
    , sliCol072 :: !Text -- "Fixed Order Qty"
    , sliCol073 :: !Text -- "Earliest Planned Purchase Receipt"
    , sliCol074 :: !Text -- "Targeted Safety Stock Replenishment"
    , sliCol075 :: !Text -- "Lot Track"
    , sliCol076 :: !Text -- "Preassign Lots"
    , sliCol077 :: !Text -- "Lot Prefix"
    , sliCol078 :: !Text -- "S/N Track"
    , sliCol079 :: !Text -- "Preassign Serials"
    , sliCol080 :: !Text -- "S/N Prefix"
    , sliCol081 :: !Text -- "Shelf Life"
    , sliCol082 :: !Text -- "Issue By"
    , sliCol083 :: !Text -- "Material Status"
    , sliCol084 :: !Text -- "Reason"
    , sliCol085 :: !Text -- "Last Change"
    , sliCol086 :: !Text -- "User"
    , sliCol087 :: !Text -- "Backflush"
    , sliCol088 :: !Text -- "Backflush Location"
    , sliCol089 :: !Text -- "Preferred Co-product Mix"
    , sliCol090 :: !Text -- "Reservable"
    , sliCol091 :: !Text -- "Tax-Free Imported Material"
    , sliCol092 :: !Text -- "Tax Free Days"
    , sliCol093 :: !Text -- "Safety Stock Percent"
    , sliCol094 :: !Text -- "Tariff Classification"
    , sliCol095 :: !Text -- "PO Tolerance Over"
    , sliCol096 :: !Text -- "PO Tolerance Under"
    , sliCol097 :: !Text -- "Kit"
    , sliCol098 :: !Text -- "Print Kit Components on Customer Paperwork"
    , sliCol099 :: !Text -- "Std Due Period"
    , sliCol100 :: !Text -- "Commodity"
    , sliCol101 :: !Text -- "Commodity Description"
    , sliCol102 :: !Text -- "Taxable"
    , sliCol103 :: !Text -- "Tax Code Description"
    , sliCol104 :: !Text -- "Origin"
    , sliCol105 :: !Text -- "Country"
    , sliCol106 :: !Text -- "Preference Criterion"
    , sliCol107 :: !Text -- "Country Of Origin"
    , sliCol108 :: !Text -- "Producer"
    , sliCol109 :: !Text -- "Subject To RVC Requirements"
    , sliCol110 :: !Text -- "Purchased YTD"
    , sliCol111 :: !Text -- "Manufactured YTD"
    , sliCol112 :: !Text -- "Used YTD"
    , sliCol113 :: !Text -- "Sold YTD"
    , sliCol114 :: !Text -- "Subject To Excise Tax"
    , sliCol115 :: !Text -- "Excise Tax Percent"
    , sliCol116 :: !Text -- "Wholesale Price"
    , sliCol117 :: !Text -- "Includes Item Content"
    , sliCol118 :: !Text -- "Order Configurable"
    , sliCol119 :: !Text -- "Job Configurable"
    , sliCol120 :: !Text -- "Auto Job Generation"
    , sliCol121 :: !Text -- "Name Space"
    , sliCol122 :: !Text -- "Configuration Flag"
    , sliCol123 :: !Text -- "Feature String"
    , sliCol124 :: !Text -- "Feature Template"
    , sliCol125 :: !Text -- "Last Import Date"
    , sliCol126 :: !Text -- "Save Current Revision Upon Import"
    , sliCol127 :: !Text -- "Overview"
    , sliCol128 :: !Text -- "Active For Customer Portal"
    , sliCol129 :: !Text -- "Featured Item"
    , sliCol130 :: !Text -- "Top Seller"
    , sliCol131 :: !Text -- "Item Attribute Group"
    , sliCol132 :: !Text -- "Item Attribute Group Description"
    , sliCol133 :: !Text -- "Lot Attribute Group"
    , sliCol134 :: !Text -- "Lot Attribute Group Description"
    , sliCol135 :: !Text -- "Enable Pieces Inventory"
    , sliCol136 :: !Text -- "Piece Dimension Group"
    , sliCol137 :: !Text -- "Piece Dimension Group Description"
    , sliCol138 :: !Text -- "Portal Pricing Enabled"
    , sliCol139 :: !Text -- "Portal Pricing Site"
    , sliCol140 :: !Text -- "Freight"
    , sliCol141 :: !Text -- "Estimated Break Date"
    , sliCol142 :: !Text -- "Date of Last Report"
    } deriving (Show, Eq)

defSytelineItem :: SytelineItem
defSytelineItem = SytelineItem
    { sliCol000 = ""
    , sliCol001 = ""
    , sliCol002 = ""
    , sliCol003 = ""
    , sliCol004 = ""
    , sliCol005 = ""
    , sliCol006 = ""
    , sliCol007 = ""
    , sliCol008 = ""
    , sliCol009 = ""
    , sliCol010 = ""
    , sliCol011 = ""
    , sliCol012 = ""
    , sliCol013 = ""
    , sliCol014 = ""
    , sliCol015 = ""
    , sliCol016 = ""
    , sliCol017 = ""
    , sliCol018 = ""
    , sliCol019 = ""
    , sliCol020 = ""
    , sliCol021 = ""
    , sliCol022 = ""
    , sliCol023 = ""
    , sliCol024 = ""
    , sliCol025 = ""
    , sliCol026 = ""
    , sliCol027 = ""
    , sliCol028 = ""
    , sliCol029 = ""
    , sliCol030 = ""
    , sliCol031 = ""
    , sliCol032 = ""
    , sliCol033 = ""
    , sliCol034 = ""
    , sliCol035 = ""
    , sliCol036 = ""
    , sliCol037 = ""
    , sliCol038 = ""
    , sliCol039 = ""
    , sliCol040 = ""
    , sliCol041 = ""
    , sliCol042 = ""
    , sliCol043 = ""
    , sliCol044 = ""
    , sliCol045 = ""
    , sliCol046 = ""
    , sliCol047 = ""
    , sliCol048 = ""
    , sliCol049 = ""
    , sliCol050 = ""
    , sliCol051 = ""
    , sliCol052 = ""
    , sliCol053 = ""
    , sliCol054 = ""
    , sliCol055 = ""
    , sliCol056 = ""
    , sliCol057 = ""
    , sliCol058 = ""
    , sliCol059 = ""
    , sliCol060 = ""
    , sliCol061 = ""
    , sliCol062 = ""
    , sliCol063 = ""
    , sliCol064 = ""
    , sliCol065 = ""
    , sliCol066 = ""
    , sliCol067 = ""
    , sliCol068 = ""
    , sliCol069 = ""
    , sliCol070 = ""
    , sliCol071 = ""
    , sliCol072 = ""
    , sliCol073 = ""
    , sliCol074 = ""
    , sliCol075 = ""
    , sliCol076 = ""
    , sliCol077 = ""
    , sliCol078 = ""
    , sliCol079 = ""
    , sliCol080 = ""
    , sliCol081 = ""
    , sliCol082 = ""
    , sliCol083 = ""
    , sliCol084 = ""
    , sliCol085 = ""
    , sliCol086 = ""
    , sliCol087 = ""
    , sliCol088 = ""
    , sliCol089 = ""
    , sliCol090 = ""
    , sliCol091 = ""
    , sliCol092 = ""
    , sliCol093 = ""
    , sliCol094 = ""
    , sliCol095 = ""
    , sliCol096 = ""
    , sliCol097 = ""
    , sliCol098 = ""
    , sliCol099 = ""
    , sliCol100 = ""
    , sliCol101 = ""
    , sliCol102 = ""
    , sliCol103 = ""
    , sliCol104 = ""
    , sliCol105 = ""
    , sliCol106 = ""
    , sliCol107 = ""
    , sliCol108 = ""
    , sliCol109 = ""
    , sliCol110 = ""
    , sliCol111 = ""
    , sliCol112 = ""
    , sliCol113 = ""
    , sliCol114 = ""
    , sliCol115 = ""
    , sliCol116 = ""
    , sliCol117 = ""
    , sliCol118 = ""
    , sliCol119 = ""
    , sliCol120 = ""
    , sliCol121 = ""
    , sliCol122 = ""
    , sliCol123 = ""
    , sliCol124 = ""
    , sliCol125 = ""
    , sliCol126 = ""
    , sliCol127 = ""
    , sliCol128 = ""
    , sliCol129 = ""
    , sliCol130 = ""
    , sliCol131 = ""
    , sliCol132 = ""
    , sliCol133 = ""
    , sliCol134 = ""
    , sliCol135 = ""
    , sliCol136 = ""
    , sliCol137 = ""
    , sliCol138 = ""
    , sliCol139 = ""
    , sliCol140 = ""
    , sliCol141 = ""
    , sliCol142 = ""
    }

instance ToNamedRecord SytelineItem where
    toNamedRecord SytelineItem {..} = namedRecord
        [ "Item"                                       .= sliCol000
        , "U/M"                                        .= sliCol001
        , "Description"                                .= sliCol002
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

