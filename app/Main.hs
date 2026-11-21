module Main where

import Cpf.Validador (validarCpf)
import Gen.Algoritmo (fitness, gerarIndividuo)
import System.Random (newStdGen)

main :: IO ()
main = do
  gen <- newStdGen
  let (individuo, _) = gerarIndividuo gen
  putStrLn individuo
  print (fitness individuo)
  print (validarCpf individuo)
