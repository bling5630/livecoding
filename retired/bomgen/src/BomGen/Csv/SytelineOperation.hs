module BomGen.Csv.SytelineOperation where


import BasicPrelude

import Data.Csv (ToNamedRecord(..), (.=), namedRecord, Header)
import Data.Vector (fromList)

import BomGen.Data.SyteLine


instance ToNamedRecord SytelineOperation where
    toNamedRecord SytelineOperation {..} = namedRecord
        [ "Item"                                       .= sloItem
        , "Item Description"                           .= sloCol001
        , "Operation"                                  .= sloOpNum
        , "WC"                                         .= sloCol003
        , "WC Description"                             .= sloCol004
        , "Use Fixed Schedule"                         .= sloCol005
        , "Fixed Sched Hours"                          .= sloCol006
        , "Run-Hours Basis (Machine)"                  .= sloCol007
        , "Mach Hrs per Piece,Run-Hours Basis (Labor)" .= sloCol008
        , "Labor Hr per Piece"                         .= sloCol009
        , "Sched Driver"                               .= sloCol010
        , "Run Duration"                               .= sloCol011
        , "Batch Definition"                           .= sloCol012
        , "Yield"                                      .= sloCol013
        , "Move Hours"                                 .= sloCol014
        , "Queue Time"                                 .= sloCol015
        , "Setup Hours"                                .= sloCol016
        , "Finish"                                     .= sloCol017
        , "Use Offset Hours"                           .= sloCol018
        , "Offset Hours"                               .= sloCol019
        , "Effective Date"                             .= sloCol020
        , "Obsolete Date"                              .= sloCol021
        , "Control Point"                              .= sloCol022
        , "Backflush"                                  .= sloCol023
        , "Setup Resource Group"                       .= sloCol024
        , "Setup Rule"                                 .= sloCol025
        , "Setup Basis"                                .= sloCol026
        , "Setup Time Rule"                            .= sloCol027
        , "Setup Matrix"                               .= sloCol028
        , "Scheduler Rule"                             .= sloCol029
        , "Split Size"                                 .= sloCol030
        , "Custom Planner Rule"                        .= sloCol031
        , "Break Rule"                                 .= sloCol032
        , "Efficiency"                                 .= sloCol033
        , "Setup Rate"                                 .= sloCol034
        , "Run Rate (Labor)"                           .= sloCol035
        , "Var Mach Ovhd Rate"                         .= sloCol036
        , "Fix Machine Ovhd Rate"                      .= sloCol037
        , "Var Ovhd Rate"                              .= sloCol038
        , "Fixed Ovhd Rate"                            .= sloCol039
        ]


sytelineOperationHeader :: Header
sytelineOperationHeader = fromList
        [ "Item"
        , "Item Description"
        , "Operation"
        , "WC"
        , "WC Description"
        , "Use Fixed Schedule"
        , "Fixed Sched Hours"
        , "Run-Hours Basis (Machine)"
        , "Mach Hrs per Piece,Run-Hours Basis (Labor)"
        , "Labor Hr per Piece"
        , "Sched Driver"
        , "Run Duration"
        , "Batch Definition"
        , "Yield"
        , "Move Hours"
        , "Queue Time"
        , "Setup Hours"
        , "Finish"
        , "Use Offset Hours"
        , "Offset Hours"
        , "Effective Date"
        , "Obsolete Date"
        , "Control Point"
        , "Backflush"
        , "Setup Resource Group"
        , "Setup Rule"
        , "Setup Basis"
        , "Setup Time Rule"
        , "Setup Matrix"
        , "Scheduler Rule"
        , "Split Size"
        , "Custom Planner Rule"
        , "Break Rule"
        , "Efficiency"
        , "Setup Rate"
        , "Run Rate (Labor)"
        , "Var Mach Ovhd Rate"
        , "Fix Machine Ovhd Rate"
        , "Var Ovhd Rate"
        , "Fixed Ovhd Rate"
        ]
