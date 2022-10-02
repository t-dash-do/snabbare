module Snubbdom.Element where

import Prelude (class Functor, map)
import Data.Function.Uncurried (Fn3, runFn3)
import Snubbdom.ModifierLibrary (Modifiers, SnubbdomModifiers, UpdateAndView, createSnubbdomModifiers)

foreign import data ThunkArgs :: Type 

foreign import createThunkArgs_ :: forall a msg. Fn3 (a -> Element a msg) a (UpdateAndView msg) ThunkArgs 
createThunkArgs :: forall a msg. (a -> Element a msg) -> a -> UpdateAndView msg -> ThunkArgs 
createThunkArgs = runFn3 createThunkArgs_

data Element a msg = 
    Element { tag :: String, modifiers :: Modifiers msg, children :: (ElementChildren a msg) } 
    | ElementString String
    | ElementQueue { tag :: String, key :: String, fn :: (a -> Element a msg), arg :: a }

type ElementChildren a msg = Array (Element a msg)

-- used for example when turning one type of Msg into another, composing 'components'
instance functorElement :: Functor (Element a) where
    map f (Element { tag, modifiers, children }) = Element { 
           tag: tag, 
           modifiers: map (map f) modifiers, 
           children: map (map f) children }
    map _ (ElementString s) = ElementString s
    map f (ElementQueue { tag, key, fn, arg }) = ElementQueue { 
           tag: tag,
           key: key,
           fn: \a -> map f (fn a),
           arg: arg
           }
