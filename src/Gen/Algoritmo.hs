module Gen.Algoritmo
  ( fitness
  , evoluirCpf
  , evoluirVarios
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

mutar :: Individuo -> StdGen -> (Individuo, StdGen)
mutar ind g =
  let (pos, g1) = randomR (0, 10) g
      (novoDig, g2) = randomR (0, 9) g1
      novoInd = take pos ind ++ [intToDigit novoDig] ++ drop (pos + 1) ind
   in (novoInd, g2)

evoluirCpf :: StdGen -> (Individuo, Int, [Individuo], StdGen)
evoluirCpf genInicial =
  let (primeiro, g1) = gerarIndividuo genInicial
   in loop primeiro 1 [primeiro] g1
  where
    loop atual geracao hist g
      | fitness atual == 2 = (atual, geracao, reverse hist, g)
      | otherwise =
          let (candidato, g') = mutar atual g
              melhor =
                if fitness candidato >= fitness atual
                  then candidato
                  else atual
           in loop melhor (geracao + 1) (candidato : hist) g'

evoluirVarios :: Int -> StdGen -> ([(Individuo, Int)], [Individuo], StdGen)
evoluirVarios 0 g = ([], [], g)
evoluirVarios n g =
  let (cpf, geracoes, hist, g') = evoluirCpf g
      (validos, todos, g'') = evoluirVarios (n - 1) g'
   in ((cpf, geracoes) : validos, hist ++ todos, g'')
