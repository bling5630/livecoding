module Main where

import Options.Applicative

data Options = Options
  { name     :: String
  , pizza    :: String 
  , quantity :: Integer 
  , quiet    :: Bool 
  }

sample :: Parser Options
sample = Options
  <$> argument str (metavar "NAME")
  <*> strOption (long "pizza" <> metavar "PIZZA" <> value "cheese" <> help "Target for the greeting")
  <*> option auto (long "quantity" <> value 1 <> metavar "QUANTITY" <> help "number of pizza") 
  <*> switch (long "quiet" <> help "Whether to be quiet")

run :: Options -> IO ()
run (Options name pizza quantity False) = putStrLn $ name ++ " likes " ++ pizza ++ " pizza x " ++ (show quantity)
run _ = return ()


main :: IO ()
main = execParser opts >>= run
  where
   opts = info (helper <*> sample)
               (progDesc "Print a greeting for NAME")
