# Versão 10.1

## O que é esta versão
Versao aprimorada da anterior com escolha de seed para testes reprodutíveis e correções de documentação

## O que mudou em relação à anterior
- **v10** sem reprodutibilidade (seed fixa) para testes com o run

## Nome do commit
```
test(cpf): Adição de testes de propriedaded com QuickCheck e casos de CPF formatados
```

## Como rodar o Projeto

Preferível: ``cabal``

Mas, pode-se utilizar o ``ghci``, ``ghcrun`` (com ``isrc`` corretamente definido)

### Run ([Main.hs](app/Main.hs))
Pelo Cabal:

```sh
cabal run
```

Printa também a seed utilizada para reprodutibilidade.

Ou com seed:

```sh
cabal run projeto-haskell -- [seed]
```

### Testes ([Spec.hs](test/Spec.hs))

```sh
cabal test
```
