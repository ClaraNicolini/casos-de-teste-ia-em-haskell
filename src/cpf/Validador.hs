module Cpf.Validador
  ( limparCpf
  ) where

import Data.Char (digitToInt, isDigit)

limparCpf :: String -> [Int]
limparCpf = map digitToInt . filter isDigit
