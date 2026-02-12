module Snabbare.Hook where

import Snabbare.ModifierLibrary (messageHook, Modifier)

initMsg :: ∀ msg. msg -> Modifier msg
initMsg = messageHook "init"
        
createMsg :: ∀ msg. msg -> Modifier msg
createMsg = messageHook "create"
 
insertMsg :: ∀ msg. msg -> Modifier msg
insertMsg = messageHook "insert"

prepatchMsg :: ∀ msg. msg -> Modifier msg
prepatchMsg = messageHook "prepatch"
 
updateMsg :: ∀ msg. msg -> Modifier msg
updateMsg = messageHook "update"
 
postpatchMsg :: ∀ msg. msg -> Modifier msg
postpatchMsg = messageHook "postpatch"

destroyMsg :: ∀ msg. msg -> Modifier msg
destroyMsg = messageHook "destroy"

removeMsg :: ∀ msg. msg -> Modifier msg
removeMsg = messageHook "remove"