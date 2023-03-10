module Main where
--module Counters where

import Prelude

import Effect.Console (log)
import Data.Tuple (Tuple(..))
import Data.Array as Array
import Data.Maybe as Maybe
import Effect (Effect)
import Counter as Counter

import Snabbare (
  Element,
  div,
  main,
  text, 
  id,
  button,
  onClick,
  mount
  ) as H

infixr 6 Tuple as :>

type Model = Array (Counter.Model)

init :: Model
init = []

data Msg = Add | Remove Int | CounterMsg Int Counter.Msg

update :: Model -> Msg -> Model
update model = case _ of
  Add ->
    Array.snoc model Counter.init
  Remove index ->
    Array.deleteAt index model # Maybe.fromMaybe model
  CounterMsg index msg ->
    Array.modifyAt index (\model' -> Counter.update model' msg) model # Maybe.fromMaybe model

view :: forall a. Model -> H.Element a Msg
view model = H.main [H.id "main"] [
  H.button [H.onClick Add] [H.text "Add"],
  H.div [] $ Array.mapWithIndex viewCounter model
]
  where
    --viewCounter index model' = H.div [H.style "display" "flex"] [
    viewCounter index model' = H.div [] [
      (CounterMsg index) <$> Counter.view model',
      H.button [H.onClick (Remove index)] [H.text "Remove"]
    ]

main :: Effect Unit
main = do
  H.mount "main" {
    init: init :> [],
    update: \msg model -> update msg model :> [],
    view
  }

