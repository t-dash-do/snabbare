module Snubbdom.Attribute where

import Prelude
import Snubbdom.ModifierLibrary (attribute, Modifier)

type AttributeString = forall msg. String -> Modifier msg
type AttributeInt = forall msg. Int -> Modifier msg

cols :: AttributeInt
cols = attribute "cols" <<< show

colspan :: AttributeInt
colspan = attribute "colspan" <<< show

height :: AttributeInt
height = attribute "height" <<< show

maxlength :: AttributeInt
maxlength = attribute "maxlength" <<< show

minlength :: AttributeInt
minlength = attribute "minlength" <<< show

rows :: AttributeInt
rows = attribute "rows" <<< show

rowspan :: AttributeInt
rowspan = attribute "rowspan" <<< show

size :: AttributeInt
size = attribute "size" <<< show

start :: AttributeInt
start = attribute "start" <<< show

tabindex :: AttributeInt
tabindex = attribute "tabindex" <<< show

width :: AttributeInt
width = attribute "width" <<< show

contextmenu :: AttributeString
contextmenu = attribute "contextmenu"

datetime :: AttributeString
datetime = attribute "datetime"

draggable :: AttributeString
draggable = attribute "draggable"

itemprop :: AttributeString
itemprop = attribute "itemprop"

list :: AttributeString
list = attribute "list"

manifest :: AttributeString
manifest = attribute "manifest"

media :: AttributeString
media = attribute "media"

pubdate :: AttributeString
pubdate = attribute "pubdate"

rel :: AttributeString
rel = attribute "rel"
