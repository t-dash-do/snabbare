export const createModifier_ = function(type, key, value) {
    return { 
        type: type,
        key: key, 
        value: value 
    };
};

export const mapModifier_ = function(fn, modifier) {
    const type  = modifier.type;
    const key   = modifier.key;
    const value = modifier.value;

    switch (type) {
        case "form":
          switch (key) {
            case "input":
              return Object.assign({}, modifier, { value: (event) => () => fn(value(event)()) } );
            default:
              return Object.assign({}, modifier, { value: fn(value) });
            };

        case "mouse":
            return Object.assign({}, modifier, { value: fn(value) });
    };
    
    return modifier;
};

// UpdateAndView msg -> Array Modifier -> { attrs: , etc }
export const createSnubbdomModifiers_ = function(updateAndView, modifiers) {
    const snabbdomModifiers = modifiers.reduce(
        (acc, modifier) => createSnubbdomModifier(updateAndView, acc, modifier),
        {}
    );
    return snabbdomModifiers;
};

const createSnubbdomModifier = function(updateAndView, acc, modifier) {
    const type  = modifier.type;
    const key   = modifier.key;
    const value = modifier.value;

    const data = acc;
    switch (type) {
        case "attribute":
            data.attrs = data.attrs || {};
            data.attrs[key] = value;
            break;
        case "property":
            data.props = data.props || {};
            if (key === 'className') {
                if (data.props.className) {
                    data.props.className += ' ' + value;
                } else {
                    data.props.className = value;
                }
            } else {
                data.props[key] = value
            }
            break;
        case "key":
            data.key = value;
            break;
        case "form":
            data.on = data.on || {};
            data.on[key] = [callForm, updateAndView, value];
            break;
        case "mouse":
            data.on = data.on || {};
            data.on[key] = [callMouse, updateAndView, value];
            break;
        case "style":
            data.style = data.style || {};
            data.style[key] = value;
            break;
    }
    return data;
}

const callForm = function(send, fn, event) {
  send(fn(event)())();
};

const callMouse = function(send, msg, notUsed) {
  send(msg)();
};

