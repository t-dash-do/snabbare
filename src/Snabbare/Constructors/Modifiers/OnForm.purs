module Snabbare.OnForm where

import Prelude
import Web.Event.Event as Event

import Control.Alt ((<|>))
import Data.Maybe (Maybe(..), fromMaybe, maybe)
import Effect (Effect)
import Web.DOM.Node (Node)
import Web.DOM.Node as Node
import Web.Event.Event as Event
import Web.HTML.HTMLInputElement as HTMLInputElement
import Web.HTML.HTMLTextAreaElement as HTMLTextAreaElement

import Snabbare.ModifierLibrary (onForm, Modifier)


onSubmit :: forall msg. msg -> Modifier msg
onSubmit msg = onForm "submit" $ \event -> do
  Event.preventDefault event
  pure msg

onInput :: forall msg. (String -> msg) -> Modifier msg
onInput f = onForm "input" $ \event -> do

  value <- Event.target event 
    >>= Node.fromEventTarget 
    # \n -> getInputVal HTMLInputElement.fromNode HTMLInputElement.value n <|> getInputVal HTMLTextAreaElement.fromNode HTMLTextAreaElement.value n
    # fromMaybe (pure "")

  pure $ f value
  where
    getInputVal :: forall a.
      (Node -> Maybe a)
      -> (a -> Effect String)
      -> Maybe Node
      -> Maybe (Effect String)
    getInputVal fromNode getVal node =
      node >>= fromNode <#> getVal



