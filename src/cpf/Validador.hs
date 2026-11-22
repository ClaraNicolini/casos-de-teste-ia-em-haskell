module Cpf.Validador
  ( limparCpf
  , calcularDigitos
  , todosIguais
  , validarCpf
  ) where

import Data.Char (digitToInt, isDigit)

limparCpf :: String -> [Int]
limparCpf = map digitToInt . filter isDigit

calcularDigitos :: [Int] -> (Int, Int)
calcularDigitos base9 = (d1, d2)
  where
    calcDigito pesos nums =
      let resto = sum (zipWith (*) pesos nums) `mod` 11
       in if resto < 2 then 0 else 11 - resto
    d1 = calcDigito [10, 9 .. 2] base9
    d2 = calcDigito [11, 10 .. 2] (base9 ++ [d1])

todosIguais :: [Int] -> Bool
todosIguais xs = all (== head xs) xs

validarCpf :: String -> Bool
validarCpf entrada =
  length digitos == 11
    && not (todosIguais digitos)
    && take 9 digitos ++ [d1, d2] == digitos
  where
    digitos = limparCpf entrada
    (d1, d2) = calcularDigitos (take 9 digitos)
