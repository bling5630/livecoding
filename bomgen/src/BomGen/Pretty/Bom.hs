module BomGen.Pretty.Bom where

import BasicPrelude hiding          ((<>), empty)

import Text.PrettyPrint.Leijen.Text (Pretty(..), comma, (<>), (<+>), (<$$>), indent, vsep, empty)
import Data.Text.Lazy               (fromStrict)

import BomGen.Data.Bom

instance Pretty Item where
    pretty (SkippedItem desc) = "Skipped Item:" <+> pretty desc
    pretty NullItem = empty
    pretty Item{..} =
        "pn=" <> pretty pn <> comma <+>
        "desc=" <> pretty desc <> comma <+>
        "uom=" <> pretty uom <$$>
        indent 4 (vsep (fmap pretty operations))


instance Pretty Operation where
    pretty Operation{..} =
        "opNum=" <> pretty opNum <$$>
        indent 4 (vsep (fmap pretty materials))


instance Pretty UnitOfMeasure where
    pretty Each  = "Each"
    pretty Pairs = "Pairs"

instance Pretty Text where
    pretty pn = pretty (fromStrict pn)
