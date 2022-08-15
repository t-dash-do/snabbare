module Snubbdom.Library where

import Prelude (bind, map, pure, ($))
import Data.Function.Uncurried (Fn3, Fn4, runFn3, runFn4)
import Data.Nullable as Nullable
import Data.Maybe (Maybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM as Web

import Snubbdom.ModifierLibrary (SnubbdomModifiers, UpdateAndView)
import Snubbdom.Element (Element, ThunkArgs, VNode(..), elementToVNode)

foreign import data SnabbdomVNode :: Type
type ThunkPurescript a msg = forall a msg. (a -> Element a msg) -> a -> UpdateAndView msg -> SnabbdomVNode

-- FFI
foreign import patch_ :: EffectFn2 SnabbdomVNode SnabbdomVNode SnabbdomVNode
foreign import patchInit_ :: EffectFn2 Web.Element SnabbdomVNode SnabbdomVNode
foreign import h_ :: Fn3 String SnubbdomModifiers (Array SnabbdomVNode) SnabbdomVNode
foreign import querySelector_ :: EffectFn1 String (Nullable.Nullable Web.Element)
foreign import thunkJavascript_ :: forall a msg. Fn4 String String (ThunkPurescript a msg) ThunkArgs SnabbdomVNode

patchInit :: Web.Element -> SnabbdomVNode -> Effect SnabbdomVNode
patchInit = runEffectFn2 patchInit_ 

patch :: SnabbdomVNode -> SnabbdomVNode -> Effect SnabbdomVNode
patch = runEffectFn2 patch_ 

h :: VNode -> SnabbdomVNode
h (VNode { tag, modifiers, children }) = runFn3 h_ 
    tag
    modifiers
    (map h children)
h (VNodeString s) = unsafeCoerce s
h (VNodeQueue { tag, key, args }) = runFn4 thunkJavascript_ tag key thunkPurescript args

elementToSnabbdomVNode :: forall a msg. UpdateAndView msg -> Element a msg -> SnabbdomVNode
elementToSnabbdomVNode updateAndView e = h $ elementToVNode updateAndView e

thunkPurescript :: forall a msg. ThunkPurescript a msg
thunkPurescript fn arg updateAndView = elementToSnabbdomVNode updateAndView $ fn arg

querySelector :: String -> Effect (Maybe Web.Element)
querySelector s = do
  q <- runEffectFn1 querySelector_ s 
  pure $ Nullable.toMaybe q
