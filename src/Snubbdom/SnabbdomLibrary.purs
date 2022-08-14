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

foreign import data SnubbdomVNode :: Type
type ThunkPurescript a msg = forall a msg. (a -> Element a msg) -> a -> UpdateAndView msg -> SnubbdomVNode

-- FFI
foreign import patch_ :: EffectFn2 SnubbdomVNode SnubbdomVNode SnubbdomVNode
foreign import patchInit_ :: EffectFn2 Web.Element SnubbdomVNode SnubbdomVNode
foreign import h_ :: Fn3 String SnubbdomModifiers (Array SnubbdomVNode) SnubbdomVNode
foreign import querySelector_ :: EffectFn1 String (Nullable.Nullable Web.Element)
foreign import thunkJavascript_ :: forall a msg. Fn4 String String (ThunkPurescript a msg) ThunkArgs SnubbdomVNode

patchInit :: Web.Element -> SnubbdomVNode -> Effect SnubbdomVNode
patchInit = runEffectFn2 patchInit_ 

patch :: SnubbdomVNode -> SnubbdomVNode -> Effect SnubbdomVNode
patch = runEffectFn2 patch_ 

h :: VNode -> SnubbdomVNode
h (VNode { tag, modifiers, children }) = runFn3 h_ 
    tag
    modifiers
    (map h children)
h (VNodeString s) = unsafeCoerce s
h (VNodeQueue { tag, key, args }) = runFn4 thunkJavascript_ tag key thunkPurescript args

elementToSnubbdomVNode :: forall a msg. UpdateAndView msg -> Element a msg -> SnubbdomVNode
elementToSnubbdomVNode updateAndView e = h $ elementToVNode updateAndView e

thunkPurescript :: forall a msg. ThunkPurescript a msg
thunkPurescript fn arg updateAndView = elementToSnubbdomVNode updateAndView $ fn arg

querySelector :: String -> Effect (Maybe Web.Element)
querySelector s = do
  q <- runEffectFn1 querySelector_ s 
  pure $ Nullable.toMaybe q
