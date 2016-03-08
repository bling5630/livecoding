-- Signalling Errors
-- https://github.com/kqr/gists/blob/master/articles/gentle-introduction-monad-transformers.md
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module Main where

import Data.Text
import qualified Data.Text.IO as T
import Data.Map as Map
import Control.Applicative

users :: Map Text Text
users = Map.fromList [("example.com", "qwerty123"), ("localhost", "password")]

data ExceptT e m a = ExceptT { runExceptT :: m (Either e a) }

instance Functor m => Functor (ExceptT e m) where
  fmap f = ExceptT . fmap (fmap f) . runExceptT

instance Applicative m => Applicative (ExceptT e m) where
    pure    = ExceptT . pure . Right
    f <*> x = ExceptT $ liftA2 (<*>) (runExceptT f) (runExceptT x)

instance Monad m => Monad (ExceptT e m) where
    return  = pure
    x >>= f = ExceptT $ runExceptT x >>= either (return . Left) (runExceptT . f)

liftEither :: Monad m => Either e a -> ExceptT e m a
liftEither x = ExceptT (return x)

lift :: Monad m => m a -> ExceptT e m a
lift x = ExceptT (fmap Right x)

throwE :: Monad m => e -> ExceptT e m a
throwE x = liftEither (Left x)  

catchE :: Monad m => ExceptT e m a -> (e -> ExceptT c m a) -> ExceptT c m a
catchE throwing handler = ExceptT $ do
    x <- runExceptT throwing
    case x of
      Left failure -> runExceptT (handler failure)
      Right success -> return $ Right success

data LoginError
    = InvalidEmail 
    | NoSuchUser
    | WrongPassword
    deriving Show

loginDialogue :: ExceptT LoginError IO ()
loginDialogue = do
  let retry =  userLogin `catchE` wrongPasswordHandler
  token <- retry `catchE` printError
  lift $ T.putStrLn (append "Logged in with token: " token)

wrongPasswordHandler :: LoginError -> ExceptT LoginError IO Text
wrongPasswordHandler WrongPassword = do
  lift (T.putStrLn "Wrong password, one more chance.")
  userLogin
wrongPasswordHandler err = throwE err


printError :: LoginError -> ExceptT LoginError IO a
printError err = do
  lift . T.putStrLn $ case err of
    WrongPassword -> "Wrong password. No more chances."
    NoSuchUser -> "No user with that email exists."
    InvalidEmail -> "Invalid email address entered."
  throwE err

userLogin :: ExceptT LoginError IO Text
userLogin = do
  token <- getToken
  userpw <- maybe (liftEither (Left NoSuchUser)) return (Map.lookup token users)
  password <- lift (T.putStrLn "Enter your password:" >> T.getLine)
  if userpw == password
     then return token
     else throwE WrongPassword 

getToken :: ExceptT LoginError IO Text
getToken = do
  lift (T.putStrLn "Enter email address: ")
  input <- lift T.getLine
  ExceptT (return (getDomain input))

getDomain :: Text -> Either LoginError Text
getDomain email =
  case splitOn "@" email of
      [name, domain] -> Right domain
      _              -> Left InvalidEmail

main = do
    runExceptT loginDialogue
    return ()


-- {-# LANGUAGE OverloadedStrings #-}
-- {-# LANGUAGE AllowAmbiguousTypes #-}
-- 
-- module Main where
-- 
-- import Data.Text
-- import qualified Data.Text.IO as T
-- import Data.Map as Map
-- import Control.Applicative
-- 
-- users :: Map Text Text
-- users = Map.fromList [("example.com", "qwerty123"), ("localhost", "password")]
-- 
-- data ExceptIO e a = ExceptIO { runExceptIO :: IO (Either e a) }
-- 
-- instance Functor (ExceptIO e) where
--     fmap f = ExceptIO . fmap (fmap f) . runExceptIO
-- 
-- instance Applicative (ExceptIO e) where
--     pure    = ExceptIO . pure . Right
--     f <*> x = ExceptIO $ liftA2 (<*>) (runExceptIO f) (runExceptIO x)
-- 
-- instance Monad (ExceptIO e) where
--     return  = pure
--     x >>= f = ExceptIO $ runExceptIO x >>= either (return . Left) (runExceptIO . f)
-- 
-- liftEither :: Either e a -> ExceptIO e a
-- liftEither x = ExceptIO (return x)
-- 
-- liftIO :: IO a -> ExceptIO e a
-- liftIO x = ExceptIO (fmap Right x)
-- 
-- throwE :: e -> ExceptIO e a
-- throwE x = liftEither (Left x)  
-- 
-- catchE :: ExceptIO e a -> (e -> ExceptIO e a) -> ExceptIO e a
-- catchE throwing handler =
--   ExceptIO $ do
--     result <- runExceptIO throwing
--     case result of
--       Left failure -> runExceptIO (handler failure)
--       success      -> return success
-- 
-- 
-- data LoginError
-- 
--     = InvalidEmail 
--     | NoSuchUser
--     | WrongPassword
--     deriving Show
-- 
-- userLogin :: ExceptIO LoginError Text
-- userLogin = do
--   token <- getToken
--   userpw <- maybe (liftEither (Left NoSuchUser)) return (Map.lookup token users)
--   password <- liftIO (T.putStrLn "Enter your password:" >> T.getLine)
--   if userpw == password
--      then return token
--      else throwE WrongPassword 
-- 
-- 
-- loginDialogue :: ExceptIO LoginError ()
-- loginDialogue = do
--   let retry =  userLogin `catchE` wrongPasswordHandler
--   token     <- retry `catchE` printError
--   liftIO $ T.putStrLn (append "Logged in with token: " token)
-- 
-- wrongPasswordHandler :: LoginError -> ExceptIO LoginError Text
-- wrongPasswordHandler WrongPassword = do
--   liftIO (T.putStrLn "Wrong password, one more chance.")
--   userLogin
-- wrongPasswordHandler err = throwE err
-- 
-- printError :: LoginError -> ExceptIO LoginError a
-- printError err = do
--   liftIO . T.putStrLn $ case err of
--     WrongPassword -> "Wrong password. No more chances."
--     NoSuchUser -> "No user with that email exists."
--     InvalidEmail -> "Invalid email address entered."
--   throwE err
-- 
-- getToken :: ExceptIO LoginError Text
-- getToken = do
--   liftIO (T.putStrLn "Enter email address: ")
--   input <- liftIO T.getLine
--   ExceptIO (return (getDomain input))
-- 
-- 
-- getDomain :: Text -> Either LoginError Text
-- getDomain email =
--   case splitOn "@" email of
--       [name, domain] -> Right domain
--       _              -> Left InvalidEmail
-- 
-- 
-- main = do 
--     runExceptIO loginDialogue
--     return ()
