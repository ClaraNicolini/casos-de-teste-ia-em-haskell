module Main where

import Cpf.Validador (validarCpf)

main :: IO ()
main = mapM_ (print . validarCpf)
  [ "52998224725"
  , "529.982.247-25"
  , "11111111111"
  , "52998224726"
  , "123"
  ]
