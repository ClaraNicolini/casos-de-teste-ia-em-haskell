module Main where

import Cpf.Validador (limparCpf)

main :: IO ()
main = do
  let exemplos =
        [ "52998224725"
        , "529.982.247-25"
        , "111.111.111-11"
        , "abc529def982ghi247jk25"
        ]
  mapM_ mostrar exemplos
  where
    mostrar cpf = do
      let digitos = limparCpf cpf
      putStrLn cpf
      print digitos
      print (length digitos)
