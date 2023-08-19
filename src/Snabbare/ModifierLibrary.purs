module Snabbare.ModifierLibrary where

import Prelude 
import Data.Tuple (Tuple(..))

import Data.Function.Uncurried (Fn2, Fn3, runFn2, runFn3)
import Effect (Effect)

import Web.Event.Event (Event)
import Web.DOM.Node (Node)

import Web.DOM.Node (Node)

type UpdateAndView msg = msg -> Effect Unit

foreign import mapModifier_ :: forall a b. Fn2 (a -> b) (Modifier a) (Modifier b)
foreign import createModifier_ :: forall msg a. Fn3 String String a (Modifier msg)

foreign import createSnabbareModifiers_ :: forall msg. Fn2 (UpdateAndView msg) (Modifiers msg) SnabbareModifiers
createSnabbareModifiers :: forall msg. UpdateAndView msg -> (Modifiers msg) -> SnabbareModifiers
createSnabbareModifiers = runFn2 createSnabbareModifiers_ 

foreign import data SnabbareModifier :: Type
type SnabbareModifiers = Array SnabbareModifier 

foreign import data Modifier :: Type -> Type
instance functorModifier :: Functor Modifier where
    map = runFn2 mapModifier_ 
type Modifiers msg = Array (Modifier msg)

-- not sure if I should (show value), need to dig in and decide how I want to structure this
property :: forall msg a. (Show a) => String -> a -> Modifier msg
property = runFn3 createModifier_ "property" 

attribute :: forall msg a. (Show a) => String -> a -> Modifier msg
attribute = runFn3 createModifier_ "attribute" 

key :: forall msg. String -> Modifier msg
key = runFn3 createModifier_ "key" ""

messageHook :: forall msg. String -> msg -> Modifier msg
messageHook eventTypeStr = runFn3 createModifier_ "messageHook" eventTypeStr

-- TODO: domModifierHook :: forall msg. String -> () -> Modifier msg
-- TODO: domToMsgHook :: forall msg. String -> () -> Modifier msg
-- TODO: clean up the names for 'on' helper functions, see how much "form" and "mouse" actually matter


foreign import data EventVnode :: Type

foreign import eventVnodeToNode :: EventVnode -> Node

on :: forall msg. String -> (Event -> EventVnode -> Effect msg) -> Modifier msg
on = runFn3 createModifier_ "on" 

on' :: forall msg. String -> (Event -> Node -> Effect msg) -> Modifier msg
on' eventName handler = on eventName handler'
    where
        handler' event vnode = handler event (eventVnodeToNode vnode)

onForm :: forall msg. String -> (Event -> Effect msg) -> Modifier msg
onForm eventName handler = on eventName handler'
    where
        handler' event _ = handler event

onMouse :: forall msg. String -> msg -> Modifier msg
onMouse eventName msg = on eventName handler'
    where
        handler' _ _ = pure msg

style :: forall msg. String -> String -> Modifier msg
style name value = runFn3 createModifier_ "style" name value


