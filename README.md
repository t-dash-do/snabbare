# Purescript-Snubbdom

![GitHub](https://img.shields.io/github/license/aryzach/purescript-snabbdom)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/aryzach/purescript-snabbdom)
[![Pursuit](https://pursuit.purescript.org/packages/purescript-snabbdom/badge)](https://pursuit.purescript.org/packages/purescript-snabbdom)
[![Maintainer: aryzach](https://img.shields.io/badge/maintainer-aryzach-blue)](https://github.com/aryzach)

A type-safe library wrapper for Snubbdom, a virtual DOM library.

[Docs](https://pursuit.purescript.org/packages/purescript-snubbdom)


### The general use of this library: 
- build up an `Element` which constists of 
  * an HTML tag 
  * an array of 'modifiers' which consists of both HTML attributes and DOM properties
  * and an array of child Elements
- call elementToSnubbdomVNode with
  * the Element created above
  * function that takes any message (generally a custom sum type) and updates application state and renders that updated state
- call patch with
  * the output of elementToSnubbdomVNode
  * and the previous output of elementToSnubbdomVNode from a prior application state

### Examples
To see an example, run `make build-input-example` then `make run-input-example`, then go to `localhost:8080`
Following the Dockerfile-example file, you can see how to go from `spago init` to using this library in a project

