module Snubbdom.Property where

import Prelude (($))
import Data.String as String
import Snubbdom.ModifierLibrary (property, Modifier)

type StringProperty = forall msg. String -> Modifier msg
type BooleanProperty = forall msg. Boolean -> Modifier msg


classNames :: forall msg. Array String -> Modifier msg
classNames a = className $ String.joinWith " " a

--- BELOW IN DOM SPEC ---

autocomplete :: BooleanProperty
autocomplete = property "autocomplete"

autofocus :: BooleanProperty
autofocus = property "autofocus"

autoplay :: BooleanProperty
autoplay = property "autoplay"

checked :: BooleanProperty
checked = property "checked"

contentEditable :: BooleanProperty
contentEditable = property "contentEditable"

controls :: BooleanProperty
controls = property "controls"

default :: BooleanProperty
default = property "default"

disabled :: BooleanProperty
disabled = property "disabled"

hidden :: BooleanProperty
hidden = property "hidden"

isMap :: BooleanProperty
isMap = property "isMap"

loop :: BooleanProperty
loop = property "loop"

multiple :: BooleanProperty
multiple = property "multiple"

noValidate :: BooleanProperty
noValidate = property "noValidate"

readOnly :: BooleanProperty
readOnly = property "readOnly"

required :: BooleanProperty
required = property "required"

reversed :: BooleanProperty
reversed = property "reversed"

selected :: BooleanProperty
selected = property "selected"

spellcheck :: BooleanProperty
spellcheck = property "spellcheck"

accept :: StringProperty
accept = property "accept"

acceptCharset :: StringProperty
acceptCharset = property "acceptCharset"

accessKey :: StringProperty
accessKey = property "accessKey"

action :: StringProperty
action = property "action"

align :: StringProperty
align = property "align"

alt :: StringProperty
alt = property "alt"

className :: StringProperty
className = property "className"

coords :: StringProperty
coords = property "coords"

dir :: StringProperty
dir = property "dir"

download :: StringProperty
download = property "download"

downloadAs :: StringProperty
downloadAs = property "downloadAs"

dropzone :: StringProperty
dropzone = property "dropzone"

enctype :: StringProperty
enctype = property "enctype"

for :: StringProperty
for = property "htmlFor"

headers :: StringProperty
headers = property "headers"

href :: StringProperty
href = property "href"

hreflang :: StringProperty
hreflang = property "hreflang"

id :: StringProperty
id = property "id"

kind :: StringProperty
kind = property "kind"

lang :: StringProperty
lang = property "lang"

max :: StringProperty
max = property "max"

method :: StringProperty
method = property "method"

min :: StringProperty
min = property "min"

name :: StringProperty
name = property "name"

pattern :: StringProperty
pattern = property "pattern"

ping :: StringProperty
ping = property "ping"

placeholder :: StringProperty
placeholder = property "placeholder"

poster :: StringProperty
poster = property "poster"

preload :: StringProperty
preload = property "preload"

sandbox :: StringProperty
sandbox = property "sandbox"

scope :: StringProperty
scope = property "scope"

shape :: StringProperty
shape = property "shape"

src :: StringProperty
src = property "src"

srcdoc :: StringProperty
srcdoc = property "srcdoc"

srclang :: StringProperty
srclang = property "srclang"

step :: StringProperty
step = property "step"

target :: StringProperty
target = property "target"

title :: StringProperty
title = property "title"

type' :: StringProperty
type' = property "type"

useMap :: StringProperty
useMap = property "useMap"

value :: StringProperty
value = property "value"

wrap :: StringProperty
wrap = property "wrap"


