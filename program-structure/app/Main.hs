module Main where

import           Data.Time.Clock
import           Data.Time.Format
import           Data.Time.LocalTime
import qualified Data.ByteString.Char8 as BS
import           Control.Monad.Reader

main = do
    now <- getCurrentTime
    let msg = formatTime defaultTimeLocale "%F %T" now
    runReaderT (appendToFile msg) "bingo.txt"


appendToFile :: String -> ReaderT FilePath IO ()
appendToFile msg = do
    contents <- loadFile
    saveFile (contents ++ msg)


loadFile :: ReaderT FilePath IO String
loadFile = do
    fileName <- ask
    liftIO $ BS.unpack <$> BS.readFile fileName


saveFile :: String -> ReaderT FilePath IO ()
saveFile contents = do
    fileName <- ask
    liftIO $ BS.writeFile fileName (BS.pack contents)



-- main = do
--     now <- getCurrentTime
--     let msg = formatTime defaultTimeLocale "%F %T" now
--     appendToFile "bingo.txt" msg
--
--
-- loadFile :: FilePath -> IO String
-- loadFile fileName =
--   BS.unpack <$> BS.readFile fileName
--
--
-- saveFile :: FilePath -> String -> IO ()
-- saveFile fileName contents =
--   BS.writeFile fileName (BS.pack contents)
--
--
-- appendToFile :: FilePath -> String -> IO ()
-- appendToFile fileName stuff = do
--     contents <- loadFile fileName
--     saveFile fileName (contents++stuff)
