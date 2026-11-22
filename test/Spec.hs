module Main where

import Cpf.Validador (calcularDigitos, validarCpf)
import Data.Char (intToDigit)
import Test.HUnit
  (Test (..), assertBool, assertEqual, runTestTT)
import Test.Hspec
import Test.QuickCheck

testesHUnit :: Test
testesHUnit =
  TestList
    [ TestLabel "valido" $
        TestCase (assertEqual "" True (validarCpf "52998224725"))
    , TestLabel "iguais" $
        TestCase (assertBool "" (not (validarCpf "11111111111")))
    , TestLabel "dv" $
        TestCase (assertEqual "" False (validarCpf "52998224726"))
    , TestLabel "formatado" $
        TestCase (assertEqual "" True (validarCpf "529.982.247-25"))
    ]

genCpfValido :: Gen String
genCpfValido = do
  base9 <- vectorOf 9 (choose (0, 9))
  if all (== head base9) base9
    then genCpfValido
    else do
      let (d1, d2) = calcularDigitos base9
      return $ map intToDigit (base9 ++ [d1, d2])

main :: IO ()
main = do
  hspec specHspec
  counts <- runTestTT testesHUnit
  print counts

specHspec :: Spec
specHspec = do
  describe "Modelo de Verificacao de CPF" $ do
    it "aceita um CPF valido conhecido" $
      validarCpf "52998224725" `shouldBe` True

    it "rejeita CPFs com todos os digitos iguais" $
      validarCpf "11111111111" `shouldBe` False

    it "rejeita CPF com digito verificador alterado" $
      validarCpf "52998224726" `shouldBe` False

    it "aceita CPF valido com formatacao" $
      validarCpf "529.982.247-25" `shouldBe` True

    it "propriedade QuickCheck: todo CPF construido pela regra e valido" $
      forAll genCpfValido validarCpf
