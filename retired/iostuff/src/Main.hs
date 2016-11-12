module Main where

import System.Posix.Files            (FileStatus, getFileStatus, modificationTime)
import System.Posix.Types            (EpochTime)
import System.Process                (system)
import System.Exit                   (ExitCode(..))
import Control.Exception             (try)


fileMTime :: FilePath -> IO EpochTime
fileMTime path = do
    fileStatus <- try $ getFileStatus path :: IO (Either IOError FileStatus)
    case fileStatus of
        Left _           -> return 0
        Right fileStatus -> return $ modificationTime fileStatus


updateDst :: FilePath -> FilePath -> IO (Either String ExitCode)
updateDst srcPath dstPath = do
    srcStatus <- try $ getFileStatus srcPath :: IO (Either IOError FileStatus)
    case srcStatus of
        Left err         -> return $ Left (show err)
        Right srcStatus' -> do
            let srcTime = modificationTime srcStatus'
            dstTime <- fileMTime dstPath
            if srcTime > dstTime
                then do
                    let cmd = "xlsx2csv --delimiter=',' --sheet=1 " ++ srcPath ++ " " ++ dstPath  ++ "> /dev/null 2>&1"
                    exitResult <- try $ system cmd :: IO (Either IOError ExitCode)
                    case exitResult of
                        Left err         -> return $ Left (show err)
                        Right exitStatus ->
                            case exitStatus of
                                ExitSuccess -> return $ Right ExitSuccess
                                ExitFailure n -> return $ Left $ "exit failure " ++ (show n)
                else return $ Right ExitSuccess


main :: IO ()
main = do
    exitCode <- updateDst srcPath dstPath
    print exitCode
  where
    srcPath = "srcfile.xlsx"
    dstPath = "dstfile.csv"
