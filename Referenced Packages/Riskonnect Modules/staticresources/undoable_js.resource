/* Mike Ulveling 
 * Example Usage: $("textarea").undoable() */
(function ($) {
    // "static" variables:
    var isMac = navigator.platform.toUpperCase().indexOf('MAC') !== -1;    
    $.undoable = {
        instances: []
    };
    
    // plugin initialization:
    $.fn.undoable = function (options) {
        // TODO: add options as required…
        var opts = $.extend({}, options);
        this.each(function () {
            if ($(this).undoableApi()) {
                // disallow re-init:
                return;
            }
            
            // "private" instance variables:
            var instanceIndex,
                $el = $(this),
                // the stack of savepoints:
                savepoints = [ $el.val() ],
                // points to the currently active savepoint:
                savepointIndex = 0,
                
                // generates new savepoint if the current input value differs from the prior savepoint value:
                conditionalSavepoint = function () {
                    if (savepointVal() != $el.val()) {
                        savepoints = savepoints.slice(0, ++savepointIndex);
                        savepoints.push($el.val());
                    }
                },
                
                // private instance methods; invoke as follows: <privateMethod>.call(api [arg1 ... argN])
                processKey = function (evt) {
                    var savedVal = savepointVal(),
                        ctrlKey = isMac && evt.metaKey || evt.ctrlKey,
                        isUndo, priorIndex;
                    
                    // redo:
                    if ((isUndo = evt.which === 90 && ctrlKey) && evt.shiftKey || evt.which === 89 && ctrlKey) {
                        // no-op if we don't have a subsequent savepoint to redo:
                        if (savepointIndex < savepoints.length - 1) {
                            // the input element's value matches the current savepoint's value; advance to the subsequent 
                            // savepoint:
                            if (savedVal == $el.val()) {
                                $el.val(savepoints[++savepointIndex]);
                                
                            // the input's value has branched from current savepoint; no-op on the input element, and 
                            // slice the savepoint stack:
                            } else {
                                savepoints = savepoints.slice(0, savepointIndex + 1);
                            }
                        }
                        return false;
                    
                    // undo:
                    } else if (isUndo) {
                        // if the current val differs from our current savepoint, then:
                        // 1. keep savepointIndex pointed at the current savepoint
                        // 2. slice off any subsequent savepoints
                        // 3. add the current val as a subsequent savepoint
                        // 4. set the current savepoint's val into the input element:
                        if (savedVal != $el.val()) {
                            (savepoints = savepoints.slice(0, savepointIndex + 1))
                                .push($el.val());
                            $el.val(savedVal);
                        
                        // if the current val equals the current savepoint, then:
                        // 1. peek back to the prior savepoint (or the root savepoint, if no prior exists) and set that 
                        //    value into the input element
                        // 2. set savepointIndex to point to the prior savepoint (decrement)
                        } else {
                            $el.val(savepoints[savepointIndex = Math.max(0, savepointIndex - 1)]);
                        }
                        return false;
                    
                    // paste - if the pre-paste value differs from the current savepoint, then create a savepoint before 
                    // the paste:
                    // up/down/left-arrow: same conditional savepoint as with paste:
                    } else if (ctrlKey && evt.which === 86 || evt.which === 37 || evt.which === 38 || evt.which === 40) {
                        conditionalSavepoint();
                    }
                },
                
                savepointVal = function () {
                    return savepoints[savepointIndex];
                },
                
                // public API methods should be exposed in this "api" object:
                api = {
                    savepointVal: savepointVal,
                    
                    destroy: function () {
                        // detach all events handlers bound to this plugin's namespace, and delete the data:
                        $el.off(".undoable")
                           .removeData("undoable");
                        $.undoable.instances.splice(instanceIndex, 1);
                    }
                };
            
            // initialization logic:
            instanceIndex = $.undoable.instances.length;
            $.undoable.instances.push(api);
            $el .data("undoable", api)
                // note how we namespace the events:
                .on("keydown.undoable", function (evt) {
                    return processKey.call(api, evt);
                })
                .on("click.undoable", function (evt) {
                    conditionalSavepoint();
                })
                .on("change.undoable", function () {
                    // if the input's value has changed relative to the current savepoint, then this represents
                    // a new "branch point" in the history tree (our savepoints stack only traces 1 branch); slice 
                    // off all subsequent savepoints, append the current value as a new savepoint, and increment 
                    // the savepoint index:
                    conditionalSavepoint();
                    /*
                    if (savepointVal() != $el.val()) {
                        savepoints = savepoints.slice(0, ++savepointIndex);
                        savepoints.push($el.val());
                    }
                    */
                });
        });
        return this;
    }
    
    // returns an object representing an initialized plugin instance, with all publicly accessible API methods:
    $.fn.undoableAPI = $.fn.undoableApi = function () {
         return this.first().data("undoable");
    }
})(jQuery);