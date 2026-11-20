module Main where

import Cpf.Validador (calcularDigitos, limparCpf, todosIguais)

main :: IO ()
main = mapM_ checar
  [ "52998224725"
  , "11111111111"
  , "52998224726"
  ]
  where
    checar cpf = do
      let digitos = limparCpf cpf
          (d1, d2) = calcularDigitos (take 9 digitos)
          ok =
            length digitos == 11
              && not (todosIguais digitos)
              && drop 9 digitos == [d1, d2]
      putStrLn cpf
      print ok
