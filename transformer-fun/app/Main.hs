-- Signalling Errors
-- https://github.com/kqr/gists/blob/master/articles/gentle-introduction-monad-transformers.md

{-# LANGUAGE OverloadedStrings #-}


module Main where

import Data.Text
import qualified Data.Text.IO as T
import Data.Map as Map
import Control.Applicative

users :: Map Text Text
users = Map.fromList [("example.com", "qwerty123"), ("localhost", "password")]

data Point a b = Point{pointX :: a, pointY :: b} deriving Show

data EitherIO e a = EitherIO { runEitherIO :: IO (Either e a) }

instance Functor (EitherIO e) where
    fmap f = EitherIO . fmap (fmap f) . runEitherIO

instance Applicative (EitherIO e) where
    pure    = EitherIO . return . Right
    f <*> x = EitherIO $ liftA2 (<*>) (runEitherIO f) (runEitherIO x)

instance Monad (EitherIO e) where
    return  = pure
    x >>= f = EitherIO $ runEitherIO x >>= either (return . Left) (runEitherIO . f)

liftEither :: Either e a -> EitherIO e a
liftEither x = EitherIO (return x)

liftIO :: IO a -> EitherIO e a
liftIO x = EitherIO (fmap Right x)

data LoginError
    = InvalidEmail 
    | NoSuchUser
    | WrongPassword
    deriving Show

printResult :: Either LoginError Text -> IO ()
printResult res =
  T.putStrLn $ case res of
    Right token        -> append "Logged in with token: " token
    Left InvalidEmail  -> "Invalid email address entered."
    Left NoSuchUser    -> "No user with that email exists."
    Left WrongPassword -> "Wrong password."

getDomain :: Text -> Either LoginError Text
getDomain email =
  case splitOn "@" email of
      [name, domain] -> Right domain
      _              -> Left InvalidEmail

getToken :: EitherIO LoginError Text
getToken = do
  liftIO (T.putStrLn "Enter email address: ")
  input <- liftIO T.getLine
  EitherIO (return (getDomain input))

userLogin :: EitherIO LoginError Text
userLogin = do
  token      <- getToken
  userpw     <- maybe (liftEither (Left NoSuchUser))
                  return (Map.lookup token users)
  password   <- liftIO (T.putStrLn "Enter your password:" >> T.getLine)

  if userpw == password
     then return token
     else liftEither (Left WrongPassword)


foo :: IO (Either LoginError Text)
foo = return (Right "bingo")

bar :: EitherIO LoginError Text
bar = EitherIO foo

baz :: EitherIO LoginError Text
baz = return "bingo"

main = do 
    q <- runEitherIO getToken
    print q
    return ()
