module Main where

import Cpf.Validador (limparCpf, todosIguais)

main :: IO ()
main = mapM_ mostrar
  [ "52998224725"
  , "11111111111"
  , "00000000000"
  ]
  where
    mostrar cpf = do
      let digitos = limparCpf cpf
      putStrLn cpf
      print (todosIguais digitos)
