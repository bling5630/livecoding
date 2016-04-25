{-# LANGUAGE OverloadedStrings #-}

module Main where

import Prelude as P hiding
    ( putStrLn
    , getLine
    , length
    , reverse
    , null
    )

import Data.Text
    ( length
    , reverse
    , null
    , toUpper
    , toLower
    )

import Data.Text.IO
    ( putStrLn
    , getLine
    )

import TextShow
    ( showb
    , toText
    )

import System.IO
    ( hFlush
    , stdout
    )

import Data.Monoid
    ((<>)
    )


printT a = (putStrLn . toText . showb) a


main = do
    putStrLn "Enter text:"
    hFlush stdout
    line <- getLine
    printT $ length line
    putStrLn $ reverse line
    printT $ null line
    printT $ toUpper line
    printT $ toLower line
