module Main where

import Prelude

import Affjax as Affjax
import Affjax.ResponseFormat as ResponseFormat
import Data.Either (Either(..))
import Effect (Effect)
import Data.Tuple (Tuple(..))

import Framework as F

import Snabbare as H

infixr 6 Tuple as :>


type Model = {
  url :: String,
  result :: Result
}

data Result = NotFetched | Fetching | Ok String | Error String

derive instance eqResult :: Eq Result
instance showResult :: Show Result where
    show NotFetched = "not fetched"
    show Fetching = "fetching"
    show (Ok s) = "ok: " <> s
    show (Error s) = "error: " <> s

init :: H.Init Model Msg
init = {
  url: "https://httpbin.org/get",
  result: NotFetched
} :> []

data Msg = UpdateUrl String | Fetch | Fetched Result

update :: H.Update Model Msg
update model = case _ of
  UpdateUrl url ->
    model { url = url, result = NotFetched } :> []
  Fetch ->
    model { result = Fetching } :> [ do
      response <- Affjax.get ResponseFormat.string model.url
      pure $ case response of
        Left error -> Fetched $ Error $ Affjax.printError error
        Right ok -> Fetched $ Ok ok.body
    ]
  Fetched result ->
    model { result = result } :> []

view :: forall a. Model -> H.Element a Msg
view model = H.main [H.id "main"] [
  H.input [H.onInput UpdateUrl, H.value model.url] [],
  H.button [H.onClick Fetch, H.disabled $ show $ model.result == Fetching] [H.text "Fetch"],
  case model.result of
    NotFetched ->
      H.div [] [H.text "Not Fetched..."]
    Fetching ->
      H.div [] [H.text "Fetching..."]
    Ok ok ->
      H.pre [] [H.code [] [H.text $ "Ok: " <> ok]]
    Error error ->
      H.div [] [H.text $ "Error: " <> error]
]

main :: Effect Unit
main = do
  F.mount "main" { init, update, view }
