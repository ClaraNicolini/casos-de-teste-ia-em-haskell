module Main where

import Cpf.Validador (validarCpf)
import Gen.Algoritmo (evoluirVarios, fitness)
import System.Random (newStdGen)

main :: IO ()
main = do
  gen <- newStdGen
  let (validos, todos, _) = evoluirVarios 10 gen
  putStrLn "=== Casos gerados pelo AG ==="
  mapM_ mostrarTodos (zip [1 :: Int ..] todos)
  putStrLn ""
  putStrLn "=== Filtrados pelo modelo (validos) ==="
  mapM_ mostrarValido (zip [1 :: Int ..] validos)
  where
    mostrarTodos (i, cpf) =
      putStrLn $
        show i
          ++ ") "
          ++ cpf
          ++ " | fitness="
          ++ show (fitness cpf)
          ++ " | modelo="
          ++ show (validarCpf cpf)

    mostrarValido (i, (cpf, geracoes)) = do
      putStrLn $ show i ++ ") " ++ cpf
      putStrLn $ "   geracoes: " ++ show geracoes
      putStrLn $ "   valido:   " ++ show (validarCpf cpf)
