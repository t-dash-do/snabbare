module SimpleFramework (mount, Init, Update, View) where

import Prelude

import Effect.Console (log)
import Data.Either (Either(..))
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff as Aff
import Effect.Ref as Ref
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM as Web

import Snabbare.Library as Snubb
import Snabbare.Element as Snubb

type Init model = model 

type Update model msg = model -> msg -> model 

type View model a msg = model -> Snubb.Element a msg 

type Application model a msg = { 
  init :: Init model,
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
mount' initialDomElement app = do
  model <- Ref.new (unsafeCoerce "!")
  vnode <- Ref.new (unsafeCoerce "!")
  let 
    readModel = Ref.read model
    writeModel s = Ref.write s model
    readVnode = Ref.read vnode
    writeVnode v = Ref.write v vnode

    start = do
      let model' = app.init
      writeModel model' 
      let initElement = app.view model'
      newVnode <- Snubb.patchInit initialDomElement (Snubb.elementToSnabbdomVNode updateAndView initElement)
      writeVnode newVnode 

    updateAndView msg = do
       oldModel <- readModel 
       let newModel = app.update oldModel msg 
       writeModel newModel 
       render

    render = do
      oldVnode <- readVnode
      newElement <- app.view <$> readModel
      newVnodeFromPatch <- Snubb.patch oldVnode (Snubb.elementToSnabbdomVNode updateAndView newElement)
      writeVnode newVnodeFromPatch 

  start

