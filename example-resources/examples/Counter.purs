--module Counter where
module Main where

import Prelude

import Effect (Effect)
import Data.Tuple (Tuple(..))

import Framework as F

import Snubbdom (
  Element,
  div,
  main,
  text, 
  id,
  button,
  onClick
  ) as H

infixr 6 Tuple as :>

type Model = Int

init :: Model
init = 0

data Msg = Increment | Decrement

update :: Model -> Msg -> Model
update model = case _ of
  Increment -> model + 1
  Decrement -> model - 1

view :: forall a. Model -> H.Element a Msg
view model = H.main [H.id "main"] [
  H.button [H.onClick Decrement] [H.text "-"],
  H.text (show model),
  H.button [H.onClick Increment] [H.text "+"]
]

main :: Effect Unit
main = do
  F.mount "main" {
    init: init :> [],
    update: \msg model -> update msg model :> [],
    view
  }
