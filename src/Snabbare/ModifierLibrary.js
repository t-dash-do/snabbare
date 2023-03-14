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
export const createSnabbareModifiers_ = function(updateAndView, modifiers) {
    const snabbareModifiers = modifiers.reduce(
        (acc, modifier) => createSnabbareModifier(updateAndView, acc, modifier),
        {}
    );
    return snabbareModifiers;
};

const createSnabbareModifier = function(updateAndView, acc, modifier) {
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
        case "messageHook":
            data.hook = data.hook || {};

            let f = () => {
                updateAndView(value)();
                return null;
            }

            if (!(key in data)){
                data.hook[key] = f
            } else {
                data.hook[key] = () => {
                    data.hook[key]();
                    f();
                    return null;
                }
            }
        case "form":
            data.on = data.on || {};
            data.on[key] = event => updateAndView(value(event)())()
            break;
        case "mouse":
            data.on = data.on || {};
            data.on[key] = () => updateAndView(value)();
            break;
        case "style":
            data.style = data.style || {};
            data.style[key] = value;
            break;
    }
    return data;
}