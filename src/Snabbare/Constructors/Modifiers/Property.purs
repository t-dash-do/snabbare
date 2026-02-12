module Snabbare.Property where

import Prelude (($))
import Data.String as String
import Snabbare.ModifierLibrary (attribute, property, Modifier)

type StringProperty = forall msg. String -> Modifier msg
type BooleanProperty = forall msg. Boolean -> Modifier msg


classNames :: forall msg. Array String -> Modifier msg
classNames a = className $ String.joinWith " " a

--- Boolean attributes ---

autofocus :: BooleanProperty
autofocus = attribute "autofocus"

autoplay :: BooleanProperty
autoplay = attribute "autoplay"

controls :: BooleanProperty
controls = attribute "controls"

default :: BooleanProperty
default = attribute "default"

disabled :: BooleanProperty
disabled = attribute "disabled"

hidden :: BooleanProperty
hidden = attribute "hidden"

isMap :: BooleanProperty
isMap = attribute "ismap"

loop :: BooleanProperty
loop = attribute "loop"

multiple :: BooleanProperty
multiple = attribute "multiple"

noValidate :: BooleanProperty
noValidate = attribute "novalidate"

readOnly :: BooleanProperty
readOnly = attribute "readonly"

required :: BooleanProperty
required = attribute "required"

reversed :: BooleanProperty
reversed = attribute "reversed"

spellcheck :: BooleanProperty
spellcheck = attribute "spellcheck"

--- String attributes ---

accept :: StringProperty
accept = attribute "accept"

acceptCharset :: StringProperty
acceptCharset = attribute "accept-charset"

accessKey :: StringProperty
accessKey = attribute "accesskey"

action :: StringProperty
action = attribute "action"

align :: StringProperty
align = attribute "align"

alt :: StringProperty
alt = attribute "alt"

autocomplete :: StringProperty
autocomplete = attribute "autocomplete"

className :: StringProperty
className = attribute "class"

contentEditable :: StringProperty
contentEditable = attribute "contenteditable"

coords :: StringProperty
coords = attribute "coords"

dir :: StringProperty
dir = attribute "dir"

download :: StringProperty
download = attribute "download"

downloadAs :: StringProperty
downloadAs = attribute "downloadAs"

dropzone :: StringProperty
dropzone = attribute "dropzone"

enctype :: StringProperty
enctype = attribute "enctype"

for :: StringProperty
for = attribute "for"

headers :: StringProperty
headers = attribute "headers"

href :: StringProperty
href = attribute "href"

hreflang :: StringProperty
hreflang = attribute "hreflang"

id :: StringProperty
id = attribute "id"

kind :: StringProperty
kind = attribute "kind"

lang :: StringProperty
lang = attribute "lang"

max :: StringProperty
max = attribute "max"

method :: StringProperty
method = attribute "method"

min :: StringProperty
min = attribute "min"

name :: StringProperty
name = attribute "name"

pattern :: StringProperty
pattern = attribute "pattern"

ping :: StringProperty
ping = attribute "ping"

placeholder :: StringProperty
placeholder = attribute "placeholder"

poster :: StringProperty
poster = attribute "poster"

preload :: StringProperty
preload = attribute "preload"

sandbox :: StringProperty
sandbox = attribute "sandbox"

scope :: StringProperty
scope = attribute "scope"

shape :: StringProperty
shape = attribute "shape"

src :: StringProperty
src = attribute "src"

srcdoc :: StringProperty
srcdoc = attribute "srcdoc"

srclang :: StringProperty
srclang = attribute "srclang"

srcset :: StringProperty
srcset = attribute "srcset"

step :: StringProperty
step = attribute "step"

target :: StringProperty
target = attribute "target"

title :: StringProperty
title = attribute "title"

type' :: StringProperty
type' = attribute "type"

useMap :: StringProperty
useMap = attribute "usemap"

wrap :: StringProperty
wrap = attribute "wrap"

--- Properties (must remain as DOM properties for form control state) ---

checked :: BooleanProperty
checked = property "checked"

selected :: BooleanProperty
selected = property "selected"

value :: StringProperty
value = property "value"
