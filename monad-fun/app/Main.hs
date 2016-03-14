module Main where

-- 
-- Identity
--
data Identity a = Identity a deriving (Eq, Show)

instance Functor Identity where
    fmap f (Identity a) = Identity (f a)

instance Applicative Identity where
    pure = Identity
    (<*>) (Identity f) (Identity v) = Identity (f v)

instance Monad Identity where
    return = pure
    (Identity a) >>= f = f a

--
-- Option (Maybe)
--
data Option a = Some a | None deriving (Eq, Show)

instance Functor Option where
    fmap f None = None
    fmap f (Some a) = Some $ f a

instance Applicative Option where
    pure = Some
    (<*>) _ None = None
    (<*>) (Some f) (Some a) = Some (f a)

instance Monad Option where
    return = pure
    (>>=) None _ = None 
    (>>=) (Some a) f = f a

--
-- Alternative (Either)
--
data Alternative a b = Failure a | Success b deriving (Eq, Show)

instance Functor (Alternative a) where
    fmap f (Failure a) = Failure a  
    fmap f (Success b) = Success $ f b

instance Applicative (Alternative a) where
    pure = Success
    (<*>) _ (Failure a) = Failure a
    (<*>) (Success f) (Success a) = Success $ f a 

instance Monad (Alternative a) where
    return = pure
    (>>=) (Failure a) _ = Failure a
    (>>=) (Success a) f = f a

--
-- XList (List)
--
data XList a = Nil | Cons a (XList a) deriving (Eq, Show)

xappend :: XList a -> XList a -> XList a
xappend Nil ys = ys
xappend (Cons x xs) ys = x `Cons` (xs `xappend` ys)

xconcat :: XList (XList a) -> XList a
xconcat Nil           = Nil
xconcat (Cons x Nil) = x
xconcat (Cons x xs) = x `xappend` xconcat xs

instance Functor XList where
    fmap _ Nil = Nil
    fmap f (Cons a as) = Cons (f a) (fmap f as) 

instance Applicative XList where
    pure a = Cons a Nil
    (<*>) _ Nil = Nil
    (<*>) (Cons f _) (Cons a as) = Cons (f a) (fmap f as)

instance Monad XList where
    return = pure
    xs >>= f = xconcat (fmap f xs)  

--
-- XWriter
--
data XWriter w a = XWriter { xrunWriter :: (a, w) } deriving (Eq, Show)

instance Functor (XWriter w) where
    fmap f XWriter{xrunWriter=(a, w)} = XWriter { xrunWriter=(f a, w) }

instance (Monoid w) => Applicative (XWriter w) where
    pure a = XWriter { xrunWriter=(a, mempty) }
    (<*>) XWriter{xrunWriter=(f, _)} XWriter{xrunWriter=(a, w)} = XWriter { xrunWriter=(f a, w) }

instance (Monoid w) => Monad (XWriter w) where
    return = pure
    (XWriter (x,v)) >>= f = let (XWriter (y, v')) = f x in XWriter (y, v `mappend` v')

--
-- Reader
--
--newtype ReaderT r m a = ReaderT { runReaderT :: r -> m a }

-- asks :: MonadReader r m  => (r -> a)-> m a
-- asks = reader

-- asks :: MonadReader r m  => (r -> a)-> m a

--instance Monad (XReader e) where  
--    return x = \_ -> x  
--    h >>= f = \w -> f (h w) w  

--instance Monad (XReader e) where
--    return = pure
--    h >>= f = \w -> f (h w) w  

data XReader e a = XReader { runXReader :: e -> a }

-- (a -> b) -> f a -> f b
-- (a -> b) -> (XReader e) a -> (XReader e) b
-- (a -> b) -> ((e ->) a) -> ((e ->) b)
-- 

-- instance Applicative Identity where
--     pure = Identity
--     (<*>) (Identity f) (Identity v) = Identity (f v)


-- asks f = XReader f
-- 
--foo :: XReader [Int] Int 
--foo = (asks length) >>= \len ->
--    return $ len + 42
--foo :: XReader [Int] Int

instance Functor (XReader e) where
    -- (a -> b) -> f a -> f b
    fmap f (XReader g) = XReader (f . g)

instance Applicative (XReader e) where
    pure = XReader . const 
    (<*>) (XReader f) (XReader g) = XReader (\e -> f e (g e)) 

instance Monad (XReader e) where
    return = pure
    (XReader f) >>= g = XReader (\e -> runXReader (g (f e)) e) 

foo :: XReader [a] Int
foo = XReader (length)


bar :: XReader Integer Integer
bar = do
  g <- XReader (+ 3)
  f <- XReader (+ 4)
  pure (f + g)

baz :: XReader [Int] Int
baz = do
  g <- XReader length 
  pure (g + 42)

main = do
    print $ (runXReader (XReader (length))) [1,2,3] 
    print $ (runXReader foo) [1,2,3] 
    print $ runXReader foo [1,2,3]
    print $ (runXReader (fmap (+42) foo)) [1,2,3]
    print $ (runXReader (pure (+42) <*> foo)) [1,2,3] 
    print $ runXReader bar 1
    print $ runXReader baz [1,2,3]
    return ()

--     print $ fmap (+1) $ Identity 7
--     print $ pure (+1) <*> Identity 3
--     print $ identity >>= \x -> return $ x + 1
--     --
--     print $ fmap (+1) None
--     print $ fmap (+1) (Some 1)
--     print $ pure (+1) <*> None
--     print $ pure (+1) <*> Some 1
--     print $ none >>= \x -> return $ x + 1
--     print $ some >>= \x -> return $ x + 1
--     --
--     print $ fmap (+1) failure
--     print $ pure (+1) <*> failure
--     print $ pure (+1) <*> success
--     print $ failure >>= \x -> return $ x + 1
--     print $ success >>= \x -> return $ x + 1
--     --
--     print $ fmap (+1) Nil
--     print $ fmap (+1) xlist
--     print $ pure (+1) <*> Nil
--     print $ pure (+1) <*> xlist
--   
--     print $ [] >>= \x -> return $ x + 1
--     print $ [1,2,3] >>= \x -> return $ x + 1
--   
--     print $ Nil >>= \x -> return $ x + 1
--     print $ xlist >>= \x -> return $ x + 1
--     putStrLn "--\n-- writer\n--"
--     print $ fmap (+1) writer
--     print $ pure (+1) <*> writer
--     print $ writer >>= \x -> return $ x + 1
--   where identity = Identity 41
--         none = None
--         some = Some 41
--         failure = Failure "xerror message" :: Alternative String Int
--         success = Success 41 :: Alternative String Int
--         xlist = Cons 1 (Cons 2 (Cons 3 Nil))
--         writer = XWriter{ xrunWriter = ( 0, []) } :: XWriter [Int] Int

