module Gen.Algoritmo
  ( fitness
  ) where

import Cpf.Validador (calcularDigitos, limparCpf, todosIguais)

type Individuo = String

fitness :: Individuo -> Int
fitness ind =
  let digitos = limparCpf ind
      (d1, d2) = calcularDigitos (take 9 digitos)
   in if length digitos /= 11 || todosIguais digitos
        then 0
        else
          (if digitos !! 9 == d1 then 1 else 0)
            + (if digitos !! 10 == d2 then 1 else 0)
