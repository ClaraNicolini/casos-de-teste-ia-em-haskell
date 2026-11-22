module Main where

import Cpf.Validador (validarCpf)
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Modelo de Verificacao de CPF" $ do
    it "aceita um CPF valido conhecido" $
      validarCpf "52998224725" `shouldBe` True

    it "rejeita CPFs com todos os digitos iguais" $
      validarCpf "11111111111" `shouldBe` False

    it "rejeita CPF com digito verificador alterado" $
      validarCpf "52998224726" `shouldBe` False
