module Main where

-- 
-- XIdentity
--
data XIdentity a = XIdentity a deriving (Eq, Show)

instance Functor XIdentity where
    fmap f (XIdentity a) = XIdentity (f a)

instance Applicative XIdentity where
    pure = XIdentity
    (<*>) (XIdentity f) (XIdentity v) = XIdentity (f v)

instance Monad XIdentity where
    return = pure
    (XIdentity a) >>= f = f a

--
-- XMaybe
--
data XMaybe a = XJust a | XNothing deriving (Eq, Show)

instance Functor XMaybe where
    fmap f XNothing = XNothing
    fmap f (XJust a) = XJust $ f a

instance Applicative XMaybe where
    pure = XJust
    (<*>) _ XNothing = XNothing
    (<*>) (XJust f) (XJust a) = XJust (f a)

instance Monad XMaybe where
    return = pure
    (>>=) XNothing _ = XNothing 
    (>>=) (XJust a) f = f a

--
-- XEither
--
data XEither a b = XLeft a | XRight b deriving (Eq, Show)

instance Functor (XEither a) where
    fmap f (XLeft a) = XLeft a  
    fmap f (XRight b) = XRight $ f b

instance Applicative (XEither a) where
    pure = XRight
    (<*>) _ (XLeft a) = XLeft a
    (<*>) (XRight f) (XRight a) = XRight $ f a 

instance Monad (XEither a) where
    return = pure
    (>>=) (XLeft a) _ = XLeft a
    (>>=) (XRight a) f = f a

--
-- XList
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
data XReader e a = XReader { runXReader :: e -> a }

instance Functor (XReader e) where
    fmap f (XReader g) = XReader (f . g)

instance Applicative (XReader e) where
    pure = XReader . const 
    (<*>) (XReader f) (XReader g) = XReader (\e -> f e (g e)) 

instance Monad (XReader e) where
    return = pure
    (XReader f) >>= g = XReader (\e -> runXReader (g (f e)) e) 

--
-- State
--
data XState s a = XState { runXState :: s -> (a, s) }

instance Functor (XState s) where
    --fmap f (XState m) = XState (\s -> let (a, _) = m s in (f a, s))
    fmap f (XState m) = XState (\s -> (f (fst (m s)), s))

instance Applicative (XState e) where
    pure x = XState (\s -> (x, s))
    (<*>) (XState f) (XState m) = XState (\s -> ((fst (f s)) (fst (m s)), s)) 

instance Monad (XState e) where
    return = pure
    -- m a -> (a -> m b) -> m b 
    (XState h) >>= f = XState $ \s -> let (a, newState) = h s 
                                          (XState g) = f a
                                      in g newState

get :: XState Int Int
get = XState $ \s -> (s, s) 

put :: Int -> XState Int Int
put s = XState (\_ -> (s, s)) 

tick :: XState Int Int                                                                                                                              
tick = do 
    put 37
    n <- get
    return $ n + 1


tock :: XState Int Int
tock = (put 37) >>= (\_ -> get >>= (\n -> return (n + 1))) 


main = do
    putStrLn "\nXIdentity..."
    print $ fmap (+1) $ XIdentity 7
    print $ pure (+1) <*> XIdentity 3
    print $ identity >>= \x -> return $ x + 1

    putStrLn "\nXMaybe..."
    print $ fmap (+1) XNothing
    print $ fmap (+1) (XJust 1)
    print $ pure (+1) <*> XNothing
    print $ pure (+1) <*> XJust 1
    print $ none >>= \x -> return $ x + 1
    print $ some >>= \x -> return $ x + 1

    putStrLn "\nXEither..."
    print $ fmap (+1) failure
    print $ pure (+1) <*> failure
    print $ pure (+1) <*> success
    print $ failure >>= \x -> return $ x + 1
    print $ success >>= \x -> return $ x + 1

    putStrLn "\nXLIST..."
    print $ fmap (+1) Nil
    print $ fmap (+1) xlist
    print $ pure (+1) <*> Nil
    print $ pure (+1) <*> xlist
    print $ [] >>= \x -> return $ x + 1
    print $ [1,2,3] >>= \x -> return $ x + 1
    print $ Nil >>= \x -> return $ x + 1
    print $ xlist >>= \x -> return $ x + 1

    putStrLn "\nXWRITER..."
    print $ fmap (+1) writer
    print $ pure (+1) <*> writer
    print $ writer >>= \x -> return $ x + 1

    putStrLn "\nXREADER..."
    print $ (runXReader (fmap (+42) foo)) [1,2,3]
    print $ (runXReader (pure (+42) <*> foo)) [1,2,3] 
    print $ runXReader (XReader length) [1,2,3] 
    print $ runXReader foo [1,2,3] 
    print $ runXReader bar 1
    print $ runXReader baz [1,2,3]

    putStrLn "\nXState..."
    print $ (runXState tick) 4
    print $ (runXState tock) 4
    print $ (runXState (qux >>= (\x -> return x))) 42
    print $ (runXState ((pure id) <*> qux)) 42
    print $ (runXState (fmap id qux)) 42
    print $ (runXState (fmap (+3) qux)) 42
    print $ (runXState qux) 42 
    return ()
  where 
    identity = XIdentity 41
    none = XNothing
    some = XJust 41
    failure = XLeft "xerror message" :: XEither String Int
    success = XRight 41 :: XEither String Int
    xlist = Cons 1 (Cons 2 (Cons 3 Nil))
    writer = XWriter{ xrunWriter = ( 0, []) } :: XWriter [Int] Int
    qux = XState (\x -> (0, x))


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
