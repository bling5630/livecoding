module Main where

import Options.Applicative

type Quantity = Integer

type Pizza = String
type Toppings = String
type Size = Integer

type Burger = String
type Pickles = Bool

data Command
    = PizzaCommand Pizza Size Toppings
    | BurgerCommand Burger Pickles

data Options = Options
    { quantity   :: Quantity
    , subCommand :: Command
    }

parsePizza :: Parser Command
parsePizza = PizzaCommand <$> argument str (metavar "PIZZA")
                          <*> option auto (long "size" <> value 12 <> metavar "SIZE" <> help "size of pizza") 
                          <*> strOption (long "toppings" <> metavar "TOPPINGS" <> help "toppings for pizza")


parseBurger :: Parser Command
parseBurger = BurgerCommand <$> argument str (metavar "BURGER")
                            <*> switch (long "pickles" <> help "include pickles")

parseCommand :: Parser Command
parseCommand = subparser $
    command "pizza" (parsePizza `withInfo` "order a pizza") <>
    command "burger" (parseBurger `withInfo` "order a burger")

parseOptions :: Parser Options
parseOptions = Options <$> option auto (long "quantity" <> value 1 <> metavar "QUANTITY" <> help "quantity of item ordered") 
                       <*> parseCommand 

withInfo :: Parser a -> String -> ParserInfo a
withInfo opts desc = info (helper <*> opts) $ progDesc desc


run :: Options -> IO ()
run (Options quantity (PizzaCommand pizza size toppings)) = putStrLn $ "pizza " ++ pizza ++ " " ++ show size ++ " toppings: " ++ toppings ++ " quantity: " ++ show quantity
run (Options quantity (BurgerCommand burger pickles)) = putStrLn $ "burger " ++ burger ++ " " ++ show pickles ++ " quantity: " ++ show quantity
run _ = return ()


main :: IO ()
main = execParser opts >>= run
  where
   opts = info (helper <*> parseOptions)
               (progDesc "This-is-the-program-description")
