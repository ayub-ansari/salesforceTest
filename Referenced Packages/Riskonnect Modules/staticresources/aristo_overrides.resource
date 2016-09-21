
.ui-dialog .ui-dialog-titlebar
{
    -webkit-border-top-left-radius: 3px;
    -webkit-border-top-right-radius: 3px;
    -moz-border-top-left-radius: 3px;
    -moz-border-top-right-radius: 3px;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}

.ui-dialog .ui-dialog-title
{
    font-size: 1.1em;
}

.ui-widget
{
    font-size: 1.0em;
}

/*
.ui-widget-content
{
    border: solid 1px #ddd;
}
*/

.ui-corner-all
{
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
}

.ui-widget-overlay
{
    background: #222D3F;
}

.ui-button .ui-button-text
{
    font-size: 1.0em;
	white-space: nowrap;
}

.ui-dialog
{
    -moz-box-shadow: 0px 5px 8px rgba(0, 0, 0, 0.8);
    -webkit-box-shadow: 0px 5px 8px rgba(0, 0, 0, 0.8);
    box-shadow: 0px 5px 8px rgba(0, 0, 0, 0.8);
}

/* force-override any vforce styles that may muck up our Aristo styles: */

body .rk-nested button:hover,
body .rk-standalone button:active,
body .pbBody button:hover,
body .pbBody button:active,
body .apexp button:hover,
body .apexp button:active,
body .DialogOuterBar button:hover,
body .DialogOuterBar button:active,
body .DialogOuterBar button:hover,
body .DialogOuterBar button:active
{
    background-position: 0 0;
}

body .apexp button:active
{
    border-color: #7096AB;
}
