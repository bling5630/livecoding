module Main where



import Control.Monad.Prompt

data Foo = Foo
    { fooBar :: String
    , fooBaz :: Int
    , fooQux :: String
    } deriving Show


promptFoo :: Prompt String String Foo
promptFoo = Foo <$> prompt "bar"
                <*> fmap length (prompt "baz")
                <*> prompt "qux"

main = do
    result <- runPromptM promptFoo $ \str -> do putStrLn str; getLine
    print result
