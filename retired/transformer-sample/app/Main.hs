module Main where

import Control.Applicative

data User = User deriving Show

data MaybeIO a = MaybeIO { runMaybeIO :: IO (Maybe a) }

instance Functor MaybeIO where
    fmap f (MaybeIO m) = MaybeIO $ (fmap.fmap) f m

instance Applicative MaybeIO where
    pure = MaybeIO . pure . Just
    MaybeIO f <*> MaybeIO m = MaybeIO $ liftA2 (<*>) f m

instance Monad MaybeIO where
    return = pure
    MaybeIO m >>= f = MaybeIO $ m >>= \x -> case x of
        Nothing -> return $ Nothing
        Just val -> runMaybeIO $ f val

findById :: Int -> IO (Maybe User)
findById 1 = return $ Just User
findById _ = return Nothing


smartFindUsers :: Int -> Int -> MaybeIO (User, User)
smartFindUsers x y = do
    user1 <- MaybeIO $ findById x
    user2 <- MaybeIO $ findById y
    return (user1, user2)

main = do
    result <- runMaybeIO (smartFindUsers 1 1)
    print result
    return ()
