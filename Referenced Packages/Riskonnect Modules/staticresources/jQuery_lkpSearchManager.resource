/*
 * Mike Ulveling 
 * Nov. 11
 * 
 * Small jQuery plugin for factoring out the vast majority of the client-side lookup-search dialog functionality -- 
 * e.g. criteria/results page flipping, binding results link handlers, cleaning out old results, routing criteria and
 * rerender params for actionFunctions, etc.
 */
(function ($) {
    
    $.lkpSearchManager = {
        dataName: 'lkpSearchManagerData',
        eventNS: '.lkpSearchManager',
        defaultSubmitOpts: {
            actionScope: window,
            message: "Please Wait",
            submitDialogWithForm: false
        },
        instances: [],
        // clears all criteria across all instances:
        clearCriteria: function() {
            $.each($.lkpSearchManager.instances, function(index, instance) {
                instance.lkpSearchManager('clearCriteria');
            });
        }
    };
    
    var $fromVforceId = function (vforceId) {
            return $(document.getElementById(vforceId));
        },
        
        resolveMixinIds = function(stringOrFunc) {
            return $.isFunction(stringOrFunc) ? stringOrFunc() : stringOrFunc;
        },
        
        getCriteriaArgs = function (data) {
            var args = [],
                // paramNames = ['{!search.param1}', '{!search.param2}', '{!search.param3}', '{!search.param4}', '{!search.param5}',
                //     '{!search.param6}', '{!search.param7}', '{!search.param8}', '{!search.param9}', '{!search.param10}'],
                i, val,
                $inputs = data.dialogInstance.$dialogBaz().find(":input"),
                $input;
            for (i=0; i < data.criteriaParamNames.length; i++) {
                val = ($input = $inputs.filter("[name=" + data.criteriaParamNames[i] + "]")).val();
                if ($input.is("[type=checkbox]")) {
                    // checkboxes need to be handled as a special case; only send its value if "checked":
                    val = $input.prop("checked") ? val : undefined;
                }
                // send undefined for each unused criteria parameter:
                args.push(val ? val : undefined);
            }
            return args;
        },
        
        methods = {
            /*
            reRender: function () {
                dialogInstance.reRender();
            },
            */
            
            // resultsTableContainer is a required param here; it may be an element/jQuery/selector:
            updateResultsTable: function (resultsTableContainer) {
                return this.each(function () {
                    var $this = $(this),
                        $table = $(resultsTableContainer).find('table'),
                        data = $this.data($.lkpSearchManager.dataName);
                    // console.log('Update results table');
                    // console.log(data);
                    // use jQuery 1.7's super-cool event delegation to bind all the table rows' lookup-links to a single 
                    // handler function in one shot:
                    $table.on('click', 'td span.actionFunctionNormalLink[lookupId]', function () {
                        $this.lkpSearchManager('submitSearchResultsLink', $(this).attr('lookupId'));
                    });
                    if (data) {
                        // flag to the searchManager that we've received fresh search results:
                        data.hasActiveResults = true;
                        // console.log(data.dialogInstance);
                        if (data.dialogInstance.isActive()) {
                            // this should cause a layout to occur after sort/pageNumber/pageSize AJAX post-backs
                            data.dialogInstance.reLayout(true);
                        }
                    }
                });
            },
            
            // for cleanup of the previous table right before the inline rerender of a new one
            // resultsTableContainer is an optional param here; it may be an element/jQuery/selector:
            cleanDom: function (resultsTableContainer) {
                // $(document.getElementById('{!$Component.resultsGrid}')).empty();
                return this.each(function () {
                    var $this = $(this),
                        data = $this.data($.lkpSearchManager.dataName),
                        $table = (resultsTableContainer ? $(resultsTableContainer).find('table') : data.$resultsPage.find('table')).first();
                    // find the table in the results block, and clobber it by cleaning out its direct parent:
                    $table.parent().empty();
                });
            },
            
            refreshPages: function () {
                return this.each(function () {
                    var $this = $(this),
                        data = $this.data($.lkpSearchManager.dataName);
                    // console.log('refresh pages:');
                    // console.log(data);
                    if (data.hasActiveResults) {
                        data.$criteriaPage.hide();
                        data.$resultsPage.show();
                    } else {
                        data.$criteriaPage.show();
                        data.$resultsPage.hide();
                    }
                });
            },
            
            showCriteria: function () {
                return this.each(function () {
                    var $this = $(this),
                        data = $this.data($.lkpSearchManager.dataName),
                        dialogInstance = data.dialogInstance;
                    // expire any active search results and then refresh to show the criteria "page":
                    data.hasActiveResults = false;
                    // do a close/open sequence so that the dialog's transient states will be reset to "default":
                    dialogInstance.one('afterClose', function () {
                        $this.lkpSearchManager('refreshPages');
                        dialogInstance.open();
                    });
                    dialogInstance.close()
                });
            },
            
            clearCriteria: function() {
                return this.each(function () {
                    var $this = $(this),
                        data = $this.data($.lkpSearchManager.dataName),
                        $inputs = data.dialogInstance.$dialogBaz().find(":input"),
                        $input;
                    
                    for (var i=0; i < data.criteriaParamNames.length; i++) {
                        $input = $inputs.filter("[name=" + data.criteriaParamNames[i] + "]");
                        if ($input[0]) {
                            if ($input.is("[type=checkbox]")) {
                                $input.prop("checked", false);
                            } else {
                                $input.val("");
                            }
                        }
                    }
                    
                    $this.trigger("clearCriteria.lkpSearchManager");
                });
            },
            
            submitSearch: function (dynamicParams) {
                dynamicParams = $.isFunction(dynamicParams) ? dynamicParams() : dynamicParams;
                dynamicParams = dynamicParams && typeof dynamicParams === 'object' ? dynamicParams : { };
                return this.each(function () {
                    var $this = $(this),
                        data = $this.data($.lkpSearchManager.dataName),
                        uiManager = data.uiManager,
                        paramNameToIndex = { };
                    
                    // build a map of each criteria param name to its expected criteria param index (starting at 0); note that the criteria 
                    // params' actionFunction-parameter indexes start at index=3 (i.e. add 3 to these numbers):
                    for (var i=0; i < data.criteriaParamNames.length; i++) {
                        paramNameToIndex[data.criteriaParamNames[i]] = i;
                    }
                    
                    uiManager.validateActiveDialog(function () {
                        uiManager.submitDialog($.extend({}, data.submitOpts, {
                            action: function () {
                                var args = getCriteriaArgs(data), 
                                    paramIndex;
                                
                                args.splice(0, 0, data.criteriaVforceId, data.resultsVforceId, resolveMixinIds(data.mixinDestVforceIds));
                                // console.log(args);
                                
                                // set the dynamic criteria parameters last, so that they may override the in-DOM param1..param10 parameters:
                                for (var paramName in dynamicParams) {
                                    if ((paramIndex = paramNameToIndex[paramName]) !== undefined) {
                                        // the criteria parameters start at index=3:
                                        args[paramIndex + 3] = dynamicParams[paramName];
                                    }
                                }
                                
                                data.get_af_search().apply(window, args);
                            },
                            shortMessage: "Searching..."
                        }));
                    });
                });
            },
            
            submitSearchResultsLink: function (lookupId) {
                return this.each(function () {
                    var $this = $(this),
                        data = $this.data($.lkpSearchManager.dataName),
                        uiManager = data.uiManager;
                    uiManager.validateActiveDialog(function () {
                        uiManager.submitDialog($.extend({}, data.submitOpts, {
                            action: function () {
                                data.get_af_searchResultsLink()(lookupId, resolveMixinIds(data.mixinDestVforceIds));
                            },
                            shortMessage: "Loading..."
                        }));
                    });
                });
            },
            
            init: function (options) {
                var opts = $.extend({
                        uiManager: _uiManager,
                        criteriaParamNames: []
                        // calling code must supply the following options:
                        // dialogKey:
                        // criteriaParamNames:
                        // get_af_search -- a function that returns a function; the actionFunction that runs a search
                        // get_af_searchResultsLink -- a function that returns a function; the actionFunction that selects a search results link
                        // criteriaVforceId:
                        // resultsVforceId:
                        // mixinDestVforceIds:
                    }, options);
                return this.each(function () {
                    var $this = $(this),
                        eventNS = $.lkpSearchManager.eventNS,
                        // also transfer all options properties over into data:
                        data = $.extend({}, opts, {
                            dialogInstance: opts.uiManager.getDialogManagerByKey(opts.dialogKey),
                            // we need the parent because we don't want it changing after a Vforce rerender:
                            $criteriaPage: $fromVforceId(opts.criteriaVforceId).parent(),
                            // we need the parent because we don't want it changing after a Vforce rerender:
                            $resultsPage: $fromVforceId(opts.resultsVforceId).parent(),
                            hasActiveResults: false,
                            submitOpts: $.lkpSearchManager.defaultSubmitOpts
                        }),
                        dialogInstance = data.dialogInstance;
                    
                    if (!$this.data($.lkpSearchManager.dataName)) {
                        $.lkpSearchManager.instances.push($this);
                        $this.data($.lkpSearchManager.dataName, data);
                        // setup event handlers to hide/show the appropriate page at the appropriate time:            
                        dialogInstance.unbind('beforeOpenShow' + eventNS);
                        dialogInstance.unbind('contentReady' + eventNS);
                        // every time the dialog is opened anew, any existing search results should be expired:
                        dialogInstance.bind('beforeOpenShow' + eventNS, function () {
                            data.hasActiveResults = false;
                        });
                        // every time the dialog's contents are about to be shown, toggle in the appropriate page between criteria/results:
                        dialogInstance.bind('contentReady' + eventNS, function () {
                            $this.lkpSearchManager('refreshPages');
                        });
                    }
                });
            }
        };
    
    $.fn.lkpSearchManager = function (method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            // return methods.define.apply(this, arguments);
            $.error('A method-name argument must be supplied to jQuery.lkpSearchManager; got:');
            $.error(method);
        } else {
            $.error('Method-name [' + method + '] is undefined for jQuery.lkpSearchManager');
        }
    };
})(jQuery)
