{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "snabbare"
, dependencies =
  [ "console"
  , "effect"
  , "prelude"
  , "effect"
  , "web-dom"
  , "web-html"
  , "nullable"
  , "control"
  , "functions"
  , "maybe"
  , "strings"
  , "tuples"
  , "unsafe-coerce"
  , "web-events"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, license = "MIT"
}
