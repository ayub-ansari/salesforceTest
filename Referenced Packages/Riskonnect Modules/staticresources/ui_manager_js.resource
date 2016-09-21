/*
 * Mike Ulveling
 * Version 1.06 -- Rewrote "suppressFormActionKeys" to be more efficient and work better with IE8
 * Version 1.05 -- Added functionality for "enhancedDatepickers" (jquery-ui datepicker widget, with hierarchical options) to replace the SFDC picker
 *                 Replaced the old "killBubbleKeyEvents" methods with the superior "suppressFormActionKeys". 
 *                 Removed the behavior where a return-keydown event was handled to imitate the tab-key, for select and certain <input> elements.
 *                 Added a "shellReady" queue.
 * Version: 1.04 -- fixed Date picker positioning in method "moveSalesforceDatePicker"
 *
 * This could stand some cleanup as of Nov. 06, 2011
 */

var fadeSpeed = 400;

// TODO: use the jQuery.proxy method instead:
// The .bind method from Prototype.js -- here we name it "hitch" (ala dojo toolkit, which I'm trying to move away from) so as not to confuse with 
// jQuery's "bind" method, which does something completely different:
if (!Function.prototype.hitch) { // check if native implementation available
    Function.prototype.hitch = function () { 
        var fn = this, args = Array.prototype.slice.call(arguments), object = args.shift(); 
        return function(){ 
            return fn.apply(object, 
            args.concat(Array.prototype.slice.call(arguments))); 
        }; 
    };
}

function UIManager(shellType, isPortalUI){
    this.construct(shellType, isPortalUI);
}
UIManager.instance = null;
UIManager.bypassInit = false;

// shellType: standalone|nestedHeader|nestedSidebarHeader|nestedHeaderSidebar
UIManager.prototype.construct = function (shellType, isPortalUI) {
    UIManager.instance = this;
    this.shellType = shellType;
    this.isPortalUI = isPortalUI;
    // for functions that need to be queue'd up until a signal is given:
    this.queues = {
        // queue up functions -- via queue -- until the sfdcPage is ready (at which time the array of functions will be replaced with true).
        // the default/start state here is "queue":
        sfdcPageReady: [],
        // queues up functions until the shell widgets (e.g. scrollWidget) have been initialized and taken their proper place in the DOM:
        shellReady: [],
        // queue up functions -- upon onStartAction, this is converted to an array that subsequent function requests will be queued into. 
        // upon onCompleteAction, the queue is flushed and this value will return to the flag "true" (indicating that subsequent function 
        // requests may execute immediately).
        // IMPORTANT: for now, the dialog submit actions (submitDialog, fireDialogSubmitFinished) also attach to this queue -- I haven't 
        // fully determined yet whether they should have their own queue.
        // the default/start state here is "ready":
        completeAction: true
    };
    this.attachToWindowOnload();
    if (!UIManager.bypassInit) {
        dojo.addOnLoad(/^Nested/i.test(this.shellType) ? UIManager.initNestedShell : UIManager.initStandaloneShell);
    }
}

/*
// IMPORTANT! attach to AFTER the current window.onload function, so that we may detect when the sfdcPage (if any) is ready -- actions like 
// jController.driver* can cause problems for the sfdcPage if they are invoked before the sfdcPage's init sequences (e.g. dependent picklist init)
UIManager.oldWindowOnload = window.onload;
window.onload = function () {
    $.isFunction(UIManager.oldWindowOnload) ? UIManager.oldWindowOnload() : null;
    UIManager.instance.signalQueueReady('sfdcPageReady');
}
*/

UIManager.prototype.attachToWindowOnload = function () {
    //console.log(UIManager.onloadHandlers ? UIManager.onloadHandlers.new : '<none>');
    //console.log(window.onload);
    // IMPORTANT! attach to AFTER the current window.onload function, so that we may detect when the sfdcPage (if any) is ready -- actions like 
    // jController.driver* can cause problems for the sfdcPage if they are invoked before the sfdcPage's init sequences (e.g. dependent picklist init)
    if (!UIManager.onloadHandlers || UIManager.onloadHandlers["new"] !== window.onload) {
        UIManager.onloadHandlers = {
            "old": window.onload,
            "new": function () {
                $.isFunction(UIManager.onloadHandlers.old) ? 
                        UIManager.onloadHandlers.old.call($.isFunction(document.body.bodyOnLoad) ? document.body : window) : null;
                UIManager.instance.signalQueueReady('sfdcPageReady');
            }
        }
        window.onload = UIManager.onloadHandlers["new"];
    }
}

UIManager.prototype.queue = function (queueName, func) {
    if (typeof func === "function") {
        typeof this.queues[queueName].length === "number" ? this.queues[queueName].push(func) : func();
    }
}

// super-cool comboQueue executes the requested func only when ALL of the listed queues are ready (e.g. we typically need to execute jController 
// driverInits when both 'sfdcPageReady' and 'completeAction' queues are ready, in order to give the sfdc page a chance to run its scripts to
// initialize dependent picklists):
UIManager.prototype.comboQueue = function (queueNames, func) {
    var queueNameToStatus = {},
        // flag to make really sure we don't execute func twice:
        executedFunc = false;
    // initialize the status to false for all queues; this MUST be completed before we attempt to start queueing the comboFuncs, in
    // order to avoid erroneous multiple executions of func:
    for (var i=0; i < queueNames.length; i++) {
        queueNameToStatus[queueNames[i]] = false;
    }
    for (var i=0; i < queueNames.length; i++) {
        // each target queue will get its own instance of comboFunc, which will set the status for that queue to "true" and then 
        // re-check to see whether all queues are now ready (and execute the client func if so):
        newComboFunc = function (thisQueueName) {
            return function () {
                var allQueuesReady = true;
                queueNameToStatus[thisQueueName] = true;
                for (qn in queueNameToStatus) {
                    if (!queueNameToStatus[qn]) {
                        allQueuesReady = false;
                    }
                }
                if (allQueuesReady && !executedFunc) {
                    executedFunc = true;
                    func();
                }
            };
        };
        this.queue(queueNames[i], newComboFunc(queueNames[i]));
    }
}

UIManager.prototype.signalQueueReady = function (queueName) {
    var oldQueue = this.queues[queueName];
    // signal that subsequent function requests into this queue may now execute immediately:
    this.queues[queueName] = true;
    // flush the queue:
    while (oldQueue.length) {
        oldQueue.shift()();
    }
}

UIManager.prototype.queueOnSfdcPageReady = function (func) {
    this.queue('sfdcPageReady', func);
}

UIManager.prototype.queueOnCompleteAction = function (func) {
    this.queue('completeAction', func);
}

UIManager.prototype.queueOnSfdcPageReadyAndCompleteAction = function (func) {
    this.comboQueue(['sfdcPageReady', 'completeAction'], func);
}

UIManager.prototype._superInit = function(){
    if (typeof(ModalDialogController) != 'undefined'){
        // instantiate the modal dialog controller:
        this.modalDialogController = ModalDialogController.getInstance(this);
    }
}

UIManager.prototype._assertPropExists = function(propertyChain){
    var props = dojo.string.splitEscaped(propertyChain, '.');
    var nextProp = this;
    for (var i=0; i < props.length; i++){
        nextProp = nextProp[props[i]];
        if (typeof(nextProp) == 'undefined'){
            $.error('Illegal access on ' + propertyChain + ' of UIManager - this property has not been instantiated');
            break;
        }
    }
}

UIManager.prototype._getProp = function(propertyChain, assertExists){
    if (assertExists){
        this._assertPropExists(propertyChain);
    }
    var props = dojo.string.splitEscaped(propertyChain, '.');
    var nextProp = this;
    for (var i=0; i < props.length; i++){
        nextProp = nextProp[props[i]];
        if (typeof(nextProp) == 'undefined'){
            return undefined;
        }
    }
    return nextProp;
}

UIManager.prototype.getMainLayoutWidget = function(){
    return this.getRootLayoutWidget();
}

UIManager.prototype.layout = function () {
    if (this.readyForLayout) {
        this.getRootLayoutWidget()._layout();
    }
}

UIManager.prototype.initInlineHelp = function () {
    this.queueOnSfdcPageReady(function () {
        var $tip = $("<div class='sfdc-tooltip'/>")
            .css({ visibility: "visible", display: "none" })
            .appendTo(document.body);
        $(".helpOrb,.rk-helpOrb").each(function() {
            var $this = $(this),
                sfdc = $this.is(".helpOrb"),
                $helpButton = $this.closest(sfdc ? ".helpButton" : ".rk-helpButton"),
                helpKey, $newOrb, helpText;
                
            if ($helpButton[0]) {
                
                if (sfdc) {
                    $helpButton.removeClass("helpButton").addClass("rk-helpButton");
                    helpKey = $helpButton.attr("id").replace(/\-\_help$/i, "");
                    $helpButton.attr("id", null);
                    $newOrb = $("<img src='/s.gif'/>")
                        .addClass("rk-helpOrb")
                        .insertAfter(this);
                    $this.remove();
                    helpText = sfdcPage.inlineHelpMap[helpKey];
                } else {
                    $newOrb = $this;
                    helpText = $helpButton.attr("jLabel-help");
                    if (!helpText || /^\s*$/.test(helpText)) {
                        $newOrb.hide();
                        return;
                    }
                }
                
                $helpButton.add($newOrb)
                    .bind("mouseover", function () {
                        $helpButton.removeClass("rk-helpButton").addClass("rk-helpButtonOn");
                    })
                    .bind("mouseout", function () {
                        $helpButton.removeClass("rk-helpButtonOn").addClass("rk-helpButton");
                    });
                    
                $newOrb.tooltip({
                        tip: $tip,
                        position: ["bottom", "left"],
                        effect: "fade",
                        offset: [0, 0]
                    }).dynamic();
                    
                $newOrb.tooltip()
                    .onBeforeShow(function() {
                        $tip.text(helpText);
                    });
            }
        });
    });
}

//TODO: refactor this file to use this method more
UIManager.prototype.$scrollable = function () {
    var $scroll;
    if (($scroll = $("#formInnerScroll, .rk-scrollable").not("rk-noscroll").filter(":visible").first())[0]) {
        return $scroll;
    }
    return $(this.scrollWidget.domNode);
}

UIManager.scrollToDefaults = function () {
    return {
        duration: 500,
        offset: 0,
        smartAlign: true // MDU -- this flag is for a custom modification I made to the scrollTo plugin
    };
};
// TODO: refactor this file to use this method more:
UIManager.prototype.scrollTo = function () {
    var args = [],
        $scrollable = this.$scrollable();
    args.push(arguments[0]);
    if (typeof arguments[2] === "object" && arguments[2]) {
        args.push(arguments[1]);
        args.push($.extend({}, UIManager.scrollToDefaults(), arguments[2]));
    } else if (typeof arguments[1] === "object" && arguments[1]) {
        args.push($.extend({}, UIManager.scrollToDefaults(), arguments[1]));
    } else {
        args.push($.extend({}, UIManager.scrollToDefaults()));
    }
    $scrollable.scrollTo.apply($scrollable, args);
}

// performs jController validation in the scope of the main form, writing an error summary out to the specified dedicated dialog:
UIManager.prototype.validate = function (successFunction, targetDialogKey) {
    var args = Array.prototype.slice.call(arguments),
    opts = {
        uiManager: this,
        failure: (function (uiManager) {
            return function ($err, $ok) {
                uiManager.layout();
            };
        })(this)
    };
    if ($.isFunction(args[0])) {
        opts.success = args[0];
    }
    opts.finished = opts.success ? args[2] : args[1];
    if (!$.isFunction(opts.finished)) {
        delete opts.finished;
    }
    targetDialogKey = opts.success ? args[1] : args[0];
    if (typeof targetDialogKey == "string") {
        if (!this.getDialogProps(targetDialogKey, false)) {
            $.error('UIManager.validate could not find the specified dialog: [' + targetDialogKey + ']');
        }
        opts.targetDedicatedDialog = targetDialogKey;
    }
    $('form').jController("validate", opts);
}

// performs jController validation in the scope of the currently active dialog, writing an error summary into a '.dynamicContentToken' element on that dialog:
UIManager.prototype.validateActiveDialog = function (successFunction, dynamicContentTokenFilter) {
    var args = Array.prototype.slice.call(arguments),
        opts = {
            uiManager: this,
            // don't bother writing the field block errors for an inline dialog:
            appendError: function (fieldErrorInfo) {},
            clearError: function (fieldBlock) {}
        };
    if ($.isFunction(args[0])) {
        opts.success = args[0];
    }
    dynamicContentTokenFilter = opts.success ? args[1] : args[0];
    opts.targetActiveDialog = $.isFunction(dynamicContentTokenFilter) ? dynamicContentTokenFilter : true;
    // set the validate's scope to the dialog's inner contents:
    $(this.getActiveDialog().$dialogBaz()).jController('validate', opts);
}

UIManager.driverInitDefaults = function () {
    return {
        eventType: 'change',
        animate: true,
        fadeSpeed: 500,
        // rerenderDialogFx: "slide",
        scroll: $.extend({}, UIManager.scrollToDefaults(), {offset: 0}),
        highlight: {
            color: 'rgb(255,248,175)' /*, persistDuration: 2000, fadeDuration: 1500*/,
            selector: function ($shows) {
                //return $shows.find('td').add($shows.find(':input:not(select):not(:hidden)'));
                return $shows.find('td,th[scope=row]').add($shows.find('input[type=text],textarea')); //.filter(":visible"));
            }
        }
    };
};

UIManager.prototype.initControlledDriver = function (controller, driver, dependents, displayLogic, options) {
    var resolveSelector = function (selector) {
            return $($.isFunction(selector) ? selector() : selector);
        },
        $driver = resolveSelector(driver),
        $correctedDriver = $();
    // caller should have sent in the parents of <select> elements, but if they didn't then correct it for them:
    $driver.each(
        function () {
            $correctedDriver = $correctedDriver.add($(this).is('select') ? $(this).parent() : this);
        });
    this.initDriver($correctedDriver, dependents, 
        function () {
            var $select = $(this).find('select:visible').first(),
                val = $select.val();
            return displayLogic.call(this, val, $select[0]);
        },
        $.extend({}, {externalEvents: {"change": controller}}, options)
    );
};

UIManager.prototype.initMultiselectDriver = UIManager.prototype.initMultiSelectDriver = function (driver, dependents, displayLogic, options) {
    var resolveSelector = function (selector) {
            return $($.isFunction(selector) ? selector() : selector);
        },
        $driver = resolveSelector(driver),
        $correctedDriver = $();
    // caller should have sent in the parents of <select> elements, but if they didn't then correct it for them:
    $driver.each(
        function () {
            if ($(this).is('select:visible')) {
                return;
            }
            $correctedDriver = $correctedDriver.add($(this).is('select') ? $(this).parent() : this);
        });
    this.initDriver($correctedDriver, dependents, 
        function () {
            var $select = $(this).find('select:not(:visible)').first(),
                val = $select.val();
            return displayLogic.call(this, val, $select[0]);
        },
        $.extend({}, {
                eventType: null, 
                externalEvents: {
                    dblclick: $correctedDriver.find('select[id$=_unselected], select[id$=_selected]'),
                    click: $correctedDriver.find('td.multiSelectPicklistCell')
                }
            }, 
            options)
    );
};

// convenience method that uses the jController plugin's 'driver*' methods to implement custom field-drivers:
// TODO: make the final 'driverClearHiddenDependents' action an overridable option
UIManager.prototype.initDriver = function (driver, dependents, displayLogic, options) {
    
    // we wrap this functionality in an anonymous function (hitch'ng it to the "this" reference) and queue on the combo of 'sfdcPageReady' AND 
    // 'completeAction', because e.g. sfdc picklists must be init'd before we might potentially be taking them out of the DOM due to the driver's display logic:
    this.queueOnSfdcPageReadyAndCompleteAction($.proxy(function () {
    // this.queueOnSfdcPageReady((function () {
        var uiManager = this,
            resolveSelector = function (selector) {
                return $($.isFunction(selector) ? selector() : selector);
            },
            $driver = resolveSelector(driver),
            driverEventNS = $.jController.driverEventNS,
            $dependents = resolveSelector(dependents),
            driverOptions = $.extend({}, UIManager.driverInitDefaults(), options, {displayLogic: displayLogic}),
            parentDialogKey = $driver.parents().filter('.DialogOuterBar[dialogKey]').attr('dialogKey'),
            scroll, hlightOpts, $hlightNodes,
            highlightColor = 'rgb(255,250,175)'; // 'rgb(254, 254, 200)'; // 'rgb(255,255,205)'
        
        /* Dec 2011 -- Removed the dialog-specific fade-out/reLayout/fade-in behavior upon a driver event, and re-coded it directly into the jController driverRerender method.
         * This is far superior because it allows for this animation effect to be cancelled by an "abort" flag from the displayLogic function, or if there are no
         * show/hide elements for a given rerender (also bypasses this effect if animate==false, e.g. in an initial rerender).
         * TODO: Consider adding in the flash highlighting effect, during or after the fade-in...
         * 
        if (parentDialogKey) {
            // the driver is in a dialog; apply the desired behaviors for this situation:
            // TODO: can we do anything about this if eventType is not specified?
            if (driverOptions.eventType) {
                // hack hack hack -- here we want to fade out the dialog before we enact the driver's jController.rerender changes. however, we can't 
                // do our fade effect in a rerenderStarted handler because that won't block the subsequent shows/hides; the shows/hides will
                // process immediately, which will make for a less-than-smooth animation effect. To get around this, we hijack the driver's 
                // eventType specified in the options (e.g. usually 'change' for a <select> driver). We hijack it by prepending "delayed__"
                // to its name and then sending that as the eventType passed to jController['driverInit'] (e.g. 'delayed__change') -- so the
                // "delayed_*" eventType, when triggered, will invoke the usual jController.rerender logic. Then, we bind our own custom handler to 
                // the original eventType, which will first fade-out the active dialog, and then trigger the "delayed__*" eventType when that
                // is done. 
                var originalEventType = driverOptions.eventType;
                // console.log('dialog: ' + parentDialogKey);
                $driver.
                    bind(originalEventType + driverEventNS, function () { // here is our custom handler for the hijacked original eventType:
                        var delayedTriggerEvent = 'delayed__' + originalEventType + driverEventNS;
                        $driver.one(delayedTriggerEvent, function () {
                            $driver.jController('driverRerender', {
                                animate: false,
                                fadeSpeed: driverOptions.fadeSpeed
                            });
                        });
                        // TODO: try to cleanup/refactor this logic a bit...make a method to retrieve dialogScope info, etc...
                        var dialogInstance = uiManager.getDialogManagerByKey(parentDialogKey);
                        if (dialogInstance && dialogInstance.isContentActive) {
                            // the dialog is active; fade it out and then trigger the usual jController.rerender logic when that is done:
                            $(dialogInstance.dialogWidget.domNode).animate({opacity: 0}, driverOptions.fadeSpeed).promise().done(function () {
                                // console.log('finished delay...');
                                $driver.triggerHandler(delayedTriggerEvent);
                            });
                        } else {
                            // if the dialog is not currently active then skip the fade effect and immediately trigger the usual jController.rerender:
                            $driver.triggerHandler(delayedTriggerEvent);
                        }
                    }).
                    bind('rerenderFinished' + driverEventNS, function (event, rerenderId) {
                        var dialogInstance = uiManager.getDialogManagerByKey(parentDialogKey);
                        // if the dialog is not currently active then skip this final reLayout/reCenter & fade-in:
                        if (dialogInstance && dialogInstance.isContentActive) {
                            dialogInstance.reRender();
                            $(dialogInstance.dialogWidget.domNode).animate({opacity: 1}, driverOptions.fadeSpeed);
                        }
                    });
                // disable the original event handler:
                driverOptions.eventType = null;
            }
        }
        */
            
        // detect whether this element has already been initialized as a driver; destroy the old instance if so:
        var driverExists;
        if (options && options.reInit && (driverExists = $driver.jController("driverExists"))) {
            if ($driver.size() > 1) {
                $.error("Cannot re-initialize multiple jController drivers at once");
            }
            if (!/ignore/i.test(options.reInit)) {
                $driver.jController("driverDestroy");
            }
        } else if (driverExists) {
            $.error("jController driver has already been initialized");
        }
        
        var focusFx = function (rerenderContext) {
                var directives = rerenderContext.directives,
                data = rerenderContext.driverData,
                dependents = rerenderContext.driverDependents,
                focusSel = directives.focus;
            window.setTimeout(function () {
                // the function form is used by driverTree:
                if ($.isFunction(focusSel)) {
                    focusSel();
                } else {
                    if (!focusSel || focusSel === 'default' || focusSel === 'first') {
                        // default behavior: focus on the first visible input dependent:
                        var $deps = $(dependents),
                            inputSelector = 'input[type=text],input[type=radio],input[type=checkbox],textarea,select';
                        $deps
                            .find(inputSelector)
                            .add($deps.filter(inputSelector))
                            .filter(":visible")
                            .first()
                            .focus();
                    } else if (focusSel === 'driver') {
                        rerenderContext.$driver.focus();
                    } else if (focusSel !== 'none') {
                        $(focusSel).first().focus();
                    }
                }
            }, 0);
        };
        if (parentDialogKey) {
            // the driver is in a dialog; apply the desired behaviors for this situation:
            $driver.
                bind('rerenderAfterDomVisible' + driverEventNS, function (event, rerenderContext) {
                    focusFx(rerenderContext);
                });
        } else {
            // the driver is not in a dialog; apply the desired behaviors for a driver in the main form:
            scroll = $.extend({}, UIManager.driverInitDefaults().scroll, 
                    // MDU -- this flag is another custom modification I made to the scrollTo plugin -- here, by default we don't allow the scroll 
                    // action to push the driver field's top edge above the scrollable (viewport):
                    //{smartAlignTopEdgePredicate: driver}, options.scroll),
                    {smartAlignTopEdgePredicate: function () {return $(driver).parent();}}, options ? options.scroll : null);
            hlightOpts = $.extend({}, UIManager.driverInitDefaults().highlight, options ? options.highlight : null);
            $hlightNodes = function ($shows) {
                var $nodes;
                if (hlightOpts.selector) {
                    if ($.isFunction(hlightOpts.selector)) {
                        $nodes = $(hlightOpts.selector($shows));
                    } else {
                        $nodes = $(hlightOpts.selector);
                    }
                }
                return $nodes;
            };
            $driver.
                bind('rerenderDomReady' + driverEventNS, function (event, rerenderContext) {
                    uiManager.layout();
                }).
                bind('rerenderBeforeShowAnim' + driverEventNS, function (event, rerenderContext) {
                    if (rerenderContext.animate) {
                        var $hnodes = $hlightNodes(rerenderContext.$shows);
                        // !! try to store the result of this expensive search for subsequent re-use by rerenderAfterShowAnim:
                        rerenderContext._$hnodes = $hnodes;
                        // immediately halt any running animations (jumping to their ending style values) on the target highlight 
                        // nodes and the dependents to be shown, before we start the new fade-in and highlighting animations:
                        $hnodes.add(rerenderContext.$shows)
                            .stop(true, true);
                        $hnodes
                            .jController('highlight', $.extend({}, hlightOpts, {effect: 'on', color: highlightColor}));
                        // TODO: should the foxusFx call be in the scroll's onAfter event?
                        uiManager.scrollTo(rerenderContext.$shows.last(), $.extend({}, scroll, { onAfter: function () { focusFx(rerenderContext); } }));
                    } else {
                        delete rerenderContext._$hnodes;
                    }
                }).
                bind('rerenderAfterShowAnim' + driverEventNS, function (event, rerenderContext) {
                    if (rerenderContext.animate) {
                        // !! try to re-use the _$hnodes from a prior rerenderBeforeShowAnim:
                        (rerenderContext.$highlights = rerenderContext._$hnodes ? rerenderContext._$hnodes : $hlightNodes(rerenderContext.$shows))
                            .jController('highlight', $.extend({}, hlightOpts, {effect: 'flash', color: highlightColor, queueFlashEffects: true}));
                    }
                }).
                bind('rerenderFinished' + driverEventNS, function (event, rerenderContext) {
                    // nothing, for now...
                });
        }
        return $driver.
            jController('driverInit', driverOptions).
            jController('driverDependents', $dependents).
            jController('driverRerender', {animate:false}).
            jController('driverClearHiddenDependents');
    }, this));
}

/* These are not trivial options :(
 * opts {
 *     dialogKey -- String, required, the dialogKey for the lookup's search dialog instance
 *     
 *     // TODO: DEPRECATED:
 *     isManualMode -- Boolean, required
 *     
 *     mode -- String, none|manual|lookup; defaults to none
 *     lookupId -- String, only applicable if mode=="lookup"
 *     lookupsSearchable -- Boolean, defaults to false
 *     lookupsSticky -- Boolean, defaults to false
 *     
 *     driverSelector -- element/jQuery/selector, required 
 *     TODO: Consider modifying jController driver to be able to better find detached dependents (i.e. not just with a hash-selector)
 *     manualSelector -- string selector, optional, defaults to empty-string -- IMPORTANT: this MUST be a string selector that will work on detached dependent elements
 *     lookupSelector -- string selector, optional, defaults to empty-string -- IMPORTANT: this MUST be a string selector that will work on detached dependent elements
 *     commonSelector -- string selector, optional, defaults to empty-string -- IMPORTANT: this MUST be a string selector that will work on detached dependent elements
 *     mixinDestVforceIds -- String, comma-delimited string of fully-Qualified Vforce Ids
 *     scrollToTepSelector -- element/jQuery/selector, optional, the common top edge for scroll operations, defaults to the driver element
 *     highlightSelectorFunc -- function, 1-arg $shows, optional, defaults to function ($shows) {return $shows.find('td');}
 *     get_af_rolodexItemSelected -- function, required, must return an actionFunction reference when invoked
 *     itemAccepted -- Boolean, defaults to false
 *     itemAcceptedHighlightSelector -- element/jQuery/selector, optional, defaults to $(opts.commonSelector).add(opts.lookupSelector).add(opts.manualSelector).find('td')
 *     itemAcceptedScrollToSelector -- element/jQuery/selector, optional, defaults to $(opts.commonSelector).add(opts.lookupSelector).add(opts.manualSelector).last()
 *     itemAcceptedScrollToTepSelector -- element/jQuery/selector, optional, defaults to $(opts.driverSelector)
 *     
 *     searchLabel -- string; the label applied to the driver picklist's search-option
 *     manualLabel -- string; the label applied to the driver picklist's manual-option, when this option applies AND the promptForChangeLabel does not apply
 *     promptForEntryLabel -- string; the label applied to the driver picklist's none-option, when that option is applicable
 *     promptForChangeLabel -- string; the label applied to the driver picklist's manual-option when there is a search and/or rolodex option AND lookupsSticky==false 
 *                             (i.e. when manual is the defacto mode but the user has non-sticky "prefill" options available)
 *     onPromptForEntry -- function, should show a "Please enter <entity> according to the options below:" label and show the driver picklist in the DOM; 
 *                         will be called at the appropriate times
 *     onPromptForChange -- function, should show a "You may change the <entity> via the options below:" label and show the driver picklist in the DOM; 
 *                          will be called at the appropriate times
 *     onExclusiveManualMode -- function, should hide the driver picklist and all associated instructional labels (i.e. as described in onPromptForEntry and
 *                              onPromptForChange) in the DOM; will be called at the appropriate times
 *     rerenderDomReady -- function to be called in the jController.driver's rerenderDomReady event
 * }
 */
UIManager.prototype.initMultiModeLookup = function (options) {
    var uiManager = this,
        isNotBlank = function (val) {
            return val && (typeof val != "string" || ($.trim(val) != "" && $.trim(val).toLowerCase() != "null"));
        },
        isBlank = function (val) {
            return !isNotBlank(val);
        },
        // deletes properties from an object that are null or blank, so that they may be overridden via jQuery.extend:
        deleteProps = function (holderObj, targetPropsObj, deleteBlanksToo) {
            for (var key in targetPropsObj) {
                if (holderObj[key] == null || (deleteBlanksToo && isBlank(holderObj[key]))) {
                    delete holderObj[key];
                }
            }
        },
        opts,
        $allDependents,
        // upon driver initialization, and each time the driver option is changed by the user, we rebuild the driver picklist's
        // non-rolodex options to better reflect the current state/context (e.g. don't show the 'none' option when it's not necessary,
        // don't show the manual option when manaul-mode is the defacto default, don't show the search option when 
        // lookupsSearchable==false, etc).
        // newModeInfo: {
        //     mode -- string, none|lookup|manual
        //     lookupId -- string, a valid salesforce SObject Id, only applicable if mode=="lookup"
        // }
        rebuildPicklist = function (driver, newModeInfo) {
            var rolodexSize = 0,
                $driver = $(driver),
                // conditionally add the serach option to the driver:
                addSearchIfSearchable = function () {
                    if (opts.lookupsSearchable) {
                        $driver.append($('<option value="search" />').
                                append($('<span>&raquo;&nbsp;</span>')).append($('<span/>').text(opts.searchLabel)));
                    }
                },
                // add the manual option to the driver:
                addManual = function (morphToChangeOption) {
                    var manualOption = $('<option value="manual" />').
                            append($('<span>&raquo;&nbsp;</span>')).append($('<span/>').text(morphToChangeOption ? opts.promptForChangeLabel : opts.manualLabel));
                    morphToChangeOption ? $driver.prepend(manualOption) : $driver.append(manualOption);
                };
            // clear out all non-rolodex options (i.e. none, search, manual):
            $driver.find('option').each(function () {
                var $this = $(this),
                    val = $.trim($this.val().toLowerCase());
                if (val == "" || val == "none" || val == "search" || val == "manual") {
                    $this.remove();
                } else {
                    rolodexSize++;
                }
            });
            if (newModeInfo.mode == "none") {
                // we can assume there are options other than 'manual' (otherwise the mode would've been bumped to 'manual' by the server-side 
                // MultiModeLookup logic), i.e. lookup search and/or rolodex items
                $driver.prepend($('<option value="none" />').text(opts.promptForEntryLabel));
                addSearchIfSearchable();
                addManual(false);
                // call the "onPromptForEntry" callback to show the "Please enter the <entity>..." label and un-hide the driver picklist block:
                opts.onPromptForEntry();
            } else if (newModeInfo.mode == "manual") {
                if (!opts.lookupsSearchable && rolodexSize == 0) {
                    // add only the manual option -- it's necessary so that the "manual" value can be selected in the driver:
                    addManual(false);
                    // call "onExclusiveManualMode" callback to hide all instructional labels and hide the driver picklist block:
                    opts.onExclusiveManualMode();
                } else {
                    if (opts.lookupsSticky) {
                        // we use the usual driver picklist options, minus the "none" option:
                        addSearchIfSearchable();
                        addManual(false);
                        // call "onPromptForChange" callback to show the "You may change the <entity>..." label and un-hide the driver picklist block:
                        opts.onPromptForChange();
                    } else {
                        // here, we modify the manual option slightly:
                        addManual(true);
                        addSearchIfSearchable();
                        // call "onPromptForChange" callback to show the "You may change the <entity>..." label and un-hide the driver picklist block:
                        opts.onPromptForChange();
                    }
                }
            } else { // actually, don't limit this to just lookup mode -- make it the default behavior, in order to allow custom modes: // else if (newModeInfo.mode == "lookup") {
                // we can assume lookupsSticky==true and that there is at least 1 LookupRolodexItem, selected for this "lookup" mode
                addSearchIfSearchable();
                addManual(false);
                // call "onPromptForChange" callback to show the "You may change the <entity>..." label and un-hide the driver picklist block:
                opts.onPromptForChange();
            }
            // IMPORTANT! There is an obscure bug in IE9 not covered by jQuery; in certain (rare) circumstances, the <select> element's selected value can get 
            // internally out of sync with the child <option>'s selected value; a mere property access of the <select>'s selectedIndex or value will "snap" it 
            // back into sync. This is important before calling jQuery.val(newVal), because that method only works at the <option> level in most cases:
            var foo = $driver[0] && $driver[0].value; // do NOT remove; it is NOT redundant -- see above
            // ensure that the new mode is selected in the driver picklist:
            $driver.val(newModeInfo.mode == "lookup" ? newModeInfo.lookupId : newModeInfo.mode);
        };
    
    // the following properties should be defaulted if they're currently undefined, null or a blank string -- we achieve this by undefining 
    // each such property and then invoking $.extend:
    options = $.extend({}, options);
    deleteProps(options, {mode:1,lookupsSearchable:1,lookupsSticky:1,
        searchLabel:1,manualLabel:1,promptForEntryLabel:1,promptForChangeLabel:1,
        onPromptForEntry:1,onPromptForChange:1,onExclusiveManualMode:1,rerenderDomReady:1}, true);
    // the following properties should be defaulted if they're currently undefined or null -- we achieve this by undefining 
    // each such property and then invoking $.extend:
    deleteProps(options, {manualSelector:1,lookupSelector:1,commonSelector:1,scrollToTepSelector:1}, false);
    if (isBlank(options.driverSelector)) {
        $.error('A driverSelector is required for initMultiModeLookup');
    }
    // set the defaults for all presently undefined properties:
    opts = $.extend({
        mode: 'none',
        lookupsSearchable: false,
        lookupsSticky: false,
        manualSelector: '',
        lookupSelector: '',
        commonSelector: '',
        scrollToTepSelector: function () { return $(opts.driverSelector).parent(); }, // options.driverSelector,
        searchLabel: 'Search',
        manualLabel: 'Manual Input',
        promptForEntryLabel: 'Please Choose:',
        promptForChangeLabel: 'Change To:',
        onPromptForEntry: function () {},
        onPromptForChange: function () {},
        onExclusiveManualMode: function () {},
        rerenderDomReady: function () {}
    }, options);
    // 2nd round of defaulting for optional selectors that default to combinations of other optional selectors:
    deleteProps(opts, {itemAcceptedHighlightSelector:1,itemAcceptedScrollToSelector:1,itemAcceptedScrollToTepSelector:1}, true);
    $allDependents = function () {
        return $(opts.commonSelector).add(opts.lookupSelector).add(opts.manualSelector);
    }
    opts = $.extend({
        // wrap the selector logic in a function because we want to delay execution until after the initDriver call -- we don't want to risk 
        // highlighting hidden nodes; this can corrupt their background color.
        // the defaults should include the manaulSelector, because virtual rolodex items will accept a match and then bump to manual mode:
        itemAcceptedHighlightSelector: function () {
            return $allDependents().find('td:visible').add($allDependents().find('td :input:not(select):not(:hidden)'));
        },
        itemAcceptedScrollToSelector: $allDependents().find('td:visible').last(),
        itemAcceptedScrollToTepSelector: function () { return $(opts.driverSelector).parent(); } // $(opts.driverSelector)
    }, opts);
    if (opts.lookupsSearchable && isBlank(opts.dialogKey)) {
        $.error('A dialogKey is required for initMultiModeLookup');
    }
    // console.log(opts.itemAcceptedHighlightSelector);
    
    // if the highlightSelector is not blank but not a function, then treat it as a plain selector and convert it to its function equivalent:
    if (isNotBlank(opts.highlightSelectorFunc) && !$.isFunction(opts.highlightSelectorFunc)) {
        opts.highlightSelectorFunc = (function (plainSelector) {
            return function () {
                return $(plainSelector);
            };
        })(opts.highlightSelectorFunc);
    } else if (isBlank(opts.highlightSelectorFunc)) {
        // the highlightSelector is blank; default it to a function that returns descendents td elements for all shown dependents:
        opts.highlightSelectorFunc = function ($shows) {
            return $shows.find('td').add($shows.find('td :input:not(select):not(:hidden)'));
        };
    }
    // initialize the driver picklist's contextual options, and val:
    rebuildPicklist($(opts.driverSelector)[0], {
        mode: $.trim(opts.mode.toLowerCase()),
        lookupId: opts.lookupId
    });
    
    // script to set the driver's initial value, as calculated by the relevant instance of MultiModeLookup:
    // TODO: for now we have to assume the values 'manual' and ' ':
    // $(opts.driverSelector).val(opts.isLookupMode ? opts.lookupId : (opts.isManualMode ? 'manual' : ' '));
    
    this.initDriver(opts.driverSelector, $(opts.commonSelector).add(opts.manualSelector).add(opts.lookupSelector), 
        // this function should return a filter (function|selector|'all'|'none') that applies against the driver's dependents:
        function () {
            var $this = $(this), 
                data = $this.data("muliModeLookupOldVal"),
                val = $this.val() ? $this.val() : '',
                isNone = $.trim(val) == "" || val == "none",
                isManual = val == "manual",
                isSearch = val == "search",
                isRolodexLookupItem = !isNone && !isManual && !isSearch,
                filter = 'none',
                isInitialization = data === undefined,
                abort = false,
                // used to contextually reconstruct the driver picklist:
                newModeInfo,
                // map of an event key: ("mmlChangeToManual", "mmlManualMode", "mmlItemAccepted") to a function that will trigger that event (if that event is applicable) -- 
                // note that "mmlBeforeChangeToManual" is triggered separately so that it may optionally cancel the manual-mode action:
                stateTriggers = {
                    events: [],
                    add: function(eventName) {
                        this.events.push(eventName);
                    },
                    fire: function() {
                        var evts = this.events.join(" "),
                            $driver = $(opts.driverSelector);
                        $.each(evts.split(/\s+/), function(index, event) {
                            if (event) {
                                $driver.trigger(event);
                            }
                        });
                    }
                };
                
            if (isInitialization) {
                data = {oldValue: val};
                $this.data("muliModeLookupOldVal", data);
                if (opts.itemAccepted) {
                    stateTriggers.add("mmlItemAccepted");
                }
            } else {
                if (!isSearch) {
                    data.oldValue = val;
                }
                if (isSearch) {
                    $this.val(data.oldValue);
                    // abort driver rerender; instead execute an action to open the LookupSearch Dialog:
                    abort = function () {
                        // {!incidentForm.postalLookup.search.dialogProps.openScript}
                        uiManager.openDialog(opts.dialogKey);
                    };
                } else if (isRolodexLookupItem) {
                    // abort driver rerender; instead execute the rolodexItemSelected action on MultiModeLookup:
                    abort = function () {
                        _uiManager.onStartAction('Loading ' + $this.find('option:selected').text() + '...');
                        // {!incidentForm.postalLookup.af_rolodexItemSelected}(val, opts.mixinDestVforceIds);
                        // console.log('rolodex rerender: ' + opts.mixinDestVforceIds);
                        opts.get_af_rolodexItemSelected()(val, opts.mixinDestVforceIds);
                    };
                }
            }
            if (!abort) {
                if (isManual) {
                    if (isInitialization || $(opts.driverSelector).triggerHandler("mmlBeforeChangeToManual") !== false) {
                        filter = function() { 
                            //return $(this).is(opts.commonSelector + ',' + opts.manualSelector);
                            return $(this).is(opts.commonSelector) || $(this).is(opts.manualSelector); 
                        };
                        stateTriggers.add((!isInitialization ? "mmlChangeToManual " : "") + "mmlManualMode");
                    } else {
                        abort = true;
                    }
                } else if (isRolodexLookupItem) {
                    // this branch can only be invoked upon driver initialization; otherwise a postback to af_rolodexItemSelected is necessary:
                    filter = function () { return $(this).is(opts.commonSelector) || $(this).is(opts.lookupSelector) };
                } else {
                    filter = 'none';
                }
            }
            // refresh the driver's picklist options according to the current state/context:
            newModeInfo = {
                mode: $.trim($this.val()).toLowerCase()
            };
            if (newModeInfo.mode == "") {
                newModeInfo.mode = "none";
            }
            if (newModeInfo.mode != "none" && newModeInfo.mode != "search" && newModeInfo.mode != "manual") {
                newModeInfo.mode = "lookup";
                newModeInfo.lookupId = $this.val();
            }
            rebuildPicklist(this, newModeInfo);
            return {
                filter: filter,
                // filter: 'all', // for testing...
                abort: abort,
                // trigger which events are applicable out of "mmlChangeToManal", "mmlManualMode", and "mmlItemAccepted" -- 
                // note that "mmlBeforeChangeToManal" is fired above, so that it may optionally cancel the manual-mode:
                afterDomReady: function() {
                    stateTriggers.fire();
                }
            };
        }, {
            rerenderDomReady: opts.rerenderDomReady,
            scroll: {
                // set the input field block as the predicate rather than the select, for a result that's more flush with the viewport:
                smartAlignTopEdgePredicate: opts.scrollToTepSelector
            },
            highlight: {
                selector: opts.highlightSelectorFunc
            }
        }
    );
    if (opts.itemAccepted) {
        $(opts.driverSelector).trigger("mmlItemAccepted");
        var dialogKey = $(opts.driverSelector).parents().filter('.DialogOuterBar[dialogKey]').attr('dialogKey'),
            dialogInstance,
            highlightSelFunc = function () {
                return $.isFunction(opts.itemAcceptedHighlightSelector) ? $(opts.itemAcceptedHighlightSelector()) : $(opts.itemAcceptedHighlightSelector);
            },
            highlightFxAction = function () {
                highlightSelFunc().jController('highlight');
            },
            focusAction = function () {
                // TODO: make this a configurable attribute/param -- for now we just focus on the first visible input within the highlight selections:
                window.setTimeout(function () {highlightSelFunc().filter(':visible:input').add(highlightSelFunc().find(':visible:input')).first().focus();}, 0);
            };
        // Dec 2011 -- rewrote this to branch behaviors depending on whether the driver resides in a dialog or not:
        if (!dialogKey) {
            // the following logic only applies to MML's that are NOT in a dialog:
            this.layout();
            this.queueOnSfdcPageReadyAndCompleteAction(function () {
                // console.log(opts.itemAcceptedHighlightSelector);
                highlightFxAction();
                focusAction();
                // console.log(opts.itemAcceptedScrollToSelector);
                // console.log('start scroll [' + opts.itemAcceptedScrollToSelector + '], [' + opts.itemAcceptedScrollToTepSelector + ']');
                uiManager.scrollTo(opts.itemAcceptedScrollToSelector, {
                    smartAlignTopEdgePredicate: opts.itemAcceptedScrollToTepSelector
                });
            });
        } else {
            // for dialogs -- do a one-time bind to the "contentVisible" dialog event, for the highlight fx (no scroll for dialogs):
            dialogInstance = uiManager.getDialogManagerByKey(dialogKey);
            if (dialogInstance) {
                dialogInstance.one('contentVisible', function () {
                    highlightFxAction();
                    focusAction();
                });
            }
        }
    }
}

UIManager.prototype.getRootLayoutWidget = function(assertExists){
    return this._getProp('rootLayout', assertExists);
}

UIManager.prototype.getScrollWidget = function(assertExists){
    return this._getProp('scrollWidget', assertExists);
}

UIManager.prototype.getStatusMessageWidget = function(assertExists){
    return this._getProp('widgets.statusMessage.widget', assertExists);
}

UIManager.prototype.getSubmitBlockingPaneWidget = function(assertExists){
    return this._getProp('widgets.submitBlockingPane.widget', assertExists);
}

UIManager.prototype.getTimedStatusMessageWidget = function(assertExists){
    return this._getProp('widgets.timedStatusMessage.widget', assertExists);
}

UIManager.prototype.getDialogControlsWidget = function(assertExists){
    return this._getProp('widgets.dialogControls.widget', assertExists);
}

UIManager.prototype.getDialogProps = function(dialogKey, assertExists){
    return this._getProp('widgets.dialogs.' + dialogKey, assertExists);
}

UIManager.prototype.getDialogWidget = function(dialogKey, assertExists){
    return this._getProp('widgets.dialogs.' + dialogKey + '.widget', assertExists);
}

UIManager.prototype.getModalDialogController = function(assertExists){
    return this._getProp('modalDialogController', assertExists);
}

/* Modal dialog methods: */

UIManager.prototype.getActiveDialog = function(){
    return this.getModalDialogController(true).getActiveDialog();
}

UIManager.prototype.getActiveDialogManager = function(){
    return this.getModalDialogController(true).getActiveDialog();
}

UIManager.prototype.isDialogActive = function (dialogManagerInstance) {
    return this.getActiveDialogManager() === dialogManagerInstance;
}

UIManager.prototype.getDialogManagerByKey = function(dialogKey){
    // pass in dialogProps as the 2nd arg, because this getDialog call might cause the VForceDialogManager to be constructed:
    return this.getModalDialogController(true).getDialog(dialogKey, this.getDialogProps(dialogKey, true));
}

/* Call this to put ordered arguments in place, to be consumed/used by the actionFunction call of a submit or a delayed-open dialog action: */
UIManager.prototype.setDialogActionArgs = function () {
    this._dialogActionArgs = Array.prototype.slice.call(arguments);
}

//TODO: refactor:
UIManager.prototype.openDialog = function(/*String*/ dialogKey, /*{action:"", message:"", shortMessage:""}*/ loadActionOpts){
    if (this.getTimedStatusMessageWidget()){
        this.getTimedStatusMessageWidget().hide();
    }
    this.getModalDialogController(true).open(dialogKey, loadActionOpts);
    /*
    var dialogProps = this.getDialogProps(dialogKey, true); // this.widgets.dialogs[dialogKey];
    var dialogManager = this.getModalDialogController(true).activateDialog(dialogKey, dialogProps);
    
    if (this.getSubmitBlockingPaneWidget()){
        $(this.getSubmitBlockingPaneWidget().domNode).addClass('forDialog').fadeIn(fadeSpeed ? fadeSpeed : 'slow');
    }
    
    if (loadActionOpts) {
        loadActionOpts.actionArgs = this._dialogActionArgs;
        this._dialogActionArgs = null;
    }
    dialogManager.open(loadActionOpts);
    */
}

UIManager.prototype.reRenderDialog = function(animateOpts){
    var dialog;
    if (dialog = this.getActiveDialogManager()) {
        dialog.reLayout(true);
        window.setTimeout(function () {dialog.reCenter(animateOpts)}, 0);
    }
}

UIManager.prototype.reCenterDialog = function(animateOpts){
    var dialog;
    if (dialog = this.getActiveDialogManager()) {
        dialog.reCenter(animateOpts);
    }
}

UIManager.prototype.reLayoutDialog = function(recalcContentSize){
    var dialog;
    if (dialog = this.getActiveDialogManager()) {
        dialog.reLayout(recalcContentSize);
    }
}

// opts: {
//     String|Function action,
//     Object<default=window> scope,
//     Boolean<default=true> submitDialogWithForm, 
//     String message,
//     String shortMessage
// }
UIManager.prototype.submitDialog = function(opts) {
    this.queues['completeAction'] = [];
    if (opts) {
        opts.actionArgs = this._dialogActionArgs;
        this._dialogActionArgs = null;
    }
    this.getActiveDialogManager().submit(opts);
}

// you may pass in leaveUpBlockingPane=true if you wish for the blocking pane to remain active, even if this is the last open dialog to be 
// closed down - this can be useful for when you need to fire off a server action (e.g. apex:actionFunction) that should also block off the
// interface upon close of this dialog (e.g. MassEdit's Save-Changes/Discard-Changes dialog in front of a sort|setPage|setPageSize action): 
UIManager.prototype.closeDialog = function(leaveUpBlockingPane){
    this.getModalDialogController(true).close(leaveUpBlockingPane);
}

UIManager.prototype.closeAllDialogs = function(){
    this.getModalDialogController(true).closeAll();
}

UIManager.prototype.blockDialog = function(mode){
    if (this.getActiveDialogManager()) {
        this.getActiveDialogManager().block(mode);
    }
}

UIManager.prototype.unblockDialog = function(){
    if (this.getActiveDialogManager()) {
        this.getActiveDialogManager().unblock();
    }
}

UIManager.prototype.putDialogContentTokens = function() {
    this._dialogContentTokens = Array.prototype.slice.call(arguments);
}

UIManager.prototype.fireDialogContentsLoaded = function(){
    this.getActiveDialogManager().fireContentsLoaded();
    // this._consumePendingInnerScrollRefresh(false);
    this.layout();
}

UIManager.prototype.fireDialogSubmitFinished = function(){
    this.signalQueueReady('completeAction');
    this.getActiveDialogManager().fireSubmitFinished();
    // this._consumePendingInnerScrollRefresh(false);
    this.layout();
}

UIManager.prototype.setDialogFocusFieldDomId = function(dialogKey, domId){
    // If the modalDialogController hasn't been instantiated yet, then the page hasn't finished loading. this will happen during
    // initial load of the (garbage) dialog contents. Since we don't care about these contents, this call can be safely ingnored:
    if (!this.getModalDialogController()) { return; }
    //TODO: refactor getDialogInstance to take a dialogKey
    this.getDialogManagerByKey(dialogKey).setFocusFieldDomId(domId);
}

UIManager.prototype.signalDialogSubmitSuccess = function(dialogKey){
    // If the modalDialogController hasn't been instantiated yet, then the page hasn't finished loading. this will happen during
    // initial load of the (garbage) dialog contents. Since we don't care about these contents, this call can be safely ingnored:
    if (!this.getModalDialogController()) { return; }
    this.getDialogManagerByKey(dialogKey).signalSubmitSuccess();
}

UIManager.prototype.signalDialogSubmitFailure = function(dialogKey){
    // If the modalDialogController hasn't been instantiated yet, then the page hasn't finished loading. this will happen during
    // initial load of the (garbage) dialog contents. Since we don't care about these contents, this call can be safely ingnored:
    if (!this.getModalDialogController()) { return; }
    this.getDialogManagerByKey(dialogKey).signalSubmitFailure();
}

UIManager.prototype.signalFreshDialogContentsReady = function(dialogKey){
    if (!this.getModalDialogController()) { return; }
    this.getDialogManagerByKey(dialogKey).signalFreshDialogContentsReady();
}

UIManager.prototype.setDialogTitleDomId = function(dialogKey, dialogTitleDomId){
    if (!this.getModalDialogController()) { return; }
    this.getDialogManagerByKey(dialogKey).setTitleDomId(dialogTitleDomId);
}

UIManager.prototype.processKeyDown = function(e){
    var keynum;
    var keychar;
    if(window.event){ // IE
        keynum = e.keyCode;
    }
    else if(e.which){ // Netscape/Firefox/Opera
        keynum = e.which;
    }
    if (keynum == 13){
        return false;
    }
    return true;
}

/* Returns a JQuery of elements that have been tagged for scroll-to functionality, when they appear (i.e. after a rerender): */
UIManager.scrollToJQuery = function () {
    return $("#formInnerScroll .uiManager_scrollToMax, #formInnerScroll .uiManager_scrollTo");
}

UIManager.prototype.onStartAction = function(/*String*/ loadingMessage){
    var modelDialogCntrl, activeDialog;
    // start queueing function requests into the 'completeAction' queue:
    this.queues['completeAction'] = [];
    if(this.getTimedStatusMessageWidget()) {
        this.getTimedStatusMessageWidget().hide();
    }
    // below, we branch behaviors based on whether a dialog is currently active or not:
    if (activeDialog = (modelDialogCntrl = this.getModalDialogController()) && modelDialogCntrl.getActiveDialog()) {
        // a dialog is currently active; render the status message into its body:
        activeDialog.startMessageMode({message: loadingMessage});
    } else {
        // no dialog is active; update/render the status message on the main layout:
        if (this.getStatusMessageWidget()){
            this.getStatusMessageWidget().setMessage(loadingMessage);
            this.getStatusMessageWidget().show();
        }
        if (this.getSubmitBlockingPaneWidget()){
            dojo.html.removeClass(this.getSubmitBlockingPaneWidget().domNode, 'forDialog');
            this.getSubmitBlockingPaneWidget().show();
        }
        this.getRootLayoutWidget(true)._layout();
    }
    
    // TODO: should probably remove the following code?:
    /*
    // look for, and store, any elements that are tagged with a "scroll-to" style class (i.e. .uiManager_scrollTo or .uiManager_scrollToMax):
    this._prevScrollToElements = UIManager.scrollToJQuery();
    */
}

//you may pass in leaveUpBlockingPane=true if you wish for the blocking pane to remain active after hiding the status message:
UIManager.prototype.onCompleteAction = function(leaveUpBlockingPane) {
    var modelDialogCntrl, activeDialog;
    // execute all accumulated function requests in the 'completeAction' queue; flush the queue and signal it ready for the immediate execution of 
    // subsequent requsts:
    this.signalQueueReady('completeAction');
 
    // TODO: we should consider the removal of this:
    this._jqueryElementSetup();
    
    if (this.getStatusMessageWidget()){
        this.getStatusMessageWidget().hide();
    }
    
    // below, we branch behaviors based on whether a dialog is currently active or not:
    if (activeDialog = (modelDialogCntrl = this.getModalDialogController()) && modelDialogCntrl.getActiveDialog()) {
        // a dialog is currently active; hide its status message and re-render its contents into its body:
        // TODO: should the value of expectsNewDialogContents be configurable via an options parameter?
        activeDialog.finishMessageMode({expectsNewDialogContents: true});
    } else {
        // no dialog is active; hide the status message on the main layout:
        if (!leaveUpBlockingPane && this.getSubmitBlockingPaneWidget()){
            this.getSubmitBlockingPaneWidget().hide();
        }
        // this._consumePendingInnerScrollRefresh(false);
        this.layout();
    }
    // TODO: should probably remove the following code?:
    /*
    //if (UIManager.fieldErrorJQuery().size() == 0) {
        // look for any elements that are tagged with a "scroll-to" style class (i.e. .uiManager_scrollTo or .uiManager_scrollToMax) that 
        // have just now "appeared" as a result of the recently completed action - we execute a scrollTo operation for the first such element:
        var scrollToElements = UIManager.scrollToJQuery();
        if (this._prevScrollToElements) {
            scrollToElements = scrollToElements.not(this._prevScrollToElements.get());
        }
        if (scrollToElements.size() > 0) {
            scrollToElements = scrollToElements.first();
            if (scrollToElements.filter(".uiManager_scrollToMax").size() > 0) {
                $("#formInnerScroll").scrollTo('max', 500);
            } else {
                $("#formInnerScroll").scrollTo(scrollToElements[0], 500);
            }
        }
    //}
    */
}

UIManager.prototype.showTimedMessage = function(/*String*/ message, /*int*/ fadeDelay, /*int*/ fadeDuration){
    var timedMessage = this.getTimedStatusMessageWidget(true);
    if (!isNaN(fadeDelay)){
        timedMessage.fadeDelay = fadeDelay;
    }
    if (!isNaN(fadeDuration)){
        timedMessage.fadeDuration = fadeDuration;
    }
    timedMessage.setMessage(message);
    timedMessage.show();
    this.getRootLayoutWidget(true)._layout();
}

UIManager.prototype.innerScrollJQuery = function () {
    return $("#formInnerScroll");
}

UIManager.prototype.initialize = function(){
    this.onInitializeActionBeforeStart();
    
    $("body").addClass("rk-ui-initialized");
    
    // use jquery-ui datepickers; assume the appropriate jquery-ui scripts/CSS *and* json2 have been imported:
    if (this.props.enhancedDatepickers !== undefined) {
        
        this.initEnhancedDatepicker(this.props.enhancedDatepickers);

    // use SFDC's horrible datepicker:
    } else if (typeof(DatePicker) != 'undefined'){
        // NOTE - this "fixed" position calculation only works if your parent scrollpane divs have a non-static position (i.e. they must be relative or absolute);
        // otherwise, they will not be included in the offsetParent chain that's used for the calculation:
        DatePicker.prototype.position = VisualforceUtils._salesforceDatePickerPositionFixFunction;
        // change the Salesforce datePicker's loction in the DOM, so that it works within our main contents scrollpane:
        this.relocateSFDCDatePicker();
    }
    
    // TODO: we should consider the removal of this:
    this._jqueryElementSetup();
    
    // handle/suppress the return-key and backspace-key events for for inputs, so that the user won't inadvertently submit or back out of the main <form>:
    this.suppressFormActionKeys();
    
    if (this.getSubmitBlockingPaneWidget()){
        this.getSubmitBlockingPaneWidget().hide();
    }
    this.getRootLayoutWidget(true).hideForLayout();
    
    var ui = UIManager.instance,
        mgdHeight = {type:"auto"},
        mgdHeightTarget, mgdHeightShell;
    // pickup any custom specified managed-height component and/or shell via CSS classes:
    if (mgdHeightTarget = $(".rk-managedHeight-auto")[0] || $(".rk-managedHeight")[0]) {
        mgdHeight.target = mgdHeightTarget;
    } else if (mgdHeightTarget = $(".rk-managedHeight-fill")[0]) {
        mgdHeight.type = "fill";
        mgdHeight.target = mgdHeightTarget;
    }
    if (mgdHeightShell = $(".rk-managedHeight-shell")[0]) {
        mgdHeight.shell = mgdHeightShell;
    }
    this.setManagedHeight(mgdHeight);
    
    var rootWidget = this.getRootLayoutWidget(),
        $root = $(rootWidget.domNode),
        finishInit = function() {
            rootWidget.fadeShow();
            ui.onInitializeActionAfterComplete();
        };
    
    var useMgdHeight;
    // if we've got a valid managed-height component, then finish then init sequence (i.e. fade-in) AFTER the managed-height component's first calculation:
    if (useMgdHeight = this.managedHeight && this.managedHeight.$shell()[0] && this.managedHeight.$target()[0]) {
        $root.one("rkuiRecalcManagedHeight", function() {
            finishInit();
        });
    }
    
    dojo.event.connect(this.getRootLayoutWidget(), "_layout", this, "queueRecalcManagedHeight");
//    dojo.event.connect(this.getRootLayoutWidget(), "onShow", this, "_consumePendingInnerScrollRefreshForInit");
    this.readyForLayout = true;
    this.layout();
    
    if (!useMgdHeight) {
        finishInit();
    }
    
    this.onInitializeActionAfterComplete();
}

UIManager.prototype.initEnhancedDatepicker = function (baseConfig) {
    baseConfig = $.extend({
            dateFormat: "m/d/yy",
            yearRange: "c-15:c+10",
            changeYear: true,
            changeMonth: true
        }, baseConfig ? baseConfig : (this.props.enhancedDatepickers ? this.props.enhancedDatepickers : {}));
    
    if (!jQuery.fn.datepicker) {
        $.error("jquery-ui must be imported to use enhanced datepickers");
    } else if (typeof JSON === "undefined" || !JSON.stringify || !JSON.parse) {
        $.error("json-lib must be imported to use enhanced datepickers");
    } else {
        var $body = $("body"),
            // start with the default configuration options:
            config = {
                dateFormat: "m/d/yy",
                yearRange: "c-15:c+10",
                changeYear: true,
                changeMonth: true
            };
        
        //// the lowest-precedence datepicker options will reside on the <body>:
        //$body.attr("enhancedDatepicker", baseConfig);
        
        $(".dateInput > input[type=text]").each(function() {
            var $date = $(this);
            // the actual options will be calculated and set dynamically:
            $date.prop("onfocus", null).datepicker({beforeShow: 
                function() {
                    // dynamically gather and mixin datepicker options from all parent elements with the "enhancedDatepicker" attribute:
                    var c = $.extend({}, baseConfig);
                    $([].reverse.call($(this).parents("[enhancedDatepicker]"))).each(function() {
                        var $el = $(this),
                            localOpts;
                        try {
                            localOpts = JSON.parse($el.attr("enhancedDatepicker"));
                        } catch (e) {
                            $.error("Could not parse \"enhancedDatepicker\" attribute value as valid JSON (please ensure it adheres to *strict* JSON format): [" + 
                                $el.attr("enhancedDatepicker") + "]");
                            return;
                        }
                        c = $.extend(c, localOpts);
                    });
                    $(this).datepicker("option", c);
                }
            });
        });
    }
}

//this replaces the prior "killBubbleKeyEvent" methods; it's more efficient and makes better use of jQuery's builtin functionality:
UIManager.prototype.suppressFormActionKeys = function() {
    /*
    var _ui = this;
    // handle keydown events on buttons, links, selects, and inputs in the document:
    $(document).on("keydown.uiManager", "body, form, button, a, select, input", function(evt) {
        // suppress the return key event for selects and certain kinds of inputs (so that the form is not submitted)
        var cancel = evt.which === 13 && $(this).is("select, input") && !$(this).is("input[type=submit], input[type=button]");
        // cancel backspace keys from buttons, links, selects, checkboxes, and radios; also cancel backspace keys originating from the body or form elements:
        if (cancel || evt.which === 8 && ($(this).is("button, a, select, input[type=checkbox], input[type=radio]") || $(this).is("body, form") && this === evt.srcElement)) {
            evt.preventDefault();
        }
    });
    */
    var selectPatt = /^select$/i,
    inputPatt = /^input$/i,
    textPatt = /^text$/i,
    textareaPatt = /^textarea$/i,
    submitButtonPatt = /^(?:submit|button)$/i,
    checkRadioSubmitButtonPatt = /^(?:checkbox|radio|submit|button)$/i;

    $(document).bind("keydown", function(e) {
        var srcEl = window.event ? window.event.target || window.event.srcElement : e.target,
            srcTag = srcEl.nodeName,
            srcType = srcEl.getAttribute("type"),
            srcContentEditable = srcEl.getAttribute("contentEditable"),
            cancel = false;
            
        if (e.keyCode == 13 && (selectPatt.test(srcTag) || inputPatt.test(srcTag) && !submitButtonPatt.test(srcType))) {
            e.preventDefault();
        } else if (e.keyCode == 8 &&
                !(inputPatt.test(srcTag) && !checkRadioSubmitButtonPatt.test(srcType) || textareaPatt.test(srcTag) || srcContentEditable)) {
            e.preventDefault();
        }
    });
}

UIManager.prototype.queueRecalcManagedHeight = function() {
    // by calling through window.setTimeout, we give the rendering engine time to react to the predecessor _layout call:
    window.setTimeout($.proxy(UIManager.instance.recalcManagedHeight, UIManager.instance), 0);
}

UIManager.prototype._jqueryElementSetup = function () {
    this.setupRequiredPicklists();
}

UIManager.prototype.setupRequiredPicklists = function () {
    if (!this._setupRequiredPicklistsContext) {
        this._setupRequiredPicklistsContext = {
            requiredPicklistJQuery: function () {
                return $("form select.uiManager_requiredPicklist, form select.requiredPicklist").not('.DialogOuterBar *');
            }
        };
    }
    UIManager.setupRequiredPicklists(this._setupRequiredPicklistsContext);
}

UIManager.setupRequiredPicklists = function (context) {
    context.requiredPicklistJQuery().each(function () {
        var noneOptionSelector = "option[value='']";
        if (StringUtils.isBlank($(this).val())) {
            $(this).children(noneOptionSelector).text(_defaultNoneOptionLabel ? _defaultNoneOptionLabel : "Please Choose:");
            $(this).change(function () {
                if (!StringUtils.isBlank($(this).val())) {
                    $(this).children(noneOptionSelector).remove();
                }
            });
        } else {
            // if there is a real value selected in this picklist, then disallow the "None" option:
            $(this).children(noneOptionSelector).remove();
        }
    });
}

//////////////////////////////

UIManager.prototype.notifyInnerScrollContentsRefreshed = function (hasValidationError) {
    this._pendingInnerScrollUpdate = {
        "timestamp": new Date(),
        "hasValidationError": hasValidationError
    }
}

UIManager.prototype._consumePendingInnerScrollRefreshForInit = function () {
    dojo.event.disconnect(this.getRootLayoutWidget(), "onShow", this, "_consumePendingInnerScrollRefreshForInit");
//    this._consumePendingInnerScrollRefresh(true);
    this._consumePendingInnerScrollRefresh(false);
}

UIManager.prototype._consumePendingInnerScrollRefresh = function (bypassLayout) {
    if (this._pendingInnerScrollUpdate) {
        var target = $('#formInnerScroll');
        if (target.size() > 0) {
            var hasError = this._pendingInnerScrollUpdate.hasValidationError;
            this._pendingInnerScrollUpdate = null;
            if (!bypassLayout) {
                // console.log("layout");
                this.getRootLayoutWidget(true)._layout();
            }
            if (hasError) {
                target.addClass('error');
                this.adjustInnerScrollForError();
            } else {
                target.removeClass('error');
            }
        }
    }
}

UIManager.fieldErrorJQuery = function() {
    //return $('#formInnerScroll div.requiredInput .error');
    return $('#formInnerScroll input.error, #formInnerScroll select.error, #formInnerScroll textarea.error');
}

UIManager.prototype.adjustInnerScrollForError = function () {
    //var target = $('#formInnerScroll div.requiredInput .error');
    var target = UIManager.fieldErrorJQuery();
    if (target.size() > 0) {
        var onScrollToFinished = function () {
            target.first().focus();
        }
        $('#formInnerScroll').scrollTo(target[0], 500, {"offset":{"top":-5}, "onAfter": onScrollToFinished});
    }
}

//===================================================================================================================================================
// Managed-Height Components:
// ==================================================================================================================================================

UIManager.padBorderHeight = function(selector) {
    var $el = selector.fn ? selector : $(selector),
        // Internet Explorer 8 (and earlier) sucks when it comes to reporting border sizes; it's the only browser that can return a non-numeric 
        // value, e.g. "medium". It only does this when a border size hasn't been specified via CSS -- so our workaround is to default this to 
        // 0 when we parse out a NaN value:
        borderTop = parseInt($el.css("border-top-width"), 10),
        borderBottom = parseInt($el.css("border-bottom-width"), 10);
    // beware automatic semicolon insertion on return statements! when returning an expression value, always have at least 1 token on the same 
    // line as the "return" keyword:
    return (isNaN(borderTop) ? 0 : borderTop) + (isNaN(borderBottom) ? 0 : borderBottom)
        + parseInt($el.css("padding-top"), 10) + parseInt($el.css("padding-bottom"), 10);
};

/*
 * options: {
 *     [type]: "auto"|"fill"
 *             Default="auto"
 *     
 *     [target]: jQuery|DOM-Node|selector; The element whose height we wish to be managed
 *               Default="#formInnerScroll, .FormInnerScroll"
 *     
 *     [min]: number or function; The minimum allowed height (in pixels) for the target element
 *            Default = 100
 *            
 *     [max]: number or function; The maximum allowed height (in pixels) for the target element
 *            Default = undefined (i.e. unlimited height)
 *            
 *     [shell]: jQuery|DOM-Node|selector; The container element that defines how much vertical 
 *              real-estate the target element has to work within (** must contain the target).
 *              Default = UIManager.instance.scrollWidget.domNode
 *     
 *     [manageShellScroll]: boolean; Flags whether the managedHeight logic should attempt to set
 *                          & maintain shell element's overflow-x CSS property (i.e. vertical scroll)
 *                          based on the specified minimum width.
 *                          Default = true
 *     
 *     [targetHeightometer]: function; applies only when type==="auto"; returns the "natural" height 
 *                           of the target element (i.e. the height of its contents plus border & padding). 
 *                           Default function assumes that the target's children are all statically 
 *                           or relatively positioned block-level elements.
 *     
 *     [shellHeightometer]: function; returns the "natural" height of the shell element (i.e. the 
 *                          height of its contents plus border & padding). 
 *                          Default function assumes that the target's children are all statically 
 *                          or relatively positioned block-level elements.
 * }
 */
UIManager.prototype.setManagedHeight = function(options) {
    this.clearManagedHeight();
    var resolveSelector = function(selector) {
            return selector.fn ? selector : $(selector);
        },
        options = typeof options === "string" ? {type:options} : options,
        simpleHeightometer = function() {
            // get all the statically positioned direct-children of the target element:
            var $target = $(this);
                $chillin = $target.children().not(".rk-driver-pholder").filter(function() {
                    var $child = $(this), pos;
                    return (pos = $child.css("position")) === "static" || pos === "relative";
                });
            
            // Find the difference in absolute position between the first and last statically positioned children, plus the outer 
            // height of the last -- we'll call this the $target's "natural" height.
            return ($chillin.last().offset().top - $chillin.first().offset().top + $chillin.last().outerHeight(false) // the false arg is to bypass a jQuery 1.8.3 bug in outerHeight/Width
                + UIManager.padBorderHeight($target));
        };
    
    this.managedHeight = $.extend({
        $root: $(this.getRootLayoutWidget().domNode),
        type: "auto", 
        shell: this.scrollWidget.domNode,
        manageShellScroll: true,
        target: "#formInnerScroll, .FormInnerScroll",
        min: 100, 
        shellHeightometer: simpleHeightometer,
        targetHeightometer: simpleHeightometer,
        $shell: function() {
            return resolveSelector(this.shell);
        },
        $target: function() {
            return resolveSelector(this.target);
        }
    }, options);
    
    if (this.managedHeight.$shell()[0] && this.managedHeight.$target()[0] && !this.managedHeight.$target().parents(this.managedHeight.$shell())[0]) {
        $.error("The target element must be a descendent of the shell element");
    }
}

UIManager.prototype.clearManagedHeight = function(options) {
    if (this.managedHeight) {
        this.managedHeight.$root.clearQueue("rkui-managedHeight");
        this.managedHeight = undefined;
    }
};

UIManager.rAuto = /auto/i;
UIManager.rBorderBox = /border-box/i;

UIManager.prototype.recalcManagedHeight = function() {
    var ui = this,
        qName = "rkui-managedHeight";
    if (!this.managedHeight) {
        return;
    }
    // the custom queueing is to manage the scenario where we'd have an influx of recalcManagedHeight requests faster than they can be 
    // processed -- in these cases, only the "last" request is the valid one; the previous requests represent wasted effort. the 
    // following custom queueing dumps the superfluous requests so that the processing has a much better change of keeping up:
    var $root = ui.managedHeight.$root,
        $shell = ui.managedHeight.$shell(),
        $target = ui.managedHeight.$target(),
        dequeue = function() {
            if (ui.managedHeight && $shell[0]) {
                if (ui.managedHeight._busy = $root.queue(qName).length > 0) {
                    $root.dequeue(qName);
                }
            }
        };
    
    // dump any prior pending (i.e. superfluous) requests:
    $root.clearQueue(qName);
    //if ($target[0] && $target.is(":visible")) {
    if ($target[0]) {
        // queue up the main calculation:
        $root.queue(qName, function() {
            var config = ui.managedHeight,
                $shell = config.$shell(),
                $target = config.$target(),
                targetPadBorder = UIManager.padBorderHeight($target),
                // the height required by the shell's contained contents (i.e. its "natural" height); does not include the shell element's 
                // padding/border:
                shellNatHeight = config.shellHeightometer.call($shell),
                // the physical height (excluding padding/border) of the shell element:
                shellPhysHeight = $shell.height(),
                // the height required by the target's contained contents (i.e. its "natural" height); includes the target element's 
                // padding/border;
                // TODO: only calculate when config.type==="auto":
                // !! targetHeightometer should already be calculating "border-box" height, so don't double-add the border/padding:
                targetNatHeight = config.targetHeightometer.call($target), // + targetPadBorder,
                // the physical height (including padding/border) of the target element:
                targetPhysHeight = $target.outerHeight(false), // the false arg is to bypass a jQuery 1.8.3 bug in outerHeight/Width
                // the maximum amount of height available -- if the target is set to this height, then the shell's content height will exactly 
                // match its physical height (i.e. a perfect vertical fill):
                availHeight = shellPhysHeight - (shellNatHeight - targetPhysHeight),
                newTargetPhysHeight, max, min;
            
            // use the full amount of available height:
            if (availHeight <= targetNatHeight || config.type && config.type.toLowerCase() === "fill") {
                newTargetPhysHeight = availHeight;
                
            // respect the target's content height:
            } else {
                newTargetPhysHeight = targetNatHeight;
            }
            
            // upper/lower-bound the new height:
            newTargetPhysHeight = typeof (max = parseInt(config.max, 10)) === "number" && !isNaN(max) ? 
                Math.min(newTargetPhysHeight, max) : newTargetPhysHeight;
            newTargetPhysHeight = typeof (min = parseInt(config.min, 10)) === "number" && !isNaN(min) ? 
                Math.max(newTargetPhysHeight, min) : newTargetPhysHeight;
            
            if (config.manageShellScroll) {
                var overflowY = $shell.css("overflow-y"),
                    hitMin = min === newTargetPhysHeight;
                if (!hitMin && UIManager.rAuto.test(overflowY)) {
                    $shell.css("overflow-y", "hidden");
                } else if (hitMin && !UIManager.rAuto.test(overflowY)) {
                    $shell.css("overflow-y", "auto");
                }
            }
            
            // set the target element's height, compensating for the target's box-sizing model as necessary:
            if ($.support.boxModel) { // this condition is false for IE 6 & 7 -- IE assumes the border-box model in these versions
                // querying the applicable box-sizing model can be a touch tricky:
                if (!UIManager.rBorderBox.test(
                        $.map(["box-sizing", "-webkit-box-sizing", "-moz-box-sizing", "-ms-box-sizing"], function(cssKey, index) {
                            return $target.css(cssKey);
                        }).join(""))) {
                    // we've determined that $target is under the "content-box" box-sizing model; since we've calculated its 
                    // "border-box" height, we now must subtract out its padding/border height:
                    newTargetPhysHeight -= targetPadBorder;
                }
            }
            $target.height(newTargetPhysHeight);
            
            config.$root.triggerHandler("rkuiRecalcManagedHeight");
            
            // execute the recalc next request (e.g. if a new one came in while we were processing this one):
            dequeue();
        });
        
        // if we're not currently busy processing a prior request, then kickoff the queue:
        if (!ui.managedHeight._busy) {
            dequeue();
        }
    }
};

//==================================================================================================================================================

UIManager.prototype.relocateSFDCDatePicker = function(){
    //VisualforceUtils.moveSalesforceDatePicker(this.getScrollWidget().domNode);
    VisualforceUtils.moveSalesforceDatePicker(this.rootLayout.domNode);
}

UIManager.prototype.destroy = function(){
    UIManager.oldWindowOnload = null;
    var rootLayout = this.getRootLayoutWidget();
    if (rootLayout) {
        dojo.event.disconnect(rootLayout, "_layout", this, "queueRecalcManagedHeight");
        //dojo.event.disconnect(rootLayout, "onShow", this, "consumePendingInnerScrollUpdate");
    }
    if (this.modalDialogController){
        this.modalDialogController.destroy();
        this.modalDialogController = null;
    }
    this.widgets = null;
    this.rootLayout = null;
    this.scrollWidget = null;
    this.onAfterDestroy();
}

UIManager.prototype.onAfterDestroy = function(){
    // For now, do nothing...
}

UIManager.prototype.onInitializeActionBeforeStart = function(){
    // For now, do nothing...
}

UIManager.prototype.onInitializeActionAfterComplete = function(){
    // For now, do nothing...
}

UIManager.prototype.setPageWidgets = function(widgets){
    this.widgets = widgets;
    this._superInit();
}

UIManager.newWidgetWithTemplate = function(parentWidget, widgetType, widgetProps){
    //var node = document.createElement('div');
    //node.innerHTML = '<div>foo</div>';
    var newWidget = dojo.widget.createWidget(widgetType, widgetProps.mixins);
    //console.log(newWidget);
    if (parentWidget) {
        parentWidget.addChild(newWidget);
    }
    if (widgetProps.styleText){
        dojo.html.setStyleText(newWidget.domNode, widgetProps.styleText);
    }
    if (widgetProps.styleClass){
        dojo.html.addClass(newWidget.domNode, widgetProps.styleClass);
    }
    if (widgetProps.innerHtml){
        (newWidget[widgetProps.innerHtmlDojoAttachPoint]).innerHTML = widgetProps.innerHtml;
        //newWidget.containerNode.innerHTML = widgetProps.innerHtml;
    }
    return newWidget;
}

UIManager.newWidgetWithoutTemplate = function(parentWidget, widgetType, widgetProps, createInBody){
    var node = document.createElement('div');
    //if (createInBody){
        document.body.appendChild(node);
    //}
    if (widgetProps.styleText){
        dojo.html.setStyleText(node, widgetProps.styleText);
    }
    if (widgetProps.styleClass){
        dojo.html.addClass(node, widgetProps.styleClass);
    }
    if (widgetProps.innerHtml){
        node.innerHTML = widgetProps.innerHtml;
    }
    var newWidget = dojo.widget.createWidget(widgetType, widgetProps.mixins, node);
    if (parentWidget) {
        parentWidget.addChild(newWidget);
    }
    return newWidget;
}

UIManager.initShellSupportWidgets = function(rootPane) {
    var ui = UIManager.instance;
    if (ui.widgets.statusMessage) {
        var widgetProps = ui.widgets.statusMessage;
        widgetProps.widget = UIManager.newWidgetWithTemplate(rootPane, 'VForceStatusBox', widgetProps);
    }
    if (ui.widgets.submitBlockingPane) {
        var widgetProps = ui.widgets.submitBlockingPane;
        widgetProps.widget = UIManager.newWidgetWithoutTemplate(rootPane, 'IframeBackingWidget', widgetProps);
    }
    if (ui.widgets.timedStatusMessage) {
        var widgetProps = ui.widgets.timedStatusMessage;
        widgetProps.widget = UIManager.newWidgetWithTemplate(rootPane, 'TimedStatusBox', widgetProps);
    }
    if (ui.widgets.dialogs) {
        // if we have dialgs on this page, then create the dialog-controls widget on-the-fly:
        var dialogControlsProps = ui.widgets.dialogControls = {
            mixins: {
                layoutAlign: "stack",
                hCellAlign: "center",
                vCellAlign: "top",
                marginTop: 8,
                zIndex: 502,
                widgetId: "dialogControlsWidget"
            },
            widgetId: "dialogControlsWidget",
            innerHtml: "<div />",
            innerHtmlDojoAttachPoint: "contentPlaceholder"
        };
        dialogControlsProps.widget = UIManager.newWidgetWithTemplate(rootPane, 'DialogControls', dialogControlsProps);
        // TODO: add a check for the dialog script file's existence...
        for (var dialogKey in ui.widgets.dialogs) {
            var dialogProps = ui.widgets.dialogs[dialogKey];
            // set a reference to the dojo widget - for use by the DialogManager
            dialogProps.widget = UIManager.newWidgetWithoutTemplate(rootPane, 'VForceDialog', dialogProps);
        }
    }
};

UIManager.initShellTopLevelWidgets = function(rootPane, $flaggedEls) {
    var ui = UIManager.instance,
        mixins,
        mixinProps = ["layoutAlign", "hCellAlign", "vCellAlign", "preferredWidth", "preferredHeight"];
    
    $flaggedEls.each(function() {
        var $el = $(this),
            mixins = {
                layoutAlign: "top",
                hCellAlign: "fill"
            };
        $.each(mixinProps, function(index, name) {
            if ($el.attr(name) !== undefined) {
                mixins[name] = $el.attr(name);
            }
        });
        rootPane.addChild(dojo.widget.createWidget("ContentPane", mixins, $el[0]));
    });
};

UIManager.initStandaloneShell = function() {
    // remove all <script> nodes from the Visualforce page's contents, so they won't get executed again upon subsequent re-attachment of the contents:
    $("body script").remove();
    var ui = UIManager.instance,
        $uiMgrNodes = $("[isUiManagerNode]").detach(),
        // detach our Visualforce Page's core content nodes (i.e. the current direct children of the body element):
        $vfContents = $('body').children().detach(),
        rootPane   = dojo.widget.createWidget('RootSmartLayoutContainer', {widgetId: "mainWindow"}, $('<div/>').appendTo($('body'))[0]),
        scrollPane = dojo.widget.createWidget('ContentPane', { // create the scroll container
                        widgetId: "clientContentPane",
                        layoutAlign: "client", scroll: "xy", hCellAlign: "fill", vCellAlign: "fill",
                        //margin: ui.props ? ui.props.scrollContentsMargin : "0 0 0 0"
                        margin: "0 0 0 0"
                    }, $('<div/>')[0]),
        scrollMargin = ui.props && ui.props.scrollContentsMargin ? ui.props.scrollContentsMargin : "0 10 0 10",
        contentPane;
    
    scrollMargin = scrollMargin.replace(/(\d+)(?!px|em)/g, "$1px");
    
    UIManager.initShellTopLevelWidgets(rootPane, $uiMgrNodes);
    ui.scrollWidget = scrollPane;
    rootPane.addChild(scrollPane);
    contentPane = dojo.widget.createWidget('ContentPane', {layoutAlign:"client"}, $('<div/>').css({ margin: scrollMargin }).append($vfContents)[0]);
    scrollPane.addChild(contentPane);
    ui.rootLayout = rootPane;
    // create the uiManager shell's widgets, and then do initial layout:
    UIManager.initShellSupportWidgets(rootPane);
    ui.signalQueueReady("shellReady");
    // removing this layout call; our shell should get laid out via the subsequent _uiManager.initialize:
    //rootPane._layout();
};

UIManager.initNestedShell = function() {
    var ui = UIManager.instance,
        $sfdcNodes;
    
    if (ui.isPortalUI) {
        $sfdcNodes = $("body").children().filter(".bPageHeader, .bodyDiv, .bPageFooter");
    } else {
        $sfdcNodes = $("#contentWrapper");
    }
    
    // remove all <script> nodes from the Visualforce page's contents, so they won't get executed again upon subsequent re-attachment of the contents:
    $sfdcNodes.find("script").remove();
    var $uiMgrNodes = $sfdcNodes.find("[isUiManagerNode]").detach(),
        rootPane   = dojo.widget.createWidget('RootSmartLayoutContainer', {widgetId: "mainWindow"}, $('<div/>').appendTo($('body'))[0]),
        scrollPane = dojo.widget.createWidget('ContentPane', { // create the scroll container
                        widgetId: "clientContentPane",
                        layoutAlign: "client", scroll: "xy", hCellAlign: "fill", vCellAlign: "fill",
                        //margin: ui.props ? ui.props.scrollContentsMargin : "0 0 0 0"
                        margin: "0 0 0 0"
                    }, $('<div/>')[0]),
        scrollMargin = ui.props && ui.props.scrollContentsMargin ? ui.props.scrollContentsMargin : "0 10 0 10",
        contentPane;
    
    scrollMargin = scrollMargin.replace(/(\d+)(?!px|em)/g, "$1px");
    
    UIManager.initShellTopLevelWidgets(rootPane, $uiMgrNodes);
    ui.scrollWidget = scrollPane;
    rootPane.addChild(scrollPane);
    // get our Visualforce Page's core contents root-node, detach it from the document, and remove all its <script> nodes (so they 
    // won't get executed again upon re-attachment of the contents):
    //(vfPageContentNode = $('#contentWrapper').detach()).find('script').remove();
    $sfdcNodes.detach();
    contentPane = dojo.widget.createWidget('ContentPane', {layoutAlign:"client"}, $('<div/>').css({ margin: scrollMargin }).append($sfdcNodes)[0]);
    scrollPane.addChild(contentPane);
    // create the uiManager shell's widgets, and then do initial layout:
    UIManager.initShellSupportWidgets(rootPane);
    ui.signalQueueReady("shellReady");
    ui.rootLayout = rootPane;
    // removing this layout call; our shell should get laid out via the subsequent _uiManager.initialize:
    //rootPane._layout();
};

UIManager.loadHomePage = function () {
    window.location.href = '/apex/IncidentMgmt_Home?contactId=' + escape(_contactId);
}

UIManager.loadAIHomePage = function () {
    window.location.href = '/apex/AI_Home?contactId=' + escape(_contactId);
}

