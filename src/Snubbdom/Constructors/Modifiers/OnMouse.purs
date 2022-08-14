module Snubbdom.OnMouse where

--import Prelude
import Snubbdom.ModifierLibrary (onMouse, Modifier)

type OnMouse = forall msg. msg -> (Modifier msg)

onClick :: OnMouse
onClick = onMouse "click"

onDoubleClick :: OnMouse
onDoubleClick = onMouse "dbclick"

onMouseDown :: OnMouse 
onMouseDown = onMouse "mousedown"

onMouseUp :: OnMouse 
onMouseUp = onMouse "mouseup"

onMouseEnter :: OnMouse 
onMouseEnter = onMouse "mouseenter"

onMouseLeave :: OnMouse 
onMouseLeave = onMouse "mouseleave"

onMouseMove :: OnMouse 
onMouseMove = onMouse "mousemove"

onMouseOver :: OnMouse 
onMouseOver = onMouse "mouseover"

onMouseOut :: OnMouse 
onMouseOut = onMouse "mouseout"



