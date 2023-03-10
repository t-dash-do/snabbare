module Framework (mount) where

import Prelude

import Effect.Console (log)
import Data.Either (Either(..))
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff as Aff
import Effect.Ref as Ref
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM as Web

import Snabbare.Library as Snubb
import Snabbare.Element as Snubb

type Init model msg = Tuple model (Array (Aff msg))

type Update model msg = model -> msg -> Tuple model (Array (Aff msg))

type View model a msg = model -> Snubb.Element a msg 

type Application model a msg = { 
  init :: Init model msg,
  update :: Update model msg,
  view :: View model a msg 
}

mount :: forall model a msg. String -> Application model a msg -> Effect Unit
mount selector app = do
  maybeElement <- Snubb.querySelector selector
  case maybeElement of
    Just element -> mount' element app 
    Nothing -> log $ "No element matching selector " <> show selector <> " found!"

mount' :: forall model a msg. Web.Element -> Application model a msg -> Effect Unit
mount' querySelectorElement app = do
  -- These two references will be written to in `start`, before they're ever read.
  model <- Ref.new (unsafeCoerce "!")
  svnode <- Ref.new (unsafeCoerce "!")
  let 
    start = do
      let Tuple model' affs = app.init
      Ref.write model' model
      let initElement = app.view model'
      let newSvnode = Snubb.elementToSnabbareVNode updateAndView initElement
      newPatchVnode <- Snubb.patchInit querySelectorElement newSvnode
      Ref.write newPatchVnode svnode
      dispatch affs
    updateAndView msg = do
      oldModel <- Ref.read model
      let Tuple newModel affs = app.update oldModel msg 
      Ref.write newModel model
      render
      dispatch affs
    render = do
      oldSvnode <- Ref.read svnode
      newElement <- app.view <$> Ref.read model
      let newSvnode = Snubb.elementToSnabbareVNode updateAndView newElement
      newSvnodeFromPatch <- Snubb.patch oldSvnode newSvnode 
      Ref.write newSvnodeFromPatch svnode
    dispatch affs = do
      for_ affs $ \aff -> do
        Aff.runAff_ (case _ of
          Left error -> log $ show error
          Right msg' -> updateAndView msg') aff 
    setModel newModel = do
      Ref.write newModel model
      render
  start

