### Todo:
- purescript-snabbdom name already take, I should look at that code, but change my names to say snubbdom (files, docs, datatypes, functions, etc)
- write comments and API usage docs
- add tests 
- setup CI
- follow this to publish: https://jordanmartinez.github.io/purescript-jordans-reference-site/content/03-Build-Tools/03-Bower--Project-Workflow.html
- ask Carl to start a Github account where he wants open source code to be
- I think the Element a Msg, the forall a. is causing an issue where youll only be able to have one type of delayed computation (a -> Element a Msg). Might be better to just use FFI so don't have to deal with types here



for using purescript-snabbdom and testing examples
1. spago build
2. browserify dist/index.js -o dist/bundle.js (problem here now) (converts require statements to be ok in browser)
3. parcel build dist/bundle.js (resolves packages)

package.json in this is a test and I copied it from elsewhere. If I don't need it later I should delete it
