module Snubbdom.Element where

import Prelude (class Functor, map)
import Data.Function.Uncurried (Fn3, runFn3)
import Snubbdom.ModifierLibrary (Modifiers, SnabbdomModifiers, UpdateAndView, createSnabbdomModifiers)

foreign import data ThunkArgs :: Type 

foreign import createThunkArgs_ :: forall a msg. Fn3 (a -> Element a msg) a (UpdateAndView msg) ThunkArgs 
createThunkArgs :: forall a msg. (a -> Element a msg) -> a -> UpdateAndView msg -> ThunkArgs 
createThunkArgs = runFn3 createThunkArgs_

-- Snubbdom Element
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

-- never create this manually. Use elementToVNode instead
data VNode = 
    VNode { tag :: String, modifiers :: SnabbdomModifiers, children :: VNodeChildren } 
    | VNodeString String
    | VNodeQueue { tag :: String, key :: String, args :: ThunkArgs }

type VNodeChildren = Array VNode

elementToVNode :: forall a msg. UpdateAndView msg -> (Element a msg) -> VNode 
elementToVNode updateAndView (Element { tag, modifiers, children }) = 
    VNode { 
          tag: tag, 
          modifiers: (createSnabbdomModifiers updateAndView modifiers), 
          children: (map (elementToVNode updateAndView) children) 
          }
elementToVNode _ (ElementString s) = VNodeString s 
elementToVNode updateAndView (ElementQueue { tag, key, fn, arg }) = 
    VNodeQueue { 
          tag: tag, 
          key: key,
          args: createThunkArgs fn arg updateAndView
          }
