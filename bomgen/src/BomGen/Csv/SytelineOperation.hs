module BomGen.Csv.SytelineOperation where


import BasicPrelude

import Data.Csv (ToNamedRecord(..), (.=), namedRecord)

data SytelineOperation = SytelineOperation
    { sloCol000 :: !Text -- "Item"
    , sloCol001 :: !Text -- "Item Description"
    , sloCol002 :: !Text -- "Operation"
    , sloCol003 :: !Text -- "WC"
    , sloCol004 :: !Text -- "WC Description"
    , sloCol005 :: !Text -- "Use Fixed Schedule"
    , sloCol006 :: !Text -- "Fixed Sched Hours"
    , sloCol007 :: !Text -- "Run-Hours Basis (Machine)"
    , sloCol008 :: !Text -- "Mach Hrs per Piece,Run-Hours Basis (Labor)"
    , sloCol009 :: !Text -- "Labor Hr per Piece"
    , sloCol010 :: !Text -- "Sched Driver"
    , sloCol011 :: !Text -- "Run Duration"
    , sloCol012 :: !Text -- "Batch Definition"
    , sloCol013 :: !Text -- "Yield"
    , sloCol014 :: !Text -- "Move Hours"
    , sloCol015 :: !Text -- "Queue Time"
    , sloCol016 :: !Text -- "Setup Hours"
    , sloCol017 :: !Text -- "Finish"
    , sloCol018 :: !Text -- "Use Offset Hours"
    , sloCol019 :: !Text -- "Offset Hours"
    , sloCol020 :: !Text -- "Effective Date"
    , sloCol021 :: !Text -- "Obsolete Date"
    , sloCol022 :: !Text -- "Control Point"
    , sloCol023 :: !Text -- "Backflush"
    , sloCol024 :: !Text -- "Setup Resource Group"
    , sloCol025 :: !Text -- "Setup Rule"
    , sloCol026 :: !Text -- "Setup Basis"
    , sloCol027 :: !Text -- "Setup Time Rule"
    , sloCol028 :: !Text -- "Setup Matrix"
    , sloCol029 :: !Text -- "Scheduler Rule"
    , sloCol030 :: !Text -- "Split Size"
    , sloCol031 :: !Text -- "Custom Planner Rule"
    , sloCol032 :: !Text -- "Break Rule"
    , sloCol033 :: !Text -- "Efficiency"
    , sloCol034 :: !Text -- "Setup Rate"
    , sloCol035 :: !Text -- "Run Rate (Labor)"
    , sloCol036 :: !Text -- "Var Mach Ovhd Rate"
    , sloCol037 :: !Text -- "Fix Machine Ovhd Rate"
    , sloCol038 :: !Text -- "Var Ovhd Rate"
    , sloCol039 :: !Text -- "Fixed Ovhd Rate"
    } deriving (Eq, Show)

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
