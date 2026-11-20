module Main where

import Cpf.Validador (calcularDigitos, limparCpf)

main :: IO ()
main = do
  let digitos = limparCpf "529.982.247-25"
      base9 = take 9 digitos
      (d1, d2) = calcularDigitos base9
  print digitos
  print (d1, d2)
  print (drop 9 digitos)
