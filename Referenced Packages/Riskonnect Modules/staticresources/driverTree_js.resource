/* Mike Ulveling
   
    Requires a prior jQuery import
    See https://docs.google.com/a/riskonnect.com/document/d/1C40hsuoAPNo7ZBHe1TpkkcgVn0yVWjeyFwuZjZHwqAQ/edit for example usages.
   
    markup like this: 
    
    <name> sel
    
        <name> sel foo
            <name> foo
            <name> foo
            
            <name> sel foo-bar
                <name> foo-bar
        
        <name>
    
    combined with a script-specified tree object like this:
    
    {
        foo: {
            bar: {}
        }
    }
    
    will be expanded out into the following CSS classes by driverTree:
    
    <name> sel top root
    
        <name> sel top-inner root-foo parentKey-root root-dep
            <name> dep top-inner root-foo parentKey-root root-dep
            <name> dep top-inner root-foo parentKey-root root-dep
            
            <name> sel top-inner-inner root-foo-bar parentKey-root-foo root-dep
                <name> dep top-inner-inner root-foo-bar parentKey-root-foo root-dep
        
        <name> dep top root parentKey-root root-dep

    driverTree user set-able properties: 
        test [function], 
        inheritDriver [function; may not be used in conjunction with "test" nor "controlledBy"] 
        attachPoint [jQuery selector string],
        event [string],
        controlledBy [object | string],
        driverFinder [function($el) or jQuery selector string (for decendents), e.g. "select"], 
        attachPoint [function($el) or jQuery selector string (for closest parent), e.g. "tr"],
        defaultProps [object]
    
*/

var
driverTree;

(function ($) {
    
    var
    defaultGlobalDefaults = {
        test: function (val) {
            return /Yes/i.test(val);
        }, 
        event: "change", 
        driverFinder: 
            function ($el) { 
                if ($el.is(":input")) {
                    return $el;
                }
                var $sel = $el.find("select");
                if ($sel[0]) {
                    return $sel;
                }
                $sel = $el.find(":input");
                if ($sel[0]) {
                    return $sel;
                }
                $.error("Could not find driver for node [" + this.keyChain + "]");
            },
        attachPoint: null
    },
    globalDefaults = defaultGlobalDefaults,
    
    internalPropsSet = { __isNode: 1, __inheritDriver: 1, $sel: 1, selRef: 1, $controller: 1, controllerRef: 1, defaultProps: 1, isRoot: 1, levelNum: 1, key: 1, keyChain: 1, levelChain: 1, parent: 1, $dependents: 1 },
    
    userPropsSet = { 
        // must be a function:
        test: function (node, test) {
            if (!$.isFunction(test)) {
                $.error("Node [" + node.keyChain + "] specifies an invalid driver test (expected a function): " + test);
            }
        },
        // must be a function; takes precedence over test:
        inheritDriver: function(node, test) {
            if (!$.isFunction(test)) {
                $.error("Node [" + node.keyChain + "] specifies an invalid test for an inherited driver (expected a function): " + test);
            }
        },
        // must be an event-type string:
        event: function (node, eventType) {
            if (typeof eventType !== "string") {
                $.error("Node [" + node.keyChain + "] specifies an invalid driver event type: " + eventType);
            }
        },
        // must be a function or a jQuery selector string:
        driverFinder: function (node, finder) {
            if (typeof finder !== "string" && !$.isFunction(finder)) {
                $.error("Node [" + node.keyChain + "] specifies an invalid driver finder: " + finder);
            }
        },
        // must be null, a function, or a jQuery selector string:
        attachPoint: function (node, finder) {
            if (finder !== null && typeof finder !== "string" && !$.isFunction(finder)) {
                $.error("Node [" + node.keyChain + "] specifies an invalid CSS class parent-target finder: " + finder);
            }
        },
        // null, a string (jQuery selector or css class name), or an object that contains 1 of "name" or "selector", optionally a 
        // "dependentFinder" (filter function or jQuery selector), and optionally "controlledBy": 
        controlledBy: function (node, cb) {
            if (cb !== null && typeof cb !== "string" && !$.isPlainObject(cb)) {
                $.error("Node [" + node.keyChain + "] specifies an invalid controlledBy: " + cb);
            }
        },
        // a string constant (e.g. "driver"), a string jQuery selector, or a custom function: 
        focusOverride: function (node, focus) {
            if (focus !== null && typeof focus !== "string" && !$.isFunction(focus)) {
                $.error("Node [" + node.keyChain + "] specifies an invalid focusOverride: " + focus);
            }
        },
        domReady: function (node, callbackFunc) {
            if (!node.isRoot) {
                $.error("A domReady property on Node [" + node.keyChain + "] is invalid; this property may only be specified on a root node");
            }
            if (!$.isFunction(callbackFunc)) {
                $.error("Node [" + node.keyChain + "] specifies an invalid domReady: " + callbackFunc);
            }
        }
    },
    
    filterUserProps = function (props) {
        var userProps = {};
        if ($.isPlainObject(props)) {
            for (var key in props) {
                if (key in userPropsSet) {
                    userProps[key] = props[key];
                }
            }
        }
        return userProps;
    };
    
    driverTree = function(name, tree, scope) {
        if (tree === undefined)
            tree = {};
        
        if (!scope)
            scope = document;
        
        var
        defaultPropsStack = [globalDefaults],
        
        // calculates the full set of user-props into this node, filling in local and parent defaults where necessary:
        mergeUserProps = function (node) {
            // <this node's props> || <this node's default props> || <top of default props stack (i.e. parent's defaults)> 
            return $.extend(node, 
                defaultPropsStack[defaultPropsStack.length - 1],
                filterUserProps(node.defaultProps), 
                filterUserProps(node));
        },
        
        initNode = function (parent, _node, key, levelNum, levelChain, keyChain) {
            
            var node = _node;
            if (typeof _node === "string") {
                _node = [_node];
            } 
            
            if ($.isArray(_node)) {
                node = {};
                for (var i=0; i < _node.length; i++) {
                    node[_node[i]] = {};
                }
            }
            
            if (!$.isPlainObject(node)) {
                $.error("Unexpected type " + (typeof node) + " for node [" + keyChain + "]");
            }
            
            if ($.isPlainObject(node.defaultProps)) {
                if (node.defaultProps.inheritDriver) {
                    $.error("The 'inheritDriver' property cannot be set as an inherited default; node [" + keyChain + "]");
                }
                if (node.defaultProps.controlledBy) {
                    $.error("The 'controlledBy' property cannot be set as an inherited default; node [" + keyChain + "]");
                }
                if (node.defaultProps.domReady) {
                    $.error("The 'domReady' property cannot be set as an inherited default; node [" + keyChain + "]");
                }
            }
            
            node = mergeUserProps(node);
            if (parent != null) {
                // if we've converted this node from a plain-object type, we'll need to replace its reference on the parent node:
                parent[key] = node;
            }
            
            if (node.inheritDriver && node.controlledBy) {
                $.error("The 'inheritDriver' property cannot be used in conjunction with the 'controlledBy' property on a single node [" + keyChain + "]");
            }
            if (levelNum == 0 && node.inheritDriver) {
                $.error("The 'inheritDriver' property cannot be set on the root node");
            }
            
            node.__isNode = true;
            node.__inheritDriver = $.isFunction(node.inheritDriver);
            node.key = key;
            node.isRoot = levelNum === 0;
            node.levelNum = levelNum;
            node.parent = parent;
            node.levelChain = levelChain; // e.g. top-inner-inner
            node.keyChain = keyChain; // e.g. root-foo-bar
            
            for (var propKey in node) {
                if (propKey in userPropsSet) {
                    // validate each user-property:
                    userPropsSet[propKey](node, node[propKey]);
                } else if (!(propKey in internalPropsSet)) {
                    // combine the defaults from this node and the parent node's defaults; push the result onto the defaultPropsStack for use by the descendents of this node:
                    defaultPropsStack.push($.extend({}, defaultPropsStack[defaultPropsStack.length - 1], filterUserProps(node.defaultProps)));
                    
                    // this key is not a user nor internal prop, thus it defines a child node:
                    initNode(node, node[propKey], propKey, levelNum + 1, levelChain + "-inner", keyChain + "-" + propKey);
                }
            }
            
            // follow the controlledBy chain down to its last item; if that's a string then convert it to an object:
            var cbHolder = node,
                cb,
                processController = function(controlledBy) {
                    if (typeof controlledBy.selector !== "string") {
                        $.error("Node [" + node.keyChain + "] specified a controller picklist without a selector");
                    }
                    controlledBy.$controller = $(controlledBy.selector, scope);
                    if (!controlledBy.$controller[0]) {
                        $.error("Could not locate controller picklist [" + controlledBy.selector + "] specified for node [" + node.keyChain + "]");
                    } else if (!controlledBy.$controller.is("select")) {
                        $.error("The controller picklist [" + controlledBy.selector + "] specified for node [" + node.keyChain + "] is not the expected <select> element");
                    }
                    
                    controlledBy.controllerRef = {
                        // TODO: make controllerHolderFinder an optional property; for now we just use the direct parent:
                        $holder: controlledBy.$controller.parent()
                    };
                    
                    controlledBy.controllerRef.deref = $.proxy(
                        function () {
                            // TODO: make controllerFinder an optional property; for now we just assume we'll find it as 
                            // the first <select> within the $holder:
                            return this.$holder.find("select").first();
                        }, controlledBy.controllerRef);
                    
                    controlledBy.controllerRef.val = $.proxy(
                        function () {
                            var $c = this.deref();
                            //return $c && $c.is(":visible") ? $c.val() : undefined;
                            return $c ? $c.val() : undefined;
                        }, controlledBy.controllerRef);
                };
            
            while ($.isPlainObject(cb = cbHolder.controlledBy)) {
                processController(cb);
                cbHolder = cb.controlledBy;
            }
            // the last element of a controlledBy chain may optionally be a string (jQuery selector); if so then we'll convert it to a proper object:
            if (typeof cb === "string") {
                cbHolder.controlledBy = { selector: cb };
                processController(cbHolder.controlledBy);
            }
            
            // we're done processing all this node's children; pop the top off the defaultPropsStack:
            defaultPropsStack.pop();
            
            node.acceptVisit = function (visitor, context) {
                var cancel = false;
                if ($.isFunction(visitor.visitStart)) {
                    cancel = visitor.visitStart(node, context) === false;
                }
                if (!cancel) {
                    for (var key in node) {
                        var childNode = !(key in internalPropsSet) && !(key in userPropsSet) && node[key] && node[key].__isNode && node[key];
                        if (childNode) {
                            childNode.acceptVisit.call(childNode, visitor, context);
                        }
                    }
                    if ($.isFunction(visitor.visitEnd)) {
                        visitor.visitEnd(node, context);
                    }
                }
            };
            
            node.controllerVal = function () {
                if (!node.controlledBy) {
                    $.error("Cannot resolve controller value on a node [" + keyChain + "] that does not have a controller");
                }
                return node.controlledBy.controllerRef.deref().val();
            };
            
            return node;
        };
        
        tree = initNode(null, tree, "root", 0, "top", "root");
        
        var
        rootElementFinder = {
            visitStart: function (node) {
                if (node.isRoot) {
                    // the full scope of elements bound to any node in this tree, minus elements that we've already visited:
                    this.$rootEls = $("." + name, scope);
                    // root can process the remaining unclaimed nodes in its visitEnd:
                    return true;
                }
                
                // query elements bound to this node by using the tree name plus the keyChain with its leading "root-" prefix removed:
                var $nodeEls = $("." + name + "." + node.keyChain.replace(/^root\-/, ""), scope);
        
                // this node is not root, so therefore its elements are not root-level; remove them:
                this.$rootEls = this.$rootEls.not($nodeEls);
            }
        },
        
        // calculates the selRef and controllerRef properties along with the full style classes for each element; pushes style classes 
        // to an ancestor (attachPoint) element if necessary:
        postprocessVisitor = {
            visitStart: function (node, event) {
                var _this = this,
                    $nodeEls;
                
                if (node.isRoot) {
                    // an array of objects that each carry a $srcEl <jQuery-wrapped DOM node>, removeClasses <space-delimited CSS class name string>, 
                    // $attachEl <jQuery-wrapped DOM node>, and addCasses <space-delimited CSS class name string>:
                    this.classActions = [];
                    
                    // first step is to identify all the root-level elements:
                    tree.acceptVisit(rootElementFinder);
                    $nodeEls = rootElementFinder.$rootEls;
                } else {
                    // query elements bound to this node by using the tree name plus the keyChain with its leading "root-" prefix removed:
                    $nodeEls = $("." + name + "." + node.keyChain.replace(/^root\-/, ""), scope);
                }
                
                if (node.inheritDriver) {
                    // pull the driver and controller down from the immediate parent; move the inheritDriver function over to test:
                    node.test = node.inheritDriver;
                    node.$sel = node.parent.$sel;
                    node.selRef = node.parent.selRef;
                    node.$controller = node.parent.$controller;
                    node.controllerRef = node.parent.controllerRef;
                }
                $nodeEls.each(function (index, el) {
                    _this._setupClasses(node, el);
                });
            },
            
            visitEnd: function (node, event) {
                if (node.isRoot) {
                    $.each(this.classActions, function (index, obj) {
                        obj.$srcEl.removeClass(obj.classes + obj.extraRemoveClasses);
                    });
                    $.each(this.classActions, function (index, obj) {
                        obj.$attachEl.addClass(obj.classes);
                    });
                }
            },
            
            // Takes a tree node and a DOM element bound to that node; calculates and places the full suite of CSS classes needed by 
            // subsequent processes to efficiently identify specific sets of elements.
            // Also calculates the node's driver references $sel and selRef (use of $sel is deprecated in favor of selRef).
            _setupClasses: function (node, el) {
                var $el = $(el),
                    // if this node's driver is a controlled picklist, then we'll need to designate a holder to use as its proxy, because SFDC's poorly conceived and written 
                    // scripting logic sometimes clobbers is dependent picklists:
                    $selHolder,
                    classAction = { 
                        $attachEl: $el,
                        $srcEl: $el,
                        // the CSS classes we'll be adding to this element, e.g. "myTree top-inner-inner-inner root-foo-bar-baz sel root-dep", e.g. "myTree top root dep root-dep":
                        classes: name + " " + node.levelChain + " " + node.keyChain,
                        extraRemoveClasses: ""
                    };
                this.classActions.push(classAction);
                
                if (node.parent) {
                    classAction.classes += " parentKey-" + node.parent.keyChain;
                }
                
                if ($el.is(".sel")) {
                    if (node.inheritDriver) {
                        $.error("Node [" + node.keyChain + "] specifies an inherited driver, but discovered a non-inherited driver element");
                    }
                    
                    if (node.driverFinder) {
                        if ($.isFunction(node.driverFinder)) {
                            node.$sel = node.driverFinder($el);
                        
                        // jQuery selector string:
                        } else {
                            node.$sel = $el.find($.trim(node.driverFinder));
                        }
                    } else {
                        node.$sel = $el;
                    }
                    
                    if (!node.$sel) {
                        $.error("Node [" + node.keyChain + "] does not have a driver element");
                    }
                    
                    // if this node's driver is an SFDC dependent picklist, then we'll need to reference a holder of that picklist, rather than the <select> element itself:
                    if (node.controlledBy) {
                        if (!node.$sel.is("select")) {
                            $.error("Controlled driver for node [" + node.keyChain + "] was not the expected <select> element");
                        }
                        node.selRef = {
                            // TODO: in the future we might make "holderFinder" a configurable property of the controlledBy object; for now we just use the dependent 
                            //       <select>'s direct parent:
                                
                            // if the current $el contains the dependent picklist, then use that as the holder; otherwise use the picklist's immediate parent:
                            $holder: $selHolder = $el.has(node.$sel[0])[0] ? $el : node.$sel.parent()
                        };
                        node.selRef.deref = $.proxy(
                            function () {
                                // upon a deref request, we find the current incarnation of the dependent picklist by searching the holder's descendants:
                                var $matches = this.$holder.find("select");
                                return (node.controlledBy.dependentFinder ? $matches.filter(node.controlledBy.dependentFinder) : $matches).first();
                            }, node.selRef);
                        
                    // this node's driver is not an SFDC dependent picklist; we can safely reference the $sel directly (now and in the future) as it won't be 
                    // clobbered by SFDC's scripts:
                    } else {
                        node.selRef = {
                            deref: function () {
                                return node.$sel;
                            }
                        };
                    }
                    
                    classAction.classes = "sel " + classAction.classes;
                } else {
                    classAction.classes = "dep " + classAction.classes;
                }
                
                if (!node.isRoot || !$el.is(".sel")) {
                    classAction.classes += " root-dep";
                }
                
                if (!node.isRoot) {
                    //$el.removeClass(node.key);
                    classAction.extraRemoveClasses += " " + node.key;
                }
                
                if (node.attachPoint) {
                    // if we're migrating the CSS classes upwards to a distinct attach element, then we'll end up removing all such classes from the 
                    // source element to avoid subsequent ambiguities...
    
                    if ($.isFunction(node.attachPoint)) {
                        classAction.$attachEl = node.attachPoint.call(node, $el);
                            
                    // jQuery selector string:
                    } else {
                        classAction.$attachEl = $el.closest(node.attachPoint);
                    }
                } else if ($selHolder) {
                    classAction.$attachEl = $selHolder;
                } 
            }
        },
        
        logicVisitor = {
            visitStart: function (node, event) {
                if (node.isRoot) {
                    this.filter = "";
                    this.externalEvents = {};
                    this.focus = "default";
                    
                    this.customFocusNodes = [];
                    this.customFocusSelector = "";
                }
                
                var testResult = node.test(node.selRef.deref().val()),
                    // selectors for this node's deps and next level's sels:
                    selectors = [
                        "." + name + "." + node.levelChain + "." + node.keyChain + ".dep",
                        "." + name + "." + node.levelChain + "-inner" + ".parentKey-" + node.keyChain + ".sel"
                    ];
                
                if (!node.isRoot && event && node.selRef.deref().is(event.target)) {
                    this.customFocusNodes.push(node);
                    if (testResult) {
                        // focus on the first :input element that is (or is in) one of this node's deps or next level's sels:
                        // !! eliminated all :input atoms from this selector because they cause the query to be very slow in IE8; instead we use a 
                        // simpler selector and encapsulate the search-results-for-inputs logic in a function:
                        // this.customFocusSelector += (this.customFocusSelector.length === 0 ? "" : ", ") + [selectors[0] + ":input", selectors[0] + " :input", selectors[1] + ":input", selectors[1] + " :input"].join(", ");
                        this.customFocusSelector += (this.customFocusSelector.length === 0 ? "" : ", ") + [selectors[0], selectors[1]].join(", ");
                    }
                }
                
                if (!testResult) {
                    if (node.isRoot) {
                        this.filter = "none";
                    }
                    return false;
                }
                
                // this node's test passed; allow this node's deps and next node's sels:
                this.filter += (this.filter.length == 0 ? "" : ", ") + selectors.join(", ");
            },
            
            visitEnd: function (node) {
                if (node.isRoot) {
                    if (/^\s*$/.test(this.filter)) {
                        this.filter = "none";
                    } 
                    
                    if (node.focusOverride) {
                        this.focus = node.focusOverride;
                    } else {
                        // if 1 of more nodes uses the event's source element as driver, then we'll be setting a custom focus selector:
                        if (this.customFocusNodes.length > 0) {
                            // if none of these nodes qualified (i.e. all of their tests returned false) then just focus on the event driver element:
                            //this.focus = this.customFocusSelector.length > 0 ? this.customFocusSelector : "driver";
                            
                            if (this.customFocusSelector.length > 0) {
                                // !! I've changed this from a long input selector with :input -- to a function that executes a selector sans :input, followed 
                                // by iteration to find the :input. The all-in-one long selector ran WAY too slowly in IE8:
                                this.focus = $.proxy(
                                    function () {
                                        var inputSelector = "select, input[type=text], textarea, input[type=radio], input[type=checkbox], input[type=file]";
                                        $(this.customFocusSelector, scope).each(function () {
                                            var $el = $(this);
                                            if ($el.is(inputSelector)) {
                                                $el.focus();
                                                return false;
                                            } else {
                                                $el = $el.find(inputSelector);
                                                if ($el[0]) {
                                                    $el.focus();
                                                    return false;
                                                }
                                            }
                                        });
                                    }, this);
                                
                            } else {
                                this.focus = "driver";
                            }
                        }
                    }
                }
            }
        },
        
        externalEventsVisitor = {
            visitStart: function (node) {
                var _this = this,
                    addEventMember = function (eventType, $el, deferredEvent, deferredEventTargetRef) {
                        if (deferredEvent) {
                            var origEventType = eventType;
                            eventType = "deferred_" + eventType;
                            // have uiManager's initDriver bind to the "deferred_<eventType>" while here we bind to the "real" event type
                            // and setup a timout to trigger the "deferred_<eventType>". this has the effect of pushing the driver's rerender
                            // down to the end of the Javascript execution queue, which is what we need in the case of events tied to SFDC 
                            // controller picklists (since we need to give SFDC time to update its controlled picklists upon a controller's 
                            // change event): 
                            $el.bind(origEventType, function () {
                                window.setTimeout(function () { deferredEventTargetRef.deref().trigger(eventType); }, 0);
                            });
                        }
                        
                        if (!_this.externalEvents[eventType]) {
                            _this.externalEvents[eventType] = $el;
                        } else {
                            _this.externalEvents[eventType] = _this.externalEvents[eventType].add($el);
                        }
                    };
            
                if (node.isRoot) {
                    this.externalEvents = {};
                
                // don't double-bind (or multi-bind) to an inherited driver; it's already been bound to for a parent node! 
                } else if (!node.inheritDriver) {
                    // if this node's driver is an SFDC controlled picklist (its selRef will have a $holder in that case), then 
                    // bind the external event to the designated "holder" of that picklist:
                    addEventMember(node.event, node.selRef.$holder ? node.selRef.$holder : node.selRef.deref());
                }
                
                // both root and non-root nodes can be controlled by 1 or more SFDC controller picklists -- add an external event for each
                // such controller:
                if (node.controlledBy) {
                    var cbHolder = node, cb;
                    while ($.isPlainObject(cb = cbHolder.controlledBy)) {
                        // add an external event on the SFDC controller picklist, but if this controller is in turn controlled by 
                        // another controller, then we'll have to go through its "holder" proxy:
                        if ($.isPlainObject(cb.controlledBy)) {
                            addEventMember("change", cb.controllerRef.$holder, true, cb.controllerRef);
                        } else {
                            addEventMember("change", cb.$controller, true, { deref: (function (cb) { return function () { return cb.$controller; } })(cb) });
                        }
                        cbHolder = cb;
                    }
                }
            }
        };
        
        tree.acceptVisit(postprocessVisitor);
        tree.acceptVisit(externalEventsVisitor);
        
        var dependentsSelector = "." + name + ".root-dep",
            $rootDriver = tree.selRef.$holder ? tree.selRef.$holder : tree.selRef.deref(),
            $treeDeps;
        
        if ($.isFunction(tree.domReady)) {
            $rootDriver.on("rerenderDomReady", tree.domReady);
        }
        
        // if the root node has a controlledBy property, then we should bind to the driver's holder rather than directly to the driver element itself -- 
        // the logic visitor knows how to derefence the holder in these scenarios:
        _uiManager.initDriver(
            $rootDriver, 
            // we wrap the dependentsSelector in this function because we want to enforce the given scope:
            function() {
                //console.log(dependentsSelector);
                //console.log($(dependentsSelector, scope));
                return $(dependentsSelector, scope);
            },
            //dependentsSelector, 
            function(event) {
                // Upon initialization, we build the full set of dependent elements under this tree -- before they are managed/removed by the logic.
                // Note that tree.$dependents will be used as the scope for the logicVisitor's resolveSelectors function (this way we can execute 
                // the selectors without worrying abound which dependents are in/out of the doc at that time)!
                if (!$treeDeps) {
                    $treeDeps = $(dependentsSelector, scope);
                }
                tree.acceptVisit(logicVisitor, event);
                return { filter: logicVisitor.filter, focus: logicVisitor.focus };
            },
            // add an external event handler on the "change" event of the inner driver: 
            { externalEvents: externalEventsVisitor.externalEvents });
        
        driverTree.lastTree = tree;
        return driverTree;
    };
    
    driverTree.defaultGlobalDefaults = defaultGlobalDefaults;
    
    driverTree.setGlobalDefaults = 
        function(newDefaultProps) {
            if (newDefaultProps.controlledBy) {
                $.error("controlledBy is not allowed as a default property");
            }
            if (newDefaultProps.inheritsDriver) {
                $.error("inheritDriver is not allowed as a default property");
            }
            globalDefaults = $.extend({}, globalDefaults, filterUserProps(newDefaultProps));
            return driverTree;
        }

})(jQuery);


