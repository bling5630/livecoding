


CUSTOMER ORDER -> (Product Description) -> Bill Material Generator -> Output


deal with reading configuration
deal with reading in the data
    make use of the data through a part number lut
multiple renders
    summarise product description
    generate pretty tree
    generate import format (3 x csv)

one configurations options is how the program is going to behave when
it's asked to make things it doesn't know how to make

-- view only (all warnings) skipped items
-- want to be able to force fail on all skipped items
-- want insert null items in place of skipped items <-- filter tree
--    still list warnings that includes all the skipped items 

-- let warnings = filter fn bom
-- case Config{forcerrors} of
--     -> do
--         print warnings
--         fail
--     -> do
--         culledBom = map replaceSkippedWithNull bom
--         case Config{displayformat} of
--             summary -> renderSummary cleaedBom
--             tree ->  renderTree cleanedBom
--             export -> export cleanBom
-- 


