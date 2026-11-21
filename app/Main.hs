module Main where

import Gen.Algoritmo (fitness)

main :: IO ()
main = mapM_ mostrar
  [ "52998224725"
  , "11111111111"
  , "52998224726"
  , "123"
  ]
  where
    mostrar cpf = do
      putStrLn cpf
      print (fitness cpf)
