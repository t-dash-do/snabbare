module Snabbare.Element where

import Prelude (class Functor, map)
import Data.Function.Uncurried (Fn3, runFn3)
import Snabbare.ModifierLibrary (Modifiers, SnabbareModifiers, UpdateAndView, createSnabbareModifiers)

foreign import data ThunkArgs :: Type 

foreign import data SnabbareVNode :: Type

foreign import createThunkArgs_ :: forall a msg. Fn3 (a -> Element a msg) a (UpdateAndView msg) ThunkArgs 
createThunkArgs :: forall a msg. (a -> Element a msg) -> a -> UpdateAndView msg -> ThunkArgs 
createThunkArgs = runFn3 createThunkArgs_

type JsElementDecorator = SnabbareVNode -> SnabbareVNode 

data Element a msg
    = Element { tag :: String, modifiers :: Modifiers msg, children :: (ElementChildren a msg) } 
    | ElementString String
    | ElementQueue { tag :: String, key :: String, fn :: (a -> Element a msg), arg :: a }
    | JsDecoratedElement 
        { element ::  {tag :: String, modifiers :: Modifiers msg, children :: (ElementChildren a msg) } 
        , decorator :: JsElementDecorator
        }

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
    map f (JsDecoratedElement {decorator, element:{tag, modifiers, children}}) =
        let element' =
                    { tag: tag 
                    , modifiers: map (map f) modifiers 
                    , children: map (map f) children
                    }
        in (JsDecoratedElement {decorator, element:element'})