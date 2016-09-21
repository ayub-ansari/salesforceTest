/*
 * Mike Ulveling
 *
 * A framework for managing a hierarchy of custom Visualforce components in a page. Its aims are as follows:
 *   1. provide a clean API for each component (actions, elements, events)
 *   2. provide for easy traversal of the component tree via standard jQuery tree traversal methods (e.g. find, children, parents, etc)
 *   3. provide for easy callback binding to component events via the standard jQuery events API, plus a few additional convenience methods
 *   4. facilitate interactions between related components that may not be visible to each other in Visualforce markup (e.g. a RelatedList Edit 
 *      dialog that can rerender the associated Grid's data source upon save(); e.g. a grid component that has a column of edit links that each
 *      inkoke the load() method of an associated dialog component, passing an "itemId" parameter for the specific link clicked
 */
var $cnode;
(function($) {
    $cnode = Component;
    $cnode.page = $('<div id="page"/>');
    $cnode.root = $('<div id="root"/>').appendTo($cnode.page);
    
    function Component(selector) {
        // if a null, undefined, empty, or whitespace selector was passed, then default to the #root node:
        var startSet = $.trim(selector) ? $cnode.page.find(selector) : $cnode.root;
        if (!startSet.length)
            $.error('$cnode selector "' + selector + '" resulted in no matches');
            
        // process arguments after the 1st:
        var lvlExprs = [],
            apiMixins = {};
        for (var i=1; i < arguments.length; i++) {
            var arg = arguments[i];
            // if this is the last argument and it's an object, then interpret it as api mixin properties:
            if (i === arguments.length - 1 && arg !== null && typeof arg === "object")
                apiMixins = arg;
            // else if the arg is truthy, then interpret it as a level-expr after applying ECMAScript toString:
            else if (arg)
                lvlExprs.push("" + arg);
        }
        
        var resultSet = $();
        startSet.each(
            function() {
                var startElmt = $(this),
                    lvlNode = startElmt,
                    lvlParent,
                    lvlExpr;
                
                for (var i=0; i < lvlExprs.length; i++) {
                    lvlParent = lvlNode;
                    lvlExpr = lvlExprs[i];
                    lvlNode = lvlNode.children($cnode.lvlExprToSelector(lvlExpr));
                    // create the component node if it doesn't already exist:
                    if (!lvlNode.length)
                        lvlNode = $cnode.newComponentNode(lvlExpr).appendTo(lvlParent);
                    
                }
                
                // for the node corresponding to the last lvl-expr (or the start node if there were no lvl-expr's), mixin the outer call's apiMixins:
                $cnode.mixinApiProps(lvlNode, apiMixins);
                
                resultSet = resultSet.add(lvlNode);
            });
            
        // note that resultSet may have more than 1 element:
        $cnode.last = resultSet;
        return resultSet;
    }
    
    // e.g. takes "relatedList foo" and returns ".relatedList.foo"
    $cnode.lvlExprToSelector = function(lvlExpr) {
        if (!lvlExpr)
            return "";
            
        var classNames = lvlExpr.split(/\s+/);
        for (var i=0; i < classNames.length; i++) {
            if (!classNames[i])
                classNames.splice(i--, 1);
        }
        return "." + classNames.join(".");
    };
    
    $cnode.newComponentNode = function(lvlExpr) {
        var node = $('<div/>').addClass(lvlExpr);
        node.data("api", new ComponentNodeApi(node, lvlExpr));
        // add custom methods to the component node (which is an instanceof jQuery.fn):
        return node;
    };
    
    function applyNamespace(events, namespace) {
        var ns = "." + namespace;
        if (events)
            return String(events).trim().split(/\s+/).join(ns + " ") + ns;
        else
            return ns;
    }
    
    // add custom extensions to jQuery.fn:
    $.extend($.fn, {
            triggerBoth: function(evtType) {
                var extraArgs = [].slice.call(arguments, 1);
                $.fn.triggerHandler.apply(this, [evtType + ".self"].concat(extraArgs));
                return $.fn.trigger.apply(this, [evtType + ".delegate"].concat(extraArgs));
            },
            
            offOn: function(evtType) {
                $.fn.off.call(this, evtType);
                return $.fn.on.apply(this, [].slice.call(arguments));
            },
            
            offOnSelf: function(evtType) {
                return $.fn.offOn.apply(this, [applyNamespace(evtType, "self")].concat([].slice.call(arguments, 1)));
            },
            
            offOnDelegate: function(evtType) {
                return $.fn.offOn.apply(this, [applyNamespace(evtType, "delegate")].concat([].slice.call(arguments, 1)));
            },
            
            onSelf: function(evtType) {
                return $.fn.on.apply(this, [applyNamespace(evtType, "self")].concat([].slice.call(arguments, 1)));
            },
            
            onDelegate: function(evtType) {
                return $.fn.on.apply(this, [applyNamespace(evtType, "delegate")].concat([].slice.call(arguments, 1)));
            },
            
            getComponentApi: function() {
                return this.data("api");
            }
        });
    
    function ComponentNodeApi(node, lvlExpr) {
        this.node = node;
        this.lvlSelector = $cnode.lvlExprToSelector(lvlExpr);
        this.elements = {};
        this.actions = {};
    }
    
    ComponentNodeApi.prototype = {
            // returns a selector that will find this node when applied via either: $(fullPath), $cnode.page.find(fullPath),
            // (these 2 forms are equivalent):
            getFullPathSelector:
                function() {
                    var path = ["#root"];
                    if (!this.node.is("#root")) {
                        this.node.parentsUntil("#root").reverse().each(function() {
                                path.push($(this).data("api").lvlSelector);
                            });
                        path.push(this.lvlSelector);
                    }
                    return path.join(">");
                },
            
            getElements:
                function() {
                    var elmts = {};
                    for (var p in this.elements) {
                        var val = this.elements[p];
                        if (val)
                            // try to resolve anything that resembles a Visualforce-generated DOM-id into a DOM node:
                            if (typeof val === "string" && /^j_id\d\:/i.test(val)) {
                                var node = document.getElementById(val);
                                elmts[p] = node || val;
                            } else
                                elmts[p] = val;
                    }
                    return elmts;
                    /*
                    function compileElmts(destObj, srcObj) {
                        destObj = destObj || {};
                        srcObj = srcObj || {};
                        for (var p in srcObj) {
                            var srcVal = srcObj[p];
                            if ($.isPlainObject(srcVal))
                                destObj[p] = compileElmts({}, srcVal);
                            else if (typeof srcVal === "string")
                                destObj[p] = document.getElementById(srcVal);
                            else
                                destObj[p] = srcVal;
                        }
                        return destObj;
                    }
                    return compileElmts({}, this.elements);
                    */
                }
        };
    
    // mixin that recurses when the src and dest values for the same property are both plain objects;
    // takes any number of arguments; the 1st arg is the dest object and subsequent args are src object in order of increasing precedence;
    // when there are more than 2 arguments, the last arg may be an optional property filter function 
    // !! note the property filter ONLY applies to top-level properties
    $cnode.nestedMixin = function nestedMixin() {
        var dest = arguments[0] || {},
                lastArg = arguments[arguments.length - 1],
                propFilter;
        
        if (arguments.length > 2 && $.isFunction(lastArg))
            propFilter = lastArg;
        
        for (var i=1; i < arguments.length - (propFilter ? 1 : 0); i++) {
            var src = arguments[i] || {};
            for (var p in src) {
                if (propFilter && !propFilter(p))
                    continue;
                var destVal = dest[p],
                    srcVal = src[p];
                if ($.isPlainObject(destVal) && $.isPlainObject(srcVal))
                    nestedMixin(destVal, srcVal);
                // e.g. consider: 
                // var x={}, y={nestedObj:{foo:1}}, z={nestedObj:{foo:2}}; nestedMixin(x, y, x);
                // the following branch prevents the y.nestedObj object value reference from getting set into x.nestedObj and then having its nested
                // properties subsequently overwritten by those of z.nestedObj:
                else if ($.isPlainObject(srcVal))
                    dest[p] = nestedMixin({}, srcVal);
                else
                    dest[p] = srcVal;
            }
        }
        
        return dest;
    };
    
    $cnode.mixinApiProps = function(componentNode, props) {
        var componentApi = componentNode.getComponentApi();
        
        function reset(propName) {
            if (!propName || !(propName = $.trim("" + propName)))
                return false;
            propName = propName.toLowerCase();
            
            var resetWords = props.reset;
            
            if ($.isArray(resetWords)) {
                for (var i=0; i < resetWords.length; i++) {
                    if (word && (word = $.trim("" + word)))
                        resetWords[i] = word.toLowerCase();
                    else
                        resetWords.splice(i--, 1);
                }
            } else {
                if (!resetWords || !(resetWords = $.trim("" + resetWords)))
                    return false;
                    
                resetWords = resetWords.toLowerCase().split(/\s+/);
            }
            
            return resetWords.indexOf(propName) > -1 || resetWords.indexOf("*") > -1 || resetWords.indexOf("all") > -1;
        }
        
        if (reset("elements"))
            componentApi.elements = {};
        if (reset("actions"))
            componentApi.actions = {};
        
        if (props.elements && typeof props.elements === "object") // $.isPlainObject(props.elements))
            //componentApi.elements = $cnode.nestedMixin(componentApi.elements, props.elements);
            componentApi.elements = $.extend(componentApi.elements, props.elements);
        
        if (props.actions && typeof props.actions === "object") { // $.isPlainObject(props.actions)) {
            for (var actionName in props.actions) {
                var actionObj = props.actions[actionName];
                // if the action value is a plain function, then copy it over directly into the api.actions:
                if ($.isFunction(actionObj))
                    componentApi.actions[actionName] = actionObj;
                // else we assume it must be an object that has a "binding" prop; we create a wrapper function and write that into the api.actions:
                else {
                    componentApi.actions[actionName] = 
                        function(actionName, actionObj) {
                            // pluck out the A4J.Ajax.Submit wrapper function that the platform bound to this element's onfocus prop:
                            var bindingElmt = document.getElementById(actionObj.binding),
                                $elmt = $(bindingElmt),
                                func = $elmt.prop("onfocus");
                            
                            if (!$.isFunction(func))
                                throw Error("Expected an onfocus binding on: " + actionObj.binding);
                            
                            $elmt.prop("onfocus", null);
                            
                            // wrap the plucked function in this magic function that provides a more desireable action method interface:
                            return function(dynamicSubmitProps) {
                                    var stdSubmit = A4J.AJAX.Submit,
                                        formId, event, submitProps;
                                    
                                    // resolve the "before" property's value and call it if it's a function:
                                    // TODO: provide action-cancelling upon a false return value?
                                    var before = $cnode.nestedMixin({}, actionObj, dynamicSubmitProps, 
                                        function(p) {
                                            return p === "before";
                                        }).before;
                                    if ($.isFunction(before))
                                        before.call($cnode, componentNode, componentApi, dynamicSubmitProps);
                                    
                                    A4J.AJAX.Submit = function() {
                                        formId = arguments[0];
                                        event = arguments[1];
                                        submitProps = arguments[2];
                                    };
                                    func();
                                    
                                    $cnode.nestedMixin(submitProps, actionObj, dynamicSubmitProps, 
                                        function(p) {
                                            return /^(?:parameters|before|oncomplete|onbeforedomupdate)$/.test(p);
                                        });
                                    
                                    submitProps.parameters = submitProps.parameters || {};
                                    // late-resolve any "parameters" values that are functions:
                                    for (var p in submitProps.parameters) {
                                        var pval = submitProps.parameters[p];
                                        submitProps.parameters[p] = typeof pval === "function" 
                                                ? String(pval.call($cnode, componentApi, dynamicSubmitProps))
                                                : String(pval);
                                    }

                                    A4J.AJAX.Submit = stdSubmit;
                                    // give component users an easy hook to mutate submitProps, put up a blocking pane, etc:
                                    componentNode.triggerBoth("beforeAJAX." + actionName, submitProps);
                                    
                                    var clientDomupdate = submitProps.onbeforedomupdate;
                                    submitProps.onbeforedomupdate = function() {
                                        componentNode.triggerBoth("domUpdateAJAX." + actionName, submitProps);
                                        if ($.isFunction(clientDomupdate)) {
                                            clientDomupdate();
                                        }
                                    };
                                    
                                    var clientOncomplete = submitProps.oncomplete;
                                    submitProps.oncomplete = function() {
                                        componentNode.triggerBoth("afterAJAX." + actionName, submitProps);
                                        if ($.isFunction(clientOncomplete)) {
                                            clientOncomplete();
                                        }
                                        componentNode.triggerBoth("completeAJAX." + actionName, submitProps);
                                    };
                                    stdSubmit(formId, event, submitProps);
                                };
                        }(actionName, actionObj);
                }
            }
        }
    };
    
    // !! create an API object for the #root node:
    $cnode.root.data("api", new ComponentNodeApi($cnode.root, null));
})(jQuery);
