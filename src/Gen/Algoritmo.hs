module Gen.Algoritmo
  ( fitness
  , gerarIndividuo
  ) where

import Cpf.Validador (calcularDigitos, limparCpf, todosIguais)
import Data.Char (intToDigit)
import System.Random (StdGen, randomR)

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

gerarIndividuo :: StdGen -> (Individuo, StdGen)
gerarIndividuo gerador = go 11 "" gerador
  where
    go 0 acc g = (acc, g)
    go n acc g =
      let (d, g') = randomR (0, 9) g
       in go (n - 1) (intToDigit d : acc) g'
