module BomGen.Data.AppData where


import BasicPrelude ()

import BomGen.Map.PartMap


data AppData = AppData
    { partMap      :: PartMap
    , operationMap :: PartMap
    , materialMap  :: PartMap
    }
