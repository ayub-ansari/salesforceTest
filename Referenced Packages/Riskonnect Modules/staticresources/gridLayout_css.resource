
body.rk-standalone form[method="post"][name],
body.rk-nested form[method="post"][name] 
{
    float:none;
    min-width:none;
}

.rkgl-datafeed
{
    display:none;
}

body .selectionPaginator .listViewport > .bottomNav
{
    border: solid #B7BBBD 1px;
    border-width: 0 1px 1px 1px;
    border-bottom-left-radius: 3px;
    border-bottom-right-radius: 3px;
}

/* TODO: fix this!! */
.rkgl-root
{
    height:424px;

    font: normal 11px/15px tahoma, arial, verdana, sans-serif;

    /* TODO: fix this, too: */
    /*background-image: url(/resource/1356812944000/rkme__noise);*/
}

/* The cells in the sizing rows MUST NOT have any border or padding; the grid's column sizing calculations are
 * based on the assumption that inner-width and outer-width (and also inner-height and outer-height) is 
 * exactly the same for these cells -- remember, CSS does not allow us to change the box-sizing model of a <td> 
 * away from "content-box" */
div.rkgl-root div.rkgl-colset-head tr.rkgl-sizing > th,
div.rkgl-root div.rkgl-colset tr.rkgl-sizing > td
{
    padding:0 !important;
    border-width:0 !important;
    height:0px !important;
}

/* Safari gets confused when you immediately shrink a cell to less than its content's width -- it down't shrink 
 * the container div and doesn't clip -- so we rely on the th,td to clip for us: */
.rkgl-root.safari tr.rkgl-header > th,
.rkgl-root.safari tr.rkgl-data > td
{
    overflow: hidden;
}

.rkgl-root tr.rkgl-sizing div.rkgl-wrap
{
    display: none;
}

div.rkgl-root 
{
    position:relative; 
    overflow:hidden;
    /*border:1px solid #D4DADC;*/
    border: 1px solid #B7BBBD;
    border-top-left-radius: 0px;
    border-top-right-radius: 0px;
}

div.rkgl-root > .rkgl-head
{
    z-index:2;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    width:auto;
    position:relative;
    left:0;
    top:0;
    border-top-left-radius: 0px;
    border-top-right-radius: 0px;

    /*border-bottom:1px solid #bfbfbf;*/

    /* fancy, transluscent: */
    /*    
    background-image: -webkit-linear-gradient(top, rgba(240, 243, 245, 0.45) 5%, rgba(166, 168, 170, 0.45) 15%, rgba(237, 240, 243, 0.45) 80%, rgba(124, 125, 126, 0.45) 110%);
    background-image: -moz-linear-gradient(top, rgba(240, 243, 245, 0.45) 5%, rgba(166, 168, 170, 0.45) 15%, rgba(237, 240, 243, 0.45) 80%, rgba(124, 125, 126, 0.45) 110%);
    background-image: -ms-linear-gradient(top, rgba(240, 243, 245, 0.45) 5%, rgba(166, 168, 170, 0.45) 15%, rgba(237, 240, 243, 0.45) 80%, rgba(124, 125, 126, 0.45) 110%);
    background-image: linear-gradient(top, rgba(240, 243, 245, 0.45) 5%, rgba(166, 168, 170, 0.45) 15%, rgba(237, 240, 243, 0.45) 80%, rgba(124, 125, 126, 0.45) 110%);
    */

    /* fancy:*/
    /*
    background-image: -webkit-linear-gradient(top, #F0F3F5 5%, #DCDFE1 15%, #F0F3F6 80%, #AFB1B5 130%);
    background-image: -moz-linear-gradient(top, #F0F3F5 5%, #DCDFE1 15%, #F0F3F6 80%, #AFB1B5 130%);
    background-image: -ms-linear-gradient(top, #F0F3F5 5%, #DCDFE1 15%, #F0F3F6 80%, #AFB1B5 130%);
    background-image: linear-gradient(top, #F0F3F5 5%, #DCDFE1 15%, #F0F3F6 80%, #AFB1B5 130%);
    */

    /* clean: */
    /*
    background-image: -webkit-linear-gradient(top, #eee 0%, #ccc 110%);
    background-image: -moz-linear-gradient(top, #eee 0%, #ccc 110%);
    background-image: -ms-linear-gradient(top, #eee 0%, #ccc 110%);
    background-image: linear-gradient(top, #eee 0%, #ccc 110%);
    */
    
    /*
    background-image: -webkit-linear-gradient(top, #fefefe 0%, #ccc 110%);
    background-image: -moz-linear-gradient(top, #fefefe 0%, #ccc 110%);
    background-image: -ms-linear-gradient(top, #fefefe 0%, #ccc 110%);
    background-image: linear-gradient(top, #fefefe 0%, #ccc 110%);
    */
}

div.rkgl-colset-head
{
    position:absolute;
    top:0;
    /*left:0;*/
    z-index:1;
    /*width:100%;*/
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;

    /*border-bottom:1px solid #bfbfbf;*/

    /* TODO: fix this!! */
    background-image: url(/resource/1356812944000/rkme__noise);

    overflow:visible;
}

/*div.rkgl-colset-head[rkgl-colset=locked]*/
div.rkgl-colset-head.rkgl-locked-head
{
    border-right: solid #bbb 1px;
    box-shadow: #888 5px 0px 10px -5px;
    /* necessary so that the locked colset's head can project its border-shadow over the scrollable colset's head's background image: */
    z-index: 2;
}

/*div.rkgl-colset[rkgl-colset=locked]*/
div.rkgl-colset.rkgl-locked
{
    /*
    border-right: solid #aaa 1px;
    box-shadow: #888 5px 0px 10px -5px;
    */
    border-right: solid #ccc 1px;
    box-shadow: #888 4px 0px 11px -5px;
    z-index: 1;
}

/*div.rkgl-colset[rkgl-colset=locked]*/
div.rkgl-colset.rkgl-locked
{
    overflow: hidden;
}

div.rkgl-colset.rkgl-scrollable
{
    /*
    overflow-x: auto;
    overflow-y: auto;
    */
    overflow-x: hidden;
    overflow-y: hidden;
}

/*
div.rkgl-colset.rkgl-scrollable.showing-pad-col
{
    overflow-x: hidden;
}
*/

div.rkgl-colset.rkgl-scrollable.rkgl-hscroll
{
    overflow-x: auto;
}

div.rkgl-colset.rkgl-scrollable.rkgl-vscroll
{
    overflow-y: auto;
}

tr.rkgl-header > th
{
    /*
    border-right: solid #cdcdcd 1px;
    border-left: solid #f5f5f5 1px;
    border-bottom:1px solid #bfbfbf;
    padding: 7px 3px 7px 4px;
    padding: 7px 1em 7px 1em;
    */
    
    font-size: 0.9em;
    vertical-align: middle;
    color: #555;
    font-weight:bold;

    background: rgb(235,234,234);
    background: rgba(194, 189, 189, 0.31);

    /* fancy, transluscent: */
    /*    
    background: -webkit-linear-gradient(top, rgba(240, 243, 245, 0.45) 5%, rgba(166, 168, 170, 0.45) 15%, rgba(237, 240, 243, 0.45) 80%, rgba(124, 125, 126, 0.45) 110%);
    background: -moz-linear-gradient(top, rgba(240, 243, 245, 0.45) 5%, rgba(166, 168, 170, 0.45) 15%, rgba(237, 240, 243, 0.45) 80%, rgba(124, 125, 126, 0.45) 110%);
    background: -ms-linear-gradient(top, rgba(240, 243, 245, 0.45) 5%, rgba(166, 168, 170, 0.45) 15%, rgba(237, 240, 243, 0.45) 80%, rgba(124, 125, 126, 0.45) 110%);
    background: linear-gradient(top, rgba(240, 243, 245, 0.45) 5%, rgba(166, 168, 170, 0.45) 15%, rgba(237, 240, 243, 0.45) 80%, rgba(124, 125, 126, 0.45) 110%);
    */
}

tr.rkgl-header > th .rkgl-head-outer
{
    position: relative;
    padding: 7px 1em;
}

.rkgl-plucked tr.rkgl-header > th .rkgl-head-outer .rkgl-right-edge
{
    display: none;
}

.rkgl-plucked tr.rkgl-header > th .rkgl-head-outer .rkgl-right-edge
{
    display: inline;
    position: absolute;
    width: 1px;
    right: 0;
    background: rgb(80,180,240);
    z-index: 1;
}

tr.rkgl-header > th .rkgl-head-outer .rkgl-bottom-edge
{
    position: absolute;
    height: 1px;
    left: 0;
    right: 0;
    /*background: rgba(161, 165, 167, 0.5);*/
    background: rgba(169, 175, 179, 0.35);
    z-index: 1;
}

tr.rkgl-header > th .rkgl-head-outer .rkgl-left-inner-edge
{
    position: absolute;
    width: 1px;
    left: 1px;
    background: rgb(242,243,243);
    background: rgba(255,255,255,0.7);
    background: -webkit-linear-gradient(top, rgba(255,255,255,0.0) 15%, rgba(255,255,255,1.0) 100%);
    background: -moz-linear-gradient(top, rgba(255,255,255,0.0) 15%, rgba(255,255,255,1.0) 100%);
    background: -ms-linear-gradient(top, rgba(255,255,255,0.0) 15%, rgba(255,255,255,1.0) 100%);
}

.rkgl-plucked tr.rkgl-header > th .rkgl-head-outer .rkgl-left-inner-edge
{
    display: none;
}

tr.rkgl-header > th .rkgl-head-outer .rkgl-left-outer-edge
{
    position: absolute;
    width: 1px;
    left: 0px;
    background: rgb(193,194,195);
    background: rgba(139,139,139,0.6);
    background: -webkit-linear-gradient(top, rgba(139,139,139,0.0) 15%, rgba(139,139,139,1.0) 100%);
    background: -moz-linear-gradient(top, rgba(139,139,139,0.0) 15%, rgba(139,139,139,1.0) 100%);
    background: -ms-linear-gradient(top, rgba(139,139,139,0.0) 15%, rgba(139,139,139,1.0) 100%);
}

.rkgl-plucked tr.rkgl-header > th .rkgl-head-outer .rkgl-left-outer-edge
{
    background-image: none;
    background: rgb(80,180,240);
}

tr.rkgl-header > th.first .rkgl-head-outer .rkgl-left-inner-edge,
tr.rkgl-header > th.first .rkgl-head-outer .rkgl-left-outer-edge
{
    background: none;
}

tr.rkgl-header > th.first
{
    border-left: none;
}

tr.rkgl-header > th a
{
    text-decoration:none;
    color: #555;
}

div.rkgl-colset-head > table
{
    /*table-layout:fixed !important;*/
    border-left:none !important;
    border-bottom:none !important;
    border-right:none !important;
    /* TODO fix this */
    /*width: 715px;*/
}

div.rkgl-colset
{
    position: absolute;
    bottom: 0;
    overflow: auto;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    /* TODO fix this */
    /*height:400px;*/
}

/*
tr.rkgl-sizing > td
{
    height:0px;
}

tr.rkgl-sizing > td > .rkgl-wrap
{
    height:0px;
}
*/

div.rkgl-root > div.rkgl-colset > table
{
    /*table-layout:fixed !important;*/
    /*border-top:1px solid #D4DADC !important;*/
    border-right:none !important;
    border-bottom: none !important;
    border-left: none !important;
}

tr.rkgl-data > td
{
    /*padding:3px 3px 3px 4px;*/
    padding:3px 1em 3px 1em;
}

tr.rkgl-data.odd > td
{
    /*background-color:white;
      border-bottom:solid #EBEEF1 1px;*/
    background-color:rgb(250,250,250);
    border-top:solid rgb(254,254,254) 1px;
    border-bottom:solid rgb(238,238,238) 1px;
}

tr.rkgl-data.even > td
{
    /*background-color:#F4F7FA;
      border-bottom:solid #EBEEF1 1px;*/
    background-color:rgb(242,245,248);
    border-top:solid rgb(248,249,252) 1px;
    border-bottom:solid rgb(234,236,238) 1px;
}

.rkgl-wrap
{
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}

.rkgl-root th.rkgl-sizing,
.rkgl-root td.rkgl-sizing
{
    width: 0;
    height: auto;
    visibility: hidden;
    padding: 0 !important;
    border: none !important;
}

/* Field metadata type specific styles: */

.rkgl-root th.type-currency,
.rkgl-root td.type-currency,
.rkgl-root th.type-double,
.rkgl-root td.type-double,
.rkgl-root th.type-integer,
.rkgl-root td.type-integer,
.rkgl-root th.type-percent,
.rkgl-root td.type-percent
{
    text-align:right;
}
.rkgl-root.compact th.type-currency,
.rkgl-root.compact td.type-currency,
.rkgl-root.compact th.type-double,
.rkgl-root.compact td.type-double
{
    width:1px;
    white-space:nowrap;
}

.rkgl-root td.type-currency.editable input
{
    text-align:right;
}
.rkgl-root.compact td.type-currency.editable input
{
    width:7.5em;
}

.rkgl-root td.type-double.editable input
{
    text-align:right;
}
.rkgl-root.compact td.type-double.editable input
{
    width:9.5em;
}

.rkgl-root.compact th.type-percent,
.rkgl-root.compact td.type-percent
{
    width:1px;
    white-space:nowrap;
}

.rkgl-root td.type-percent.editable input
{
    width:4em;
    text-align:right;
}

.rkgl-root th.type-boolean,
.rkgl-root td.type-boolean {
    text-align:center;
}

.rkgl-root.compact td.type-reference,
.rkgl-root.compact td.type-boolean,
.rkgl-root.compact td.type-picklist,
.rkgl-root.compact td.type-date
{
    width:1px;
    white-space:nowrap;
}

.rkgl-root td.type-reference input[type=text]
{
    vertical-align:middle;
}

.rkgl-root td.type-reference select
{
    vertical-align:middle;
}

.rkgl-root td.type-date .dateFormat
{
    display:none;
}

.rkgl-root.compact td.type-string input
{
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    width:100%;
    min-width:10em;
}

.rkgl-root td.type-textarea textarea
{
    box-sizing:border-box;
    -moz-box-sizing:border-box;
    width:100%;
    min-width:10em;
}

.rkgl-root.compact td.type-textarea textarea
{
    height:2em;
}

/*
.rkgl-colset-head th
{
    position: relative;
}
*/

.rkgl-resize-handle
{
    border-radius: 2px;
    /*border-radius: 4px;*/
    /*
    background: rgb(21, 142, 236);
    background-image: -webkit-linear-gradient(top, rgba(21, 142, 236, 0.5) 0%, rgba(21, 142, 236, 1) 100%);
    background-image: -moz-linear-gradient(top, rgba(21, 142, 236, 0.5) 0%, rgba(21, 142, 236, 1) 100%);
    */
    background: rgb(77,144,254);
    background: rgba(77,144,254,0.9);
    background: -webkit-linear-gradient(top, rgba(77,144,254,1), rgba(77,144,254,1));
    background: -moz-linear-gradient(top, rgba(77,144,254,1), rgba(77,144,254,1));
    background: -ms-linear-gradient(top, rgba(77,144,254,1), rgba(77,144,254,1));

    /*background: rgb(124,171,248);*/

    position: absolute;
    width: 6px;
    /*width: 8px;*/
    top: 0;
    bottom: 0;
    display:none;
    cursor:col-resize;
    z-index:4;
}

.rkgl-resize-ruler
{
    /*background-color: rgb(21, 142, 236);*/
    background: rgb(87,149,214);
    background: -webkit-linear-gradient(top, rgb(21, 142, 236) 0%, rgb(2, 24, 115) 100%);
    background: -moz-linear-gradient(top, rgb(21, 142, 236) 0%, rgb(2, 24, 115) 100%);
    background: -ms-linear-gradient(top, rgb(21, 142, 236) 0%, rgb(2, 24, 115) 100%);
    position: absolute;
    width: 2px;
    display: none;
    z-index: 4;
}

.rkgl-resize-area
{
    /*background-color: rgb(21, 142, 236);*/
    /*background-image: -webkit-linear-gradient(top, rgb(21, 142, 236) 0%, rgb(8, 75, 152) 100%);*/
    background: rgba(130,181,225,0.6);
    background: -webkit-linear-gradient(top, #32A4FD 0%, #00397C 100%);
    background: -moz-linear-gradient(top, #32A4FD 0%, #00397C 100%);
    background: -ms-linear-gradient(top, #32A4FD 0%, #00397C 100%);
    position: absolute;
    display: none;
    z-index: 3;
}

.rkgl-resize-area.rkgl-negative-area
{
    /*background-color: rgb(236, 102, 81);*/
    /*background-image: -webkit-linear-gradient(top, rgb(236, 102, 81) 0%, rgb(152, 52, 31) 100%);*/
    background: rgba(219,155,145,0.6);
    background: -webkit-linear-gradient(top, #EC614B 0%, #3C0901 100%);
    background: -moz-linear-gradient(top, #EC614B 0%, #3C0901 100%);
    background: -ms-linear-gradient(top, #EC614B 0%, #3C0901 100%);
}

.rkgl-pholder
{
    /*
    background-color: #bfbfbf !important;
    background-image: -webkit-linear-gradient(left, #BBB 0%, #666 130%) !important;
    background-image: -moz-linear-gradient(left, #BBB 0%, #666 130%) !important;
    background-image: -ms-linear-gradient(left, #BBB 0%, #666 130%) !important;
    background-image: linear-gradient(left, #BBB 0%, #666 130%) !important;
    */
    
    background-color: #888 !important;
    
    border: none !important;
    /*
    border-top: none !important;
    border-right: none !important;
    border-left: none !important;
    border-bottom: 1px solid red !important;
    */
}

/*
th.rkgl-pholder
{
    background-image: none !important;
    border-bottom: 4px solid red !important;
}
*/

.rkgl-plucked
{
    position: absolute !important;
    /*opacity: 0.6;*/
    /*z-index: 2 !important;*/
}

.rkgl-plucked tr.rkgl-data.odd td
{
    /*background-color:rgba(255,255,255,0.7);*/
    background-color:rgba(250,250,250,0.7);
    border-top:solid rgba(254,254,254,0.2) 1px;
    /*border-bottom:solid rgba(238,238,238,0.2) 1px;*/
    border-bottom:solid rgba(168,168,168,0.2) 1px;
}

.rkgl-plucked tr.rkgl-data.even td
{
    background-color:rgba(242,245,248,0.7);
    border-top:solid rgba(248,249,252,0.2) 1px;
    /*border-bottom:solid rgba(234,236,238,0.2) 1px;*/
    border-bottom:solid rgba(164,166,168,0.2) 1px;
}

.rkgl-root .rkgl-colset-head tr.rkgl-header > th.rkgl-depressed
{
    /* fancy: */
    /*
    background-image: -webkit-linear-gradient(top, rgba(202, 231, 255, 0.6) 5%, rgba(94, 187, 243, 0.6) 15%, rgba(192, 227, 248, 0.6) 80%, rgba(1, 75, 150, 0.6) 130%);
    background-image: -moz-linear-gradient(top, rgba(202, 231, 255, 0.6) 5%, rgba(94, 187, 243, 0.6) 15%, rgba(192, 227, 248, 0.6) 80%, rgba(1, 75, 150, 0.6) 130%);
    */
    
    /*
    background-image: -webkit-linear-gradient(top, #E1F0FA 5%, #A9D2EB 15%, #D1EcFc 80%, #4888cb 130%);
    background-image: -moz-linear-gradient(top, #E1F0FA 5%, #A9D2EB 15%, #D1EcFc 80%, #4888cb 130%);
    background-image: -ms-linear-gradient(top, #E1F0FA 5%, #A9D2EB 15%, #D1EcFc 80%, #4888cb 130%);
    background-image: linear-gradient(top, #E1F0FA 5%, #A9D2EB 15%, #D1EcFc 80%, #4888cb 130%);
    */

    /* clean: */
    /*
    background-image: -webkit-linear-gradient(top, #A9D2EB 0%, #D1ECFC 130%);
    background-image: -moz-linear-gradient(top, #A9D2EB 0%, #D1ECFC 130%);
    background-image: -ms-linear-gradient(top, #A9D2EB 0%, #D1ECFC 130%);
    background-image: linear-gradient(top, #A9D2EB 0%, #D1ECFC 130%);
    */
    
    /*
    border-right: solid rgb(80,180,240) 1px;
    border-left: solid rgb(80,180,240) 1px;
    padding-left: 1em;
    padding-right: 1em;
    */

    background: rgb(172,201,247);
    background: rgba(54,123,233,0.4);
    background: -webkit-linear-gradient(top, rgba(54,123,233,0.6), rgba(77,144,254,0.2));
    background: -moz-linear-gradient(top, rgba(54,123,233,0.6), rgba(77,144,254,0.2));
    background: -ms-linear-gradient(top, rgba(54,123,233,0.6), rgba(77,144,254,0.2));
}

.rkgl-root .rkgl-colset-head.rkgl-plucked tr.rkgl-header > th.rkgl-depressed
{
    /*background-image: -webkit-linear-gradient(top, #E1F0FA 5%, #A9D2EB 15%, #D1EcFc 80%, #4888cb 130%);*/
    /*
    background-image: -webkit-linear-gradient(top, rgba(220, 236, 250, 0.8) 5%, rgba(146, 204, 240, 0.8) 14%, rgba(204, 233, 252, 0.8) 80%, rgba(98, 145, 194, 0.8) 130%);
    background-image: -moz-linear-gradient(top, rgba(220, 236, 250, 0.8) 5%, rgba(146, 204, 240, 0.8) 14%, rgba(204, 233, 252, 0.8) 80%, rgba(98, 145, 194, 0.8) 130%);
    */
        
    background: rgb(172,201,247);
    background: rgba(54,123,233,0.4);
    background: -webkit-linear-gradient(top, rgba(54,123,233,0.6) 0%, rgba(77,144,254,0.2) 100%);
    background: -moz-linear-gradient(top, rgba(54,123,233,0.6) 0%, rgba(77,144,254,0.2) 100%);
    background: -ms-linear-gradient(top, rgba(54,123,233,0.6) 0%, rgba(77,144,254,0.2) 100%);
    background: linear-gradient(top, rgba(54,123,233,0.6) 0%, rgba(77,144,254,0.2) 100%);
}

.rkgl-root .rkgl-colset-head tr.rkgl-header > th.first.rkgl-depressed
{
    border-left: none;
}

/* ensure that placeholder cells' content-box size is the exactly the same as its border-box size: */
.rkgl-root .rkgl-colset-head tr.rkgl-header > th.rkgl-pholder
{
    padding: 0 !important;
    border: none !important;
}

.rkgl-root .rkgl-colset tr > th.rkgl-pholder,
.rkgl-root .rkgl-colset tr.rkgl-data > td.rkgl-pholder
{
    padding: 0 !important;
    border: none !important;
}

.rkgl-root div.rkgl-plucked.rkgl-colset
{
    overflow: hidden !important;
}

.rkgl-root div.rkgl-plucked.rkgl-colset
{
    border-right: solid rgb(80,180,240) 1px;
    border-left: solid rgb(80,180,240) 1px;
}

div.rkgl-colset-head th.rkgl-pad,
div.rkgl-colset th.rkgl-pad,
div.rkgl-colset td.rkgl-pad
{
    display: none;
}

/* in the case of .rkgl-hscroll, we need to show the pad col as a shim to cover the vertical scrollbar's width */
div.rkgl-colset-head.rkgl-hscroll th.rkgl-pad
{
    display: table-cell;
}

div.rkgl-colset-head.showing-pad-col th.rkgl-pad,
div.rkgl-colset.showing-pad-col th.rkgl-pad,
div.rkgl-colset.showing-pad-col td.rkgl-pad
{
    display: table-cell;
}

/*
.rkgl-root div.rkgl-plucked.rkgl-colset tr.rkgl-data > td
{
    border-right: solid rgb(80,180,240) 1px;
    border-left: solid rgb(80,180,240) 1px;
    padding-left: 3px;
    padding-right: 2px;
}
*/

.rkgl-root th .sortOrdinal {
    color: #9E7272 !important;
}

/* this should be tall enough to match or exceed any native horizontal-scrollbar's height: */
.rkgl-height-shim {
    width: 1px;
    height: 50px;
}

