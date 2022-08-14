module Snubbdom.Attribute where

--import Prelude
import Snubbdom.ModifierLibrary (attribute, Modifier)

type Attribute = forall msg. String -> (Modifier msg)

accept :: Attribute
accept = attribute "accept"

acceptcharset :: Attribute
acceptcharset = attribute "accept-charset"

accesskey :: Attribute
accesskey = attribute "accesskey"

action :: Attribute
action = attribute "action"

align :: Attribute
align = attribute "align"

alt :: Attribute
alt = attribute "alt"

async :: Attribute
async = attribute "async"

autocomplete :: Attribute
autocomplete = attribute "autocomplete"

autofocus :: Attribute
autofocus = attribute "autofocus"

autoplay :: Attribute
autoplay = attribute "autoplay"

bgcolor :: Attribute
bgcolor = attribute "bgcolor"

border :: Attribute
border = attribute "border"

charset :: Attribute
charset = attribute "charset"

checked :: Attribute
checked = attribute "checked"

cite' :: Attribute
cite' = attribute "cite"

class' :: Attribute
class' = attribute "class"

color :: Attribute
color = attribute "color"

cols :: Attribute
cols = attribute "cols"

colspan :: Attribute
colspan = attribute "colspan"

content :: Attribute
content = attribute "content"

contenteditable :: Attribute
contenteditable = attribute "contenteditable"

controls :: Attribute
controls = attribute "controls"

coords :: Attribute
coords = attribute "coords"

data' :: Attribute
data' = attribute "data"

dataasterisk :: Attribute
dataasterisk = attribute "data-*"

datetime :: Attribute
datetime = attribute "datetime"

default :: Attribute
default = attribute "default"

defer :: Attribute
defer = attribute "defer"

dir :: Attribute
dir = attribute "dir"

dirname :: Attribute
dirname = attribute "dirname"

disabled :: Attribute
disabled = attribute "disabled"

download :: Attribute
download = attribute "download"

draggable :: Attribute
draggable = attribute "draggable"

enctype :: Attribute
enctype = attribute "enctype"

for :: Attribute
for = attribute "for"

form' :: Attribute
form' = attribute "form"

formaction :: Attribute
formaction = attribute "formaction"

headers :: Attribute
headers = attribute "headers"

height :: Attribute
height = attribute "height"

hidden :: Attribute
hidden = attribute "hidden"

high :: Attribute
high = attribute "high"

href :: Attribute
href = attribute "href"

hreflang :: Attribute
hreflang = attribute "hreflang"

httpequiv :: Attribute
httpequiv = attribute "http-equiv"

id :: Attribute
id = attribute "id"

ismap :: Attribute
ismap = attribute "ismap"

kind' :: Attribute
kind' = attribute "kind"

label' :: Attribute
label' = attribute "label"

lang :: Attribute
lang = attribute "lang"

list :: Attribute
list = attribute "list"

loop :: Attribute
loop = attribute "loop"

low :: Attribute
low = attribute "low"

max :: Attribute
max = attribute "max"

maxlength :: Attribute
maxlength = attribute "maxlength"

media :: Attribute
media = attribute "media"

method :: Attribute
method = attribute "method"

min :: Attribute
min = attribute "min"

multiple :: Attribute
multiple = attribute "multiple"

muted :: Attribute
muted = attribute "muted"

name :: Attribute
name = attribute "name"

novalidate :: Attribute
novalidate = attribute "novalidate"

onabort :: Attribute
onabort = attribute "onabort"

onafterprint :: Attribute
onafterprint = attribute "onafterprint"

onbeforeprint :: Attribute
onbeforeprint = attribute "onbeforeprint"

onbeforeunload :: Attribute
onbeforeunload = attribute "onbeforeunload"

onblur :: Attribute
onblur = attribute "onblur"

oncanplay :: Attribute
oncanplay = attribute "oncanplay"

oncanplaythrough :: Attribute
oncanplaythrough = attribute "oncanplaythrough"

onchange :: Attribute
onchange = attribute "onchange"

onclick :: Attribute
onclick = attribute "onclick"

oncontextmenu :: Attribute
oncontextmenu = attribute "oncontextmenu"

oncopy :: Attribute
oncopy = attribute "oncopy"

oncuechange :: Attribute
oncuechange = attribute "oncuechange"

oncut :: Attribute
oncut = attribute "oncut"

ondblclick :: Attribute
ondblclick = attribute "ondblclick"

ondrag :: Attribute
ondrag = attribute "ondrag"

ondragend :: Attribute
ondragend = attribute "ondragend"

ondragenter :: Attribute
ondragenter = attribute "ondragenter"

ondragleave :: Attribute
ondragleave = attribute "ondragleave"

ondragover :: Attribute
ondragover = attribute "ondragover"

ondragstart :: Attribute
ondragstart = attribute "ondragstart"

ondrop :: Attribute
ondrop = attribute "ondrop"

ondurationchange :: Attribute
ondurationchange = attribute "ondurationchange"

onemptied :: Attribute
onemptied = attribute "onemptied"

onended :: Attribute
onended = attribute "onended"

onerror :: Attribute
onerror = attribute "onerror"

onfocus :: Attribute
onfocus = attribute "onfocus"

onhashchange :: Attribute
onhashchange = attribute "onhashchange"

oninput :: Attribute
oninput = attribute "oninput"

oninvalid :: Attribute
oninvalid = attribute "oninvalid"

onkeydown :: Attribute
onkeydown = attribute "onkeydown"

onkeypress :: Attribute
onkeypress = attribute "onkeypress"

onkeyup :: Attribute
onkeyup = attribute "onkeyup"

onload :: Attribute
onload = attribute "onload"

onloadeddata :: Attribute
onloadeddata = attribute "onloadeddata"

onloadedmetadata :: Attribute
onloadedmetadata = attribute "onloadedmetadata"

onloadstart :: Attribute
onloadstart = attribute "onloadstart"

onmousedown :: Attribute
onmousedown = attribute "onmousedown"

onmousemove :: Attribute
onmousemove = attribute "onmousemove"

onmouseout :: Attribute
onmouseout = attribute "onmouseout"

onmouseover :: Attribute
onmouseover = attribute "onmouseover"

onmouseup :: Attribute
onmouseup = attribute "onmouseup"

onmousewheel :: Attribute
onmousewheel = attribute "onmousewheel"

onoffline :: Attribute
onoffline = attribute "onoffline"

ononline :: Attribute
ononline = attribute "ononline"

onpagehide :: Attribute
onpagehide = attribute "onpagehide"

onpageshow :: Attribute
onpageshow = attribute "onpageshow"

onpaste :: Attribute
onpaste = attribute "onpaste"

onpause :: Attribute
onpause = attribute "onpause"

onplay :: Attribute
onplay = attribute "onplay"

onplaying :: Attribute
onplaying = attribute "onplaying"

onpopstate :: Attribute
onpopstate = attribute "onpopstate"

onprogress :: Attribute
onprogress = attribute "onprogress"

onratechange :: Attribute
onratechange = attribute "onratechange"

onreset :: Attribute
onreset = attribute "onreset"

onresize :: Attribute
onresize = attribute "onresize"

onscroll :: Attribute
onscroll = attribute "onscroll"

onsearch :: Attribute
onsearch = attribute "onsearch"

onseeked :: Attribute
onseeked = attribute "onseeked"

onseeking :: Attribute
onseeking = attribute "onseeking"

onselect :: Attribute
onselect = attribute "onselect"

onstalled :: Attribute
onstalled = attribute "onstalled"

onstorage :: Attribute
onstorage = attribute "onstorage"

onsubmit :: Attribute
onsubmit = attribute "onsubmit"

onsuspend :: Attribute
onsuspend = attribute "onsuspend"

ontimeupdate :: Attribute
ontimeupdate = attribute "ontimeupdate"

ontoggle :: Attribute
ontoggle = attribute "ontoggle"

onunload :: Attribute
onunload = attribute "onunload"

onvolumechange :: Attribute
onvolumechange = attribute "onvolumechange"

onwaiting :: Attribute
onwaiting = attribute "onwaiting"

onwheel :: Attribute
onwheel = attribute "onwheel"

open :: Attribute
open = attribute "open"

optimum :: Attribute
optimum = attribute "optimum"

pattern :: Attribute
pattern = attribute "pattern"

placeholder :: Attribute
placeholder = attribute "placeholder"

poster :: Attribute
poster = attribute "poster"

preload :: Attribute
preload = attribute "preload"

readonly :: Attribute
readonly = attribute "readonly"

rel :: Attribute
rel = attribute "rel"

required :: Attribute
required = attribute "required"

reversed :: Attribute
reversed = attribute "reversed"

rows :: Attribute
rows = attribute "rows"

rowspan :: Attribute
rowspan = attribute "rowspan"

sandbox :: Attribute
sandbox = attribute "sandbox"

scope :: Attribute
scope = attribute "scope"

selected :: Attribute
selected = attribute "selected"

shape :: Attribute
shape = attribute "shape"

size :: Attribute
size = attribute "size"

sizes :: Attribute
sizes = attribute "sizes"

span' :: Attribute
span' = attribute "span"

spellcheck :: Attribute
spellcheck = attribute "spellcheck"

src :: Attribute
src = attribute "src"

srcdoc :: Attribute
srcdoc = attribute "srcdoc"

srclang :: Attribute
srclang = attribute "srclang"

srcset :: Attribute
srcset = attribute "srcset"

start :: Attribute
start = attribute "start"

step :: Attribute
step = attribute "step"

tabindex :: Attribute
tabindex = attribute "tabindex"

target :: Attribute
target = attribute "target"

title :: Attribute
title = attribute "title"

translate :: Attribute
translate = attribute "translate"

type' :: Attribute
type' = attribute "type"

usemap :: Attribute
usemap = attribute "usemap"

value :: Attribute
value = attribute "value"

width :: Attribute
width = attribute "width"

wrap :: Attribute
wrap = attribute "wrap"


