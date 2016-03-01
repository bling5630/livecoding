module Main where

import Data.Either




-- 
-- XIdentity
--
data XIdentity a = XIdentity a deriving (Eq, Show)

instance Functor XIdentity where
    -- (a -> b) -> f a -> f b 
    fmap f (XIdentity a) = XIdentity (f a)

instance Applicative XIdentity where
    pure a = XIdentity a
    -- f (a -> b) -> f a -> f b
    (<*>) (XIdentity f) (XIdentity v) = XIdentity (f v)

instance Monad XIdentity where
    -- a -> m a
    return = pure
    -- m a -> (a -> m b) -> m b
    (XIdentity a) >>= f = f a


--
-- XMaybe
--
data XMaybe a = XJust a | XNothing deriving (Eq, Show)

instance Functor XMaybe where
    -- (a -> b) -> f a -> f b 
    fmap f XNothing = XNothing
    fmap f (XJust a) = XJust $ f a

instance Applicative XMaybe where
    -- a -> m a
    pure  a = XJust a
    -- f (a -> b) -> f a -> f b 
    (<*>) _ XNothing = XNothing
    (<*>) (XJust f) (XJust a) = XJust (f a)

instance Monad XMaybe where
    -- a -> m a
    return = pure
    -- m a -> (a -> m b) -> m b
    (>>=) XNothing _ = XNothing 
    (>>=) (XJust a) f = f a

--
-- XEither
--
data XEither a b = XLeft a | XRight b deriving (Eq, Show)

instance Functor (XEither a) where
    -- (a -> b) -> f a -> f b
    fmap f (XLeft a) = XLeft a  
    fmap f (XRight b) = XRight $ f b

instance Applicative (XEither a) where
    -- a -> m a
    pure a = XRight a
    -- f (a -> b) -> f a -> f b
    (<*>) _ (XLeft a) = XLeft a
    (<*>) (XRight f) (XRight a) = XRight $ f a 

instance Monad (XEither a) where
    -- a -> m a
    return = pure
    -- m a -> (a -> m b) -> m b
    (>>=) (XLeft a) _ = XLeft a
    (>>=) (XRight a) f = f a

--
-- XList
--
data XList a = XEmpty | XCons a (XList a) deriving (Eq, Show)

instance Functor XList where
    -- (a -> b) -> f a -> f b
    fmap _ XEmpty = XEmpty
    fmap f (XCons a as) = XCons (f a) (fmap f as) 

instance Applicative XList where
    -- a -> m a
    pure a = XCons a XEmpty
    -- f (a -> b) -> f a -> f b
    (<*>) _ XEmpty = XEmpty
    (<*>) (XCons f _) (XCons a as) = XCons (f a) (fmap f as)

instance Monad XList where
    -- a -> m a
    return = pure
    -- m a -> (a -> m b) -> m b
    (>>=) XEmpty _ = XEmpty
    --(>>=) (XCons a as) f = XCons (f a) (fmap f as)

-- XWriter
-- XReader
-- XState
--


main = do
    print $ fmap (+1) $ XIdentity 7
    print $ pure ((+1)) <*> XIdentity 3
    print $ xidentity >>= \x -> return $ x + 1
    --
    print $ fmap (+1) (XNothing)
    print $ fmap (+1) (XJust 1)
    print $ pure ((+1)) <*> XNothing 
    print $ pure ((+1)) <*> XJust 1
    print $ xmaybe0 >>= \x -> return $ x + 1
    print $ xmaybe1 >>= \x -> return $ x + 1
    --
    print $ fmap (+1) xeitherl 
    print $ fmap (+1) eitherr 
    print $ pure ((+1)) <*> xeitherl 
    print $ pure ((+1)) <*> xeitherr 
    print $ xeitherl >>= \x -> return $ x + 1 
    print $ xeitherr >>= \x -> return $ x + 1 
    --
    print $ fmap (+1) XEmpty
    print $ fmap (+1) xlist 
    print $ pure (+1) <*> XEmpty
    print $ pure (+1) <*> xlist

    print $ [] >>= \x -> return $ x + 1
    print $ [1,2,3] >>= \x -> return $ x + 1

    print $ XEmpty >>= \x -> return $ x + 1

  where xidentity = XIdentity 41
        xmaybe0 = XNothing
        xmaybe1 = XJust 41
        eitherl = Left "error message"
        eitherr = Right 41 :: Either String Int 
        xeitherl = XLeft "xerror message" :: XEither String Int
        xeitherr = XRight 41 :: XEither String Int
        xlist = XCons 1 (XCons 2 (XCons 3 XEmpty))

