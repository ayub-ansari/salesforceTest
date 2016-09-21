/**
 * @license 
 * jQuery Tools @VERSION Tooltip - UI essentials
 * 
 * NO COPYRIGHTS OR LICENSES. DO WHAT YOU LIKE.
 * 
 * http://flowplayer.org/tools/tooltip/
 *
 * Since: November 2008
 * Date: @DATE 
 * 
 * Modified By Mike Ulveling (see "MDU:" comments)
 */
(function($) {  
    // static constructs
    $.tools = $.tools || {version: '@VERSION'};

    $.tools.tooltip = {

        conf: { 

            // default effect variables
            effect: 'toggle',           
            fadeOutSpeed: "fast",
            predelay: 0,
            delay: 30,
            opacity: 1,         
            tip: 0,
            fadeIE: false, // enables fade effect in IE

            // 'top', 'bottom', 'right', 'left', 'center'
            position: ['top', 'center'], 
            offset: [0, 0],
            relative: false,
            cancelDefault: true,

            // type to event mapping 
            events: {
                def:        "mouseenter,mouseleave",
                input:      "focus,blur",
                widget:     "focus mouseenter,blur mouseleave",
                tooltip:    "mouseenter,mouseleave"
            },

            // 1.2
            layout: '<div/>',
            tipClass: 'tooltip'
        },

        addEffect: function(name, loadFn, hideFn) {
            effects[name] = [loadFn, hideFn];   
        } 
    };


    var effects = { 
        toggle: [ 
            function(done) { 
                var conf = this.getConf(), tip = this.getTip(), o = conf.opacity;
                if (o < 1) { tip.css({opacity: o}); }
                tip.show();
                done.call();
            },

            function(done) { 
                this.getTip().hide();
                done.call();
            } 
        ],

        fade: [
            function(done) {
                var conf = this.getConf();
                if (!$.browser.msie || conf.fadeIE) {
                    this.getTip().fadeTo(conf.fadeInSpeed, conf.opacity, done);
                }
                else {
                    this.getTip().show();
                    done();
                }
            },
            function(done) {
                var conf = this.getConf();
                if (!$.browser.msie || conf.fadeIE) {
                    this.getTip().fadeOut(conf.fadeOutSpeed, done);
                }
                else {
                    this.getTip().hide();
                    done();
                }
            }
        ]       
    };   


    /* calculate tip position relative to the trigger */    
    function getPosition(trigger, tip, conf) {  


        // get origin top/left position 
        var top = conf.relative ? trigger.position().top : trigger.offset().top, 
             left = conf.relative ? trigger.position().left : trigger.offset().left,
             pos = conf.position[0];

        top  -= tip.outerHeight() - conf.offset[0];
        left += trigger.outerWidth() + conf.offset[1];

        // iPad position fix
        if (/iPad/i.test(navigator.userAgent)) {
            top -= $(window).scrollTop();
        }

        // adjust Y     
        var height = tip.outerHeight() + trigger.outerHeight();
        if (pos == 'center')    { top += height / 2; }
        if (pos == 'bottom')    { top += height; }


        // adjust X
        pos = conf.position[1];     
        var width = tip.outerWidth() + trigger.outerWidth();
        if (pos == 'center')    { left -= width / 2; }
        if (pos == 'left')      { left -= width; }   

        return {top: top, left: left};
    }       



    function Tooltip(trigger, conf) {

        var self = this, 
             fire = trigger.add(self),
             tip,
             timer = 0,
             pretimer = 0, 
             title = trigger.attr("title"),
             tipAttr = trigger.attr("data-tooltip"),
             customTipAttr = trigger.attr("custom-tooltip"), // MDU
             effect = effects[conf.effect],
             shown,

             // get show/hide configuration
             isInput = trigger.is(":input"), 
             isWidget = isInput && trigger.is(":checkbox, :radio, select, :button, :submit"),           
             type = trigger.attr("type"),
             evt = conf.events[type] || conf.events[isInput ? (isWidget ? 'widget' : 'input') : 'def'];

        // check that configuration is sane
        if (!effect) { throw "Nonexistent effect \"" + conf.effect + "\""; }                    

        evt = evt.split(/,\s*/); 
        if (evt.length != 2) { throw "Tooltip: bad events configuration for " + type; } 

        // trigger --> show  
        trigger.on(evt[0] + ".tooltip", function(e) {
            
            // MDU: rewrote this section to work with shared tips:
            self._initTip();
            tip.clearQueue("tooltip-toggle")
                .queue("tooltip-toggle", function() {
                    self.show(e);
                });
            
            if (conf.predelay)  {
                setTimeout(function() { tip.dequeue("tooltip-toggle"); }, conf.predelay);
            } else {
                tip.dequeue("tooltip-toggle");
            }
            
            //clearTimeout(timer);
            //if (conf.predelay) {
            //    pretimer = setTimeout(function() { self.show(e); }, conf.predelay); 
            //} else {
            //    self.show(e);   
            //}

        // trigger --> hide
        }).on(evt[1] + ".tooltip", function(e)  {
            
            // MDU: rewrote this section to work with shared tips:
            if (tip) {
                tip.clearQueue("tooltip-toggle")
                    .queue("tooltip-toggle", function() {
                        self.hide(e);
                    });
                
                if (conf.delay)  {
                    setTimeout(function() { tip.dequeue("tooltip-toggle"); }, conf.delay);
                } else {
                    tip.dequeue("tooltip-toggle");
                }
            }
            //clearTimeout(pretimer);
            //if (conf.delay)  {
            //    timer = setTimeout(function() { self.hide(e); }, conf.delay);   
            //} else {
            //    self.hide(e);
            //}

        }); 


        // remove default title
        if (title && conf.cancelDefault) { 
            trigger.removeAttr("title");
            trigger.data("title", title);           
        }       

        $.extend(self, {

            // MDU: factored this out so it could be also used by the "show" event trigger:
            _initTip: function() {
            
                // tip not initialized yet
                if (!tip) {
    
                    // data-tooltip 
                    if (tipAttr) {
                        tip = $(tipAttr);
                        
                    // MDU: ad-hoc tip html stored in "custom-tooltip" attribute
                    } else if (customTipAttr) {
                        tip = $(conf.layout).addClass(conf.tipClass).appendTo(document.body)
                            .hide().append($(customTipAttr));
                        
                    // single tip element to be shared among multiple triggers
                    } else if (conf.tip) { 
                        tip = $(conf.tip).eq(0);
    
                    // autogenerated tooltip
                    } else if (title) { 
                        tip = $(conf.layout).addClass(conf.tipClass).appendTo(document.body)
                            .hide().append(title);
    
                    // manual tooltip (i.e. next element in the DOM -- this is so friggin' stupid)
                    } else {    
                        tip = trigger.next();  
                        if (!tip.length) { tip = trigger.parent().next(); }      
                    }
    
                    if (!tip.length) { throw "Cannot find tooltip for " + trigger;  }
                } 
            },
            
            show: function(e) {  

                self._initTip();
                
                // MDU: store this instance in the tooltip element:
                if (self.usesSharedTip()) {
                    tip.data("tooltip-last-invoker", self);
                }

                // MDU: if we have a tip that's unique to this trigger, then immediately short-circuit out of this method 
                //      when the tip is already shown:
                if (!self.usesSharedTip() && self.isTipShown()) { 
                    return self;
                }  

                // stop previous animation
                tip.stop(true, true);               

                // get position
                var pos = getPosition(trigger, tip, conf);          

                // MDU: couldn't care less about this feature; removed it:
                // restore title for single tooltip element
                //if (conf.tip) {
                //    tip.html(trigger.data("title"));
                //}

                // onBeforeShow
                e = $.Event();
                e.type = "onBeforeShow";
                fire.trigger(e, [pos]);
                
                if (e.isDefaultPrevented()) { 
                    return self; 
                }

                // onBeforeShow may have altered the configuration
                pos = getPosition(trigger, tip, conf);

                // set position
                tip.css({position:'absolute', top: pos.top, left: pos.left});                   

                
                // MDU: if we have a shared (common) tip, then short-circuit out of this method when the shared tip is already shown,
                //      but only after we've fired the onBeforeShow event and updated the tip's positioning:
                if (self.usesSharedTip() && self.isTipShown()) {
                    // flag that this trigger now is active too:
                    shown = true;
                    return self;
                }
                
                // MDU: going through the new setShown method to set shown status for both the trigger and the tip (if shared)
                self.setShown(true);
                //shown = true;
                
                // invoke effect 
                effect[0].call(self, function() {
                    e.type = "onShow";
                    // MDU: going through the new setShown method to set shown status for both the trigger and the tip (if shared)
                    self.setShown('full');
                    //shown = 'full';
                    fire.trigger(e);         
                });                 

                // tooltip events       
                var event = conf.events.tooltip.split(/,\s*/);
                if (!tip.data("__set")) {

                    tip.off(event[0]).on(event[0], function() { 
                        // MDU:
                        tip.clearQueue("tooltip-toggle")
                        //clearTimeout(timer);
                        //clearTimeout(pretimer);
                    });

                    if (event[1] && !trigger.is("input:not(:checkbox, :radio), textarea")) {                    
                        tip.off(event[1]).on(event[1], function(e) {

                            // being moved to the trigger element
                            if (e.relatedTarget != trigger[0]) {
                                trigger.trigger(evt[1].split(" ")[0]);
                            }
                        }); 
                    } 

                    // bind agein for if same tip element
                    if (!self.usesSharedTip()) tip.data("__set", true);
                }

                return self;
            },

            hide: function(e) {

                if (!tip || !self.isTipShown()) { return self; }

                // onBeforeHide
                e = $.Event();
                e.type = "onBeforeHide";
                fire.trigger(e);                
                if (e.isDefaultPrevented()) { return; }

                // MDU: going through the new setShown method to set shown status for both the trigger and the tip (if shared)
                self.setShown(false);
                //shown = false;

                effects[conf.effect][1].call(self, function() {
                    e.type = "onHide";
                    fire.trigger(e);         
                });

                return self;
            },
            
            usesSharedTip: function() {
                return !!conf.tip;
            },

            isShown: function(fully) {
                return fully ? shown === 'full' : shown; 
            },
            
            isTipShown: function(fully) {
                if (self.usesSharedTip()) {
                    var data = tip.data("tooltip-tip");
                    return data && (fully ? data.shown === 'full' : data.shown);
                } else {
                    return self.isShown(fully);
                }
            },
            
            setShown: function(val) {
                shown = val;
                if (self.usesSharedTip()) {
                    tip.data("tooltip-tip", { shown: val });
                }
            },

            getConf: function() {
                return conf;    
            },

            getTip: function() {
                return tip; 
            },

            getTrigger: function() {
                return trigger; 
            },
            
            // MDU: how did this plugin NOT have a destroy method??
            destroy: function (retainTip) {
                if (tip) {
                    tip.removeData("__set");
                    tip.removeData("tooltip-tip");
                    // for now I don't really care about restoring the original tip element...
                    /*
                    if (title) {
                        tip.attr("title", title);
                    }
                    */
                    //var event = conf.events.tooltip.split(/,\s*/);
                    /*
                    if (retainTip && (tipAttr || conf.tip || !title)) {
                        if (conf.tipAttr) {
                            
                        } else if (conf.tip) {
                            
                        } else if (!title) {
                            
                        }
                        tip.off(event[0]).off(event[1]);
                    } else {
                        tip.remove();
                    }
                    */
                    if (retainTip) {
                        // MDU: if this trigger was the last to show the tip element, then hide it:
                        if (self.usesSharedTip() && tip.data("tooltip-last-invoker") === self) {
                            tip.hide().removeData("tooltip-last-invoker");
                        }
                    } else {
                        tip.remove();
                    }
                }
                // restore title:
                if (title && conf.cancelDefault) { 
                    trigger.attr("title", title);
                }
                trigger.off(evt[0] + ".tooltip " + evt[1] + ".tooltip");
                $.each("onHide,onBeforeShow,onShow,onBeforeHide".split(","), function(i, name) {
                    $(self).off(name);
                });
                trigger.removeData("tooltip");
            }

        });     

        // callbacks    
        $.each("onHide,onBeforeShow,onShow,onBeforeHide".split(","), function(i, name) {

            // configuration
            if ($.isFunction(conf[name])) { 
                $(self).on(name, conf[name]); 
            }

            // API
            self[name] = function(fn) {
                if (fn) { $(self).on(name, fn); }
                return self;
            };
        });

    }
    
    // MDU: convenience method
    $.fn.hasTooltip = function () {
        var hasTooltip = false;
        this.each(function() {
            if ($(this).data("tooltip")) {
                hasTooltip = true;
                return false;
            }
        });
        return hasTooltip;
    }

    // jQuery plugin implementation
    $.fn.tooltip = function(conf) {

        // return existing instance
        var api = this.data("tooltip");
        if (api) { return api; }

        conf = $.extend(true, {}, $.tools.tooltip.conf, conf);

        // position can also be given as string
        if (typeof conf.position == 'string') {
            conf.position = conf.position.split(/,?\s/);    
        }

        // install tooltip for each entry in jQuery object
        this.each(function() {
            api = new Tooltip($(this), conf); 
            $(this).data("tooltip", api); 
        });
        
        return conf.api ? api: this;         
    };

}) (jQuery);