module Main where
--module Inputs where


import Prelude

import Data.Array as Array
import Data.Maybe as Maybe
import Effect (Effect)

import Snabbare (
  Element,
  div,
  main,
  text, 
  id,
  button,
  onClick
  ) as S

import SimpleFramework as F
import Input as Input

import Data.Tuple (Tuple(..))
infixr 6 Tuple as :>

type Model = Array (Input.Model)

init :: Model
init = []

data Msg = Add | Remove Int | CounterMsg Int Input.Msg

update :: Model -> Msg -> Model
update model = case _ of
  Add ->
    Array.snoc model Input.init
  Remove index ->
    Maybe.fromMaybe model $ Array.deleteAt index model 
  CounterMsg index msg ->
    Array.modifyAt index (\model' -> Input.update model' msg) model # Maybe.fromMaybe model

view :: forall a. Model -> S.Element a Msg
view model = S.main [S.id "main"] [
    S.button [S.onClick Add] [S.text "Add"], 
    S.div [] $ Array.mapWithIndex viewCounter model] 
    where 
      viewCounter index model' = 
          S.div [] 
          [ (CounterMsg index) <$> Input.view model'
          , S.button [S.onClick (Remove index)] [S.text $ "Remove" <> show index <> Maybe.fromMaybe "noname" model'.name]
          ]

main :: Effect Unit
main = do
  F.mount "main" {
    init: init, --:> [],
    update: \msg model -> update msg model, --:> [], 
    view
  }
