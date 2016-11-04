module BomGen.Data.AppData where


import BasicPrelude ()

import BomGen.Map.Item


data AppData = AppData
    { partMap      :: PartMap
    , operationMap :: PartMap
    , materialMap  :: PartMap
    }
