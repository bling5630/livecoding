module BomGen.Pretty.Bom where

import BasicPrelude hiding          ((<>), empty)

import Text.PrettyPrint.Leijen.Text (Pretty(..), comma, (<>), (<+>), (<$$>), indent, vsep, empty)
import Data.Text.Lazy               (fromStrict)

import BomGen.Data.Bom

instance Pretty Item where
    pretty (SkippedItem desc) = "Skipped Item:" <+> pretty desc
    pretty EmptyItem = empty
    pretty Item{..} =
        pretty itemHeader <$$>
        indent 4 (vsep (fmap pretty operations))

instance Pretty ItemHeader where
    pretty ItemHeader{..} =
        "itemPn=" <> pretty itemPn <> comma <+>
        pretty itemFields

instance Pretty ItemFields where
    pretty ItemFields{..} =
        "ifUoM="  <> pretty ifUoM <> comma <+>
        "ifDesc=" <> pretty ifDesc

instance Pretty Operation where
    pretty Operation{..} =
        pretty operationHeader <$$>
        indent 4 (vsep (fmap pretty items))

instance Pretty OperationHeader where
    pretty OperationHeader{..} =
        "opNum=" <> pretty opNum

instance Pretty UnitOfMeasure where
    pretty Each = "Each"
    pretty Pair = "Pairs"

instance Pretty Text where
    pretty pn = pretty (fromStrict pn)
