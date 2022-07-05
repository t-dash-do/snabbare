module Snabbdom.ElementConstructors where

import Snabbdom.Element (Element(..), ElementChildren)
import Snabbdom.ModifierLibrary (Modifiers)

type ElementConstructor a msg = Modifiers msg -> ElementChildren a msg -> Element a msg

elementConstructor :: forall a msg. String -> (Modifiers msg) -> (ElementChildren a msg) -> (Element a msg) 
elementConstructor t m c = Element { tag: t, modifiers: m, children: c }

text :: forall a msg. String -> Element a msg
text t = ElementString t

queueElement :: forall a msg. String -> String -> (a -> Element a msg) -> a -> (Element a msg)
queueElement tag key fn arg = ElementQueue { tag: tag, key: key, fn: fn, arg: arg }


