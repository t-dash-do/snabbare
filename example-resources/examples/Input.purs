module Main where
--module Input where 

import Prelude

import Effect (Effect)
import Data.Maybe (Maybe(..), fromMaybe)

import SimpleFramework as F

import Snubbdom (
  Element,
  main,
  div,
  text,
  input, 
  id,
  type',
  value,
  onClick,
  onInput,
  button
  ) as S

import Data.Tuple (Tuple(..))
infixr 6 Tuple as :>

type Model = 
    { name :: Maybe String 
    , keep :: Boolean
    }

init :: Model 
init = {name: Nothing, keep: false} 


data Msg = Keep | Edit | Update String

update :: Model -> Msg -> Model
update model = case _ of
  Update s -> model {name = Just s} 
  Keep -> model {keep = true}
  Edit -> model {keep = false}

view :: forall a. Model -> S.Element a Msg
view model = S.main [S.id "main"] 
    if model.keep 
        then 
        [ S.text (fromMaybe "name didnt stay" model.name)
        , S.button [S.onClick Edit] [S.text "edit"]
        ]
        else 
        [ S.input [S.type' "text", S.onInput (\s -> Update s), S.value $ fromMaybe "" model.name] []
        , S.button [S.onClick Keep] [S.text $ "keep " <> fromMaybe "noName" model.name]
        ]
    

main :: Effect Unit
main = do
  F.mount "main" {
    init: init, --:> [], 
    update: \model msg -> update model msg, --:> [], 
    view
  }
