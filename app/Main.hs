module Main where

import Cpf.Validador (validarCpf)
import Gen.Algoritmo (evoluirVarios, fitness)
import System.Environment (getArgs)
import System.Random (mkStdGen, randomIO)
import Text.Read (readMaybe)

data Param = Param { paramSeed :: Int, paramQte :: Int}

qtePadrao :: Int
qtePadrao = 10

-- para o IO "data Maybe a = Nothing | Just a"
obterParam :: IO Param -- Podia ser tupla (Int, Int) tambem
obterParam = do
  args <- getArgs
  seed <- case args of -- Expr. IO Int aqui dai sep.
        (s : _) | Just n <- readMaybe s -> return n -- if readMaybe(q) == Just n && n > 0 then n else ...
        _ -> randomIO
  let qte = case args of
        (_ : q : _) | Just n <- readMaybe q, n > 0 -> n
        _ -> qtePadrao
  return (Param seed qte)

main :: IO ()
main = do
  Param seed qte <- obterParam
  let gen = mkStdGen seed
  let (validos, todos, _) = evoluirVarios qte gen
  putStrLn "=== Casos gerados pelo AG ==="
  mapM_ mostrarTodos (zip [1 :: Int ..] todos)
  putStrLn ""
  putStrLn "=== Filtrados pelo modelo (validos) ==="
  mapM_ mostrarValido (zip [1 :: Int ..] validos)
  putStrLn $ "Seed: " ++ show seed ++ " | Quantidade: " ++ show qte 
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
