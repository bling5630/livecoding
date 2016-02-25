import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

import SerialNumberParser
import Data.Maybe
import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Error
import Data.Either

main :: IO ()

main = hspec $ do
    parallel $ do
        describe "testing stuff" $ do

             it "parseSerial fails on empty string" $ do
                 parseSerial "" `shouldSatisfy` isLeft 
 
             it "parseSerial doesn't fail on a valid string" $ do
                 parseSerial "USXYZ12345A616\n" `shouldSatisfy` isRight 
 
             it "parseSerial doesn't fail on a valid string" $ do
                 parseSerial "USXYZ12345A616\n" `shouldBe` Right SerialNumber { manfCode = ManfCode {country = Just "US", manf = "XYZ" }, serialId = "12345", month = 'A', buildYear = '6', modelYear = "16" }   
 
             it "should start with" $ do
                 [1,2,3] `shouldStartWith` [1,2]
 
             it "should end with " $ do
                 [1,2,3] `shouldEndWith` [2,3]
 
             it "should contains" $ do
                 [1,2,3] `shouldContain` [2]
 
             it "should match" $ do
                 [1,2,3] `shouldMatchList` [3,2,1]
 
             it "should return" $ do
                 (return "foo" :: IO String) `shouldReturn` "foo" 
 
             it "should be pending" $ do
                 pending
 
             it "should be pending" $ do
                 pendingWith "bingo"
 
 

            it "is inverse to show" $ property $
               \xs -> reverse (reverse xs) == (xs :: [Int])
