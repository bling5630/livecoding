module Main where


import System.Environment
import System.IO
import System.IO.Error
import Control.Exception


-- safeGetEnv :: String -> IO (Either IOException String)
-- safeGetEnv name = try $ getEnv "HOMExxxx"
--main = do
--    r <- safeGetEnv "HOME"
--    case r of
--        Left e        -> putStrLn (show (isDoesNotExistError e))
--        Right home    -> putStrLn home

-- openFileThrowingExceptions :: FilePath -> IOMode -> IO (Either IOException Handle)
-- openFileThrowingExceptions filePath ioMode = try $ openFile filePath ioMode

main = do
    r <- try $ openFile "LICENSE" ReadMode :: IO (Either IOException Handle)
    case r of
        Left e  -> case ioeGetErrorType e of
                     DoesNotExistError    -> print "foo"
                     AlreadyExistsError   -> print "bar"
        Right h -> print "baz"

--     case r of
--         Left e       -> if isDoesNotExistError e then print "foo" else print "bar"
--         Right handle -> print "baz"

-- import Control.Exception
-- import System.IO
--
-- main :: IO ()
-- main = do
--     mmyFile <- (do
--                     handle <- openFile "myfile.txt" ReadMode
--                     return $ Just handle)
--         `catch` (\(e :: ArithException) -> do
--             putStrLn $ "no permissions to open that file" ++ show e
--             return Nothing)
--         `catch` (\(e :: ArrayException) -> do
--             putStrLn $ "file not found: " ++ show e
--             return Nothing)
--         `catch` (\(e :: SomeException) -> do
--             putStrLn $ "the unexpected happened: " ++ show e
--             r
--eturn Nothing)
--     case mmyFile of
--       Nothing -> return ()
--       Just myFile -> putStrLn "success":
--
