module Snabbdom.Property where

import Prelude (($))
import Data.String as String
import Snabbdom.ModifierLibrary (property, Modifier)

type StringProperty = forall msg. String -> Modifier msg
type BooleanProperty = forall msg. Boolean -> Modifier msg


classNames :: forall msg. Array String -> Modifier msg
classNames a = className $ String.joinWith " " a

--- BELOW IN DOM SPEC ---

contentEditable :: BooleanProperty
contentEditable = property "contentEditable"

isMap :: BooleanProperty
isMap = property "isMap" 

noValidate :: BooleanProperty
noValidate = property "noValidate" 

readOnly :: BooleanProperty
readOnly = property "readOnly" 

acceptCharset :: StringProperty
acceptCharset = property "acceptCharset"

accessKey :: StringProperty
accessKey = property "accessKey"

className :: StringProperty
className = property "className"

downloadAs :: StringProperty
downloadAs = property "downloadAs"

dropzone :: StringProperty
dropzone = property "dropzone"

ping :: StringProperty
ping = property "ping"

useMap :: StringProperty
useMap = property "useMap"


