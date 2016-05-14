module Main where


-- import Control.Error
--
-- askAge :: IO (Either String Int)
-- askAge = note "Invalid input" . readMay <$> getLine
--
-- main = do
--     result <- askAge
--     case result of
--         Left e    -> print e
--         Right age  -> print $ show age


import System.Environment
import Control.Error
import Control.Error.Script


main :: IO ()
main = runScript $ do
    filename <- hoistEither =<< note usage . headMay <$> scriptIO getArgs
    scriptIO $ readFile filename >>= putStrLn . line5
  where
    usage = "Usage: line5 <file>"
    line5 l = lines l !! 5


-- import Control.Monad.Except
--
-- -- An IO monad which can return String failure.
-- -- It is convenient to define the monad type of the combined monad,
-- -- especially if we combine more monad transformers.
-- type LengthMonad = ExceptT String IO
--
-- main = do
--   -- runExceptT removes the ExceptT wrapper
--   r <- runExceptT calculateLength
--   reportResult r
--
-- -- Asks user for a non-empty string and returns its length.
-- -- Throws an error if user enters an empty string.
-- calculateLength :: LengthMonad Int
-- calculateLength = do
--   -- all the IO operations have to be lifted to the IO monad in the monad stack
--   liftIO $ putStrLn "Please enter a non-empty string: "
--   s <- liftIO getLine
--   if null s
--     then throwError "The string was empty!"
--     else return $ length s
--
-- -- Prints result of the string length calculation.
-- reportResult :: Either String Int -> IO ()
-- reportResult (Right len) = putStrLn ("The length of the string is " ++ (show len))
-- reportResult (Left e) = putStrLn ("Length calculation failed with error: " ++ (show e))




-- import Control.Monad.Except
--
-- -- This is the type to represent length calculation error.
-- data LengthError
--     = EmptyString         -- Entered string was empty.
--     | StringTooLong Int   -- A string is longer than 5 characters.
--                           -- Records a length of the string.
--  --   | OtherError String   -- Other error, stores the problem description.
--
-- -- Converts LengthError to a readable message.
-- instance Show LengthError where
--   show EmptyString         = "The string was empty!"
--   show (StringTooLong len) = "The length of the string (" ++ (show len) ++ ") is bigger than 5!"
--   --show (OtherError msg)    = msg
--
-- -- For our monad type constructor, we use Either LengthError
-- -- which represents failure using Left LengthError
-- -- or a successful result of type a using Right a.
-- type LengthMonad = Either LengthError
--
-- main = do
--   putStrLn "Please enter a string:"
--   s <- getLine
--   reportResult (calculateLength s)
--
-- -- Wraps length calculation to catch the errors.
-- -- Returns either length of the string or an error.
-- calculateLength :: String -> LengthMonad Int
-- calculateLength s = (calculateLengthOrFail s) `catchError` Left
--
-- -- Attempts to calculate length and throws an error if the provided string is
-- -- empty or longer than 5 characters.
-- -- The processing is done in Either monad.
-- calculateLengthOrFail :: String -> LengthMonad Int
-- calculateLengthOrFail [] = throwError EmptyString
-- calculateLengthOrFail s
--     | len > 5 = throwError (StringTooLong len)
--     | otherwise = return len
--   where len = length s
--
-- -- Prints result of the string length calculation.
-- reportResult :: LengthMonad Int -> IO ()
-- reportResult (Right len) = putStrLn ("The length of the string is " ++ (show len))
-- reportResult (Left e) = putStrLn ("Length calculation failed with error: " ++ (show e))
--
