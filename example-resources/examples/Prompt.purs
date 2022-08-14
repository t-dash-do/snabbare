module Main where
--module Prompt where

import Prelude

import Effect.Aff (Aff)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Web.HTML as HTML
import Web.HTML.Window as Window
import Effect.Class (liftEffect)
import Data.Tuple (Tuple(..))

import Snubbdom (
  Element,
  Update,
  View,
  Init,
  div,
  main,
  text, 
  id,
  button,
  onClick,
  mount
  ) as H

infixr 6 Tuple as :>

type Model = { name :: Maybe String }

prompt :: Aff Msg
prompt = do
  window <- liftEffect HTML.window
  name <- liftEffect $ Window.prompt "What's your name?" window
  pure $ Update name

init :: H.Init Model Msg
init = {name: Nothing} :> [prompt]

data Msg = Prompt | Update (Maybe String)

update :: H.Update Model Msg
update model = case _ of
  Prompt ->
    model :> [prompt]
  Update name ->
    model { name = name } :> []

view :: forall a. H.View Model a Msg
view model = H.main [] [
  H.button [H.onClick Prompt] [H.text "Hello"],
  H.div [] [H.text $ "Hello, " <> show model.name <> "!"]
]

main :: Effect Unit
main = H.mount "main" { init, update, view }
