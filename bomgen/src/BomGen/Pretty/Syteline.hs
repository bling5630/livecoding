module BomGen.Pretty.Syteline where

import BasicPrelude hiding          ((<>), empty)

import Text.PrettyPrint.Leijen.Text (Pretty(..), comma, (<>), (<+>), (<$$>), indent, vsep, empty, line)
import Data.Text.Lazy               (fromStrict)

import BomGen.Data.SyteLine
import BomGen.Pretty.Bom

instance Pretty SytelineItem where
    pretty SytelineItem{..} =
        "Item="             <> pretty sliItem <> comma <+>
        "U/M="              <> pretty sliUoM  <> comma <+>
        "Description=\""    <> pretty sliDesc <> "\""


instance Pretty SytelineOperation where
    pretty SytelineOperation{..} =
        "Operations="                            <+>
        "item="       <> pretty sloItem <> comma <+>
        "opNum="      <> pretty sloOpNum


instance Pretty SytelineMaterial where
    pretty SytelineMaterial{..} =
        "Material="                                  <+>
        "item="         <> pretty slmCol000 <> comma <+>
        "itemDesc="     <> pretty slmCol001 <> comma <+>
        "op="           <> pretty slmCol002 <> comma <+>
        "material="     <> pretty slmCol004 <> comma <+>
        "materialDesc=" <> pretty slmCol005

