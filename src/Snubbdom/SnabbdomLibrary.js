import * as snabbdom from 'snabbdom';
const h = snabbdom.h;

const patch = snabbdom.init([
  require('snabbdom/modules/attributes').default,
  require('snabbdom/modules/props').default,
  require('snabbdom/modules/eventlisteners').default,
  require('snabbdom/modules/style').default,
]);

export const querySelector_ = document.querySelector.bind(document);

export const h_ = function(name, data, children) {
    const v = h(name, data, children);
    return v;
};

export const patch_ = function(oldVnode, newVnode) {
    const p = patch(oldVnode, newVnode);
    return p;
};

export const patchInit_ = patch_;

export const thunkJavascript_ = function(tag, key, thunk, args) {
    return snabbdom.thunk(tag, key, uncurry(thunk), args);
};

const uncurry = function(fn) {
  return function(...args) {
    return args.reduce((fn, arg) => fn(arg), fn);
  }
}

