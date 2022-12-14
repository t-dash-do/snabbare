module Snubbdom.SnabbdomLibrary where

import Prelude (bind, map, pure, ($))
import Data.Function.Uncurried (Fn3, Fn4, runFn3, runFn4)
import Data.Nullable as Nullable
import Data.Maybe (Maybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM as Web

import Snubbdom.ModifierLibrary (SnubbdomModifiers, UpdateAndView, createSnubbdomModifiers)
import Snubbdom.Element (Element(..), ThunkArgs, createThunkArgs, JsElementDecorator, SnabbdomVNode)


type ThunkPurescript a msg = forall a msg. (a -> Element a msg) -> a -> UpdateAndView msg -> SnabbdomVNode

-- FFI
foreign import patch_ :: EffectFn2 SnabbdomVNode SnabbdomVNode SnabbdomVNode
foreign import patchInit_ :: EffectFn2 Web.Element SnabbdomVNode SnabbdomVNode
foreign import h_ :: Fn3 String SnubbdomModifiers (Array SnabbdomVNode) SnabbdomVNode
foreign import querySelector_ :: EffectFn1 String (Nullable.Nullable Web.Element)
foreign import thunkJavascript_ :: forall a msg. Fn4 String String (ThunkPurescript a msg) ThunkArgs SnabbdomVNode

{-
foreign import JsElementDecoratorToVNode :: JsElementDecorator -> SnabbdomVNode
type JsElementDecorator
    :: ∀ a msg.
        { element ::
            { tag :: String
            , modifiers :: Modifiers msg
            , children :: (ElementChildren a msg)
            } 
        }
    -> 
-}

h :: String -> SnubbdomModifiers -> (Array SnabbdomVNode) -> SnabbdomVNode
h = runFn3 h_

thunkJavascript :: forall a msg. String -> String -> (ThunkPurescript a msg) -> ThunkArgs -> SnabbdomVNode
thunkJavascript = runFn4 thunkJavascript_

patchInit :: Web.Element -> SnabbdomVNode -> Effect SnabbdomVNode
patchInit = runEffectFn2 patchInit_ 

patch :: SnabbdomVNode -> SnabbdomVNode -> Effect SnabbdomVNode
patch = runEffectFn2 patch_ 


thunkPurescript :: forall a msg. ThunkPurescript a msg
thunkPurescript fn arg updateAndView = elementToSnabbdomVNode updateAndView $ fn arg

querySelector :: String -> Effect (Maybe Web.Element)
querySelector s = do
  q <- runEffectFn1 querySelector_ s 
  pure $ Nullable.toMaybe q


elementToSnabbdomVNode :: forall a msg. UpdateAndView msg -> Element a msg -> SnabbdomVNode
elementToSnabbdomVNode updateAndView (Element { tag, modifiers, children }) = 
    h
        tag
        (createSnubbdomModifiers updateAndView modifiers)
        (map (elementToSnabbdomVNode updateAndView) children) 
elementToSnabbdomVNode _ (ElementString s) = unsafeCoerce s 
elementToSnabbdomVNode updateAndView (ElementQueue { tag, key, fn, arg }) = 
    thunkJavascript 
        tag
        key
        thunkPurescript
        (createThunkArgs fn arg updateAndView)
elementToSnabbdomVNode updateAndView (JsDecoratedElement {element, decorator}) =
    decorator
        $ elementToSnabbdomVNode updateAndView
        $ Element element
