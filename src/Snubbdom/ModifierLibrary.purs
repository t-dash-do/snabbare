module Snubbdom.ModifierLibrary where

import Prelude 
import Effect (Effect)
import Data.Function.Uncurried (Fn2, Fn3, runFn2, runFn3)
import Web.Event.Event (Event)
import Data.Tuple (Tuple(..))

type UpdateAndView msg = msg -> Effect Unit

foreign import mapModifier_ :: forall a b. Fn2 (a -> b) (Modifier a) (Modifier b)
foreign import createModifier_ :: forall msg a. Fn3 String String a (Modifier msg)

foreign import createSnubbdomModifiers_ :: forall msg. Fn2 (UpdateAndView msg) (Modifiers msg) SnubbdomModifiers
createSnubbdomModifiers :: forall msg. UpdateAndView msg -> (Modifiers msg) -> SnubbdomModifiers
createSnubbdomModifiers = runFn2 createSnubbdomModifiers_ 

foreign import data SnubbdomModifier :: Type
type SnubbdomModifiers = Array SnubbdomModifier 

foreign import data Modifier :: Type -> Type
instance functorModifier :: Functor Modifier where
    map = runFn2 mapModifier_ 
type Modifiers msg = Array (Modifier msg)


-- not sure if I should (show value), need to dig in and decide how I want to structure this
property :: forall msg a. (Show a) => String -> a -> Modifier msg
property key' value = runFn3 createModifier_ "property" key' $ show value

attribute :: forall msg. String -> String -> Modifier msg
attribute key' value = runFn3 createModifier_ "attribute" key' value

key :: forall msg. String -> Modifier msg
key = runFn3 createModifier_ "key" ""

onForm :: forall msg. String -> (Event -> Effect msg) -> Modifier msg
onForm = runFn3 createModifier_ "form" 

onMouse :: forall msg. String -> msg -> Modifier msg
onMouse = runFn3 createModifier_ "mouse" 

style :: forall msg. String -> String -> Modifier msg
style name value = runFn3 createModifier_ "style" name value


