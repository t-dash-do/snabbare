import {
  init,
  classModule,
  propsModule,
  attributesModule,
  styleModule,
  eventListenersModule,
  h,
} from "snabbdom";

const patch = init([
  classModule,
  propsModule,
  attributesModule,
  styleModule,
  eventListenersModule,
]);
export const querySelector_ = query => {
    return document.querySelector.call(document, query);
}

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

// export const JsElementDecorator = x => x.toVnode();
