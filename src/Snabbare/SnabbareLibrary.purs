module Snabbare.SnabbareLibrary where

import Prelude (bind, map, pure, ($))
import Data.Function.Uncurried (Fn3, Fn4, runFn3, runFn4)
import Data.Nullable as Nullable
import Data.Maybe (Maybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM as Web

import Snabbare.ModifierLibrary (SnabbareModifiers, UpdateAndView, createSnabbareModifiers)
import Snabbare.Element (Element(..), ThunkArgs, createThunkArgs, JsElementDecorator, SnabbareVNode)


type ThunkPurescript a msg = forall a msg. (a -> Element a msg) -> a -> UpdateAndView msg -> SnabbareVNode

-- FFI
foreign import patch_ :: EffectFn2 SnabbareVNode SnabbareVNode SnabbareVNode
foreign import patchInit_ :: EffectFn2 Web.Element SnabbareVNode SnabbareVNode
foreign import h_ :: Fn3 String SnabbareModifiers (Array SnabbareVNode) SnabbareVNode
foreign import querySelector_ :: EffectFn1 String (Nullable.Nullable Web.Element)
foreign import thunkJavascript_ :: forall a msg. Fn4 String String (ThunkPurescript a msg) ThunkArgs SnabbareVNode

{-
foreign import JsElementDecoratorToVNode :: JsElementDecorator -> SnabbareVNode
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

h :: String -> SnabbareModifiers -> (Array SnabbareVNode) -> SnabbareVNode
h = runFn3 h_

thunkJavascript :: forall a msg. String -> String -> (ThunkPurescript a msg) -> ThunkArgs -> SnabbareVNode
thunkJavascript = runFn4 thunkJavascript_

patchInit :: Web.Element -> SnabbareVNode -> Effect SnabbareVNode
patchInit = runEffectFn2 patchInit_ 

patch :: SnabbareVNode -> SnabbareVNode -> Effect SnabbareVNode
patch = runEffectFn2 patch_ 


thunkPurescript :: forall a msg. ThunkPurescript a msg
thunkPurescript fn arg updateAndView = elementToVNode updateAndView $ fn arg

querySelector :: String -> Effect (Maybe Web.Element)
querySelector s = do
  q <- runEffectFn1 querySelector_ s 
  pure $ Nullable.toMaybe q


elementToVNode :: forall a msg. UpdateAndView msg -> Element a msg -> SnabbareVNode
elementToVNode updateAndView (Element { tag, modifiers, children }) = 
    h
        tag
        (createSnabbareModifiers updateAndView modifiers)
        (map (elementToVNode updateAndView) children) 
elementToVNode _ (ElementString s) = unsafeCoerce s 
elementToVNode updateAndView (ElementQueue { tag, key, fn, arg }) = 
    thunkJavascript 
        tag
        key
        thunkPurescript
        (createThunkArgs fn arg updateAndView)
elementToVNode updateAndView (JsDecoratedElement {element, decorator}) =
    decorator
        $ elementToVNode updateAndView
        $ Element element
