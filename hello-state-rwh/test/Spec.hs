import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

import HelloStateRwh

main :: IO ()
main = hspec $ do
    describe "testing stuff" $ do

        it "foo returns the expected value" $ do
            foo `shouldBe` ("foo" :: String)
