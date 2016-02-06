module Main where

data List a = EmptyList | Cons a (List a)


instance (Show a) => Show (List a) where
    show EmptyList   = "[]"
    show (Cons a b)  = "[" ++ show a ++ (show' b) ++ "]"
        where show' EmptyList           = ""
              show' (Cons a' EmptyList) = ", " ++ show a'
              show' (Cons a' b')        = ", " ++ show a' ++ show' b'

main = do 
    print $ (EmptyList :: List Int)
    print $ Cons 1 EmptyList 
    print $ Cons 1 (Cons 2 EmptyList)
