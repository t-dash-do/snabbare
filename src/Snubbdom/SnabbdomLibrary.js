const snabbdom = require('snabbdom');
const h = snabbdom.h;

const patch = snabbdom.init([
  require('snabbdom/modules/attributes').default,
  require('snabbdom/modules/props').default,
  require('snabbdom/modules/eventlisteners').default,
  require('snabbdom/modules/style').default,
]);

exports.querySelector_ = document.querySelector.bind(document);

exports.h_ = function(name, data, children) {
    const v = h(name, data, children);
    return v;
}

exports.patch_ = function(oldVnode, newVnode) {
    const p = patch(oldVnode, newVnode);
    return p;
}
exports.patchInit_ = exports.patch_;

exports.thunkSnabbdom_ = function(tag, key, thunk, args) {
    return snabbdom.thunk(tag, key, uncurry(thunk), args);
};

const uncurry = function(fn) {
  return function(...args) {
    return args.reduce((fn, arg) => fn(arg), fn);
  }
}

