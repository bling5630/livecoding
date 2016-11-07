module BomGen.Csv.SytelineOperation where


import BasicPrelude

import Data.Csv (ToNamedRecord(..), (.=), namedRecord)

import BomGen.Data.SyteLine


defSytelineOperation :: SytelineOperation
defSytelineOperation = SytelineOperation
    { sloCol000 = ""
    , sloCol001 = ""
    , sloCol002 = ""
    , sloCol003 = ""
    , sloCol004 = ""
    , sloCol005 = ""
    , sloCol006 = ""
    , sloCol007 = ""
    , sloCol008 = ""
    , sloCol009 = ""
    , sloCol010 = ""
    , sloCol011 = ""
    , sloCol012 = ""
    , sloCol013 = ""
    , sloCol014 = ""
    , sloCol015 = ""
    , sloCol016 = ""
    , sloCol017 = ""
    , sloCol018 = ""
    , sloCol019 = ""
    , sloCol020 = ""
    , sloCol021 = ""
    , sloCol022 = ""
    , sloCol023 = ""
    , sloCol024 = ""
    , sloCol025 = ""
    , sloCol026 = ""
    , sloCol027 = ""
    , sloCol028 = ""
    , sloCol029 = ""
    , sloCol030 = ""
    , sloCol031 = ""
    , sloCol032 = ""
    , sloCol033 = ""
    , sloCol034 = ""
    , sloCol035 = ""
    , sloCol036 = ""
    , sloCol037 = ""
    , sloCol038 = ""
    , sloCol039 = ""
    }


instance ToNamedRecord SytelineOperation where
    toNamedRecord SytelineOperation {..} = namedRecord
        [ "Item"                      .= sloCol000
        , "Item Description"          .= sloCol001
        , "Operation"                 .= sloCol002
        , "WC"                        .= sloCol003
        , "WC Description"            .= sloCol004
        , "Use Fixed Schedule"        .= sloCol005
        , "Fixed Sched Hours"         .= sloCol006
        , "Run-Hours Basis (Machine)" .= sloCol007
        , "Mach Hrs per Piece,Run-Hours Basis (Labor)" .= sloCol008
        , "Labor Hr per Piece"        .= sloCol009
        , "Sched Driver"              .= sloCol010
        , "Run Duration"              .= sloCol011
        , "Batch Definition"          .= sloCol012
        , "Yield"                     .= sloCol013
        , "Move Hours"                .= sloCol014
        , "Queue Time"                .= sloCol015
        , "Setup Hours"               .= sloCol016
        , "Finish"                    .= sloCol017
        , "Use Offset Hours"          .= sloCol018
        , "Offset Hours"              .= sloCol019
        , "Effective Date"            .= sloCol020
        , "Obsolete Date"             .= sloCol021
        , "Control Point"             .= sloCol022
        , "Backflush"                 .= sloCol023
        , "Setup Resource Group"      .= sloCol024
        , "Setup Rule"                .= sloCol025
        , "Setup Basis"               .= sloCol026
        , "Setup Time Rule"           .= sloCol027
        , "Setup Matrix"              .= sloCol028
        , "Scheduler Rule"            .= sloCol029
        , "Split Size"                .= sloCol030
        , "Custom Planner Rule"       .= sloCol031
        , "Break Rule"                .= sloCol032
        , "Efficiency"                .= sloCol033
        , "Setup Rate"                .= sloCol034
        , "Run Rate (Labor)"          .= sloCol035
        , "Var Mach Ovhd Rate"        .= sloCol036
        , "Fix Machine Ovhd Rate"     .= sloCol037
        , "Var Ovhd Rate"             .= sloCol038
        , "Fixed Ovhd Rate"           .= sloCol039
        ]
