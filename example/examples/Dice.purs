--module Main where
module Dice where

import Prelude

import Effect.Class (liftEffect)
import Effect.Aff (Aff)
import Effect (Effect)
import Effect.Random as Random
import Data.Tuple (Tuple(..))
import Data.Maybe (Maybe(..))

import Snubbdom (
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

type Model = Maybe Int

init :: Model
init = Nothing

data Msg = Roll | Update Int

update :: Model -> Msg -> Tuple Model (Array (Aff Msg))
update model = case _ of
  Roll -> model :> [
    Update <$> liftEffect (Random.randomInt 1 6)
  ]
  Update int -> Just int :> []

view :: forall a. Model -> H.Element a Msg
view model = H.main [H.id "main"] [
  H.text (show model),
  H.button [H.onClick Roll] [H.text "Roll"]
]

main :: Effect Unit
main =
  H.mount "main" {
    init: init :> [],
    update: update,
    view
  }
