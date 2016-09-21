
html, body {
    /* These styles are required for IE 6 to render these pages, maybe 7/8?.
     * These styles are superfluous (but harmless) for Firefox, Safari, Chrome... */
    width:auto;
    height:100%;
}

/* z-index fixes are so that SFDC popups overlay on top of our inline dialogs */

body .datePicker {
    z-index: 102;
}

body .autoCompleteBox, body .autoCompleteBoxScrolling {
    z-index:103;
}

body.setupTab.FormBody{
    margin:0;
}

.FormBody.bPageBlock {
    background:none;
    padding:0 0 0 0;
    border:none;
}

body .FormTopOuter .FormTopInner .FormContent {
    border-left-color:#cfcfcf;
    border-right-color:#cfcfcf;
    border-bottom-color:#cfcfcf;
    padding:10px 15px 2px 15px;
}

body .FormTopOuter .FormTopInner .FormContent.pinstripes {
    /* border-top:none; */
    border-top: solid #cfcfcf 1px;
    border-right: solid #cfcfcf 1px;
    border-bottom: solid #cfcfcf 1px;
    border-left: solid #cfcfcf 1px;
    border-top-left-radius: 6px;
    border-top-right-radius: 6px;
    border-bottom-left-radius: 6px;
    border-bottom-right-radius: 6px;
    -moz-border-radius-topleft: 6px;
    -moz-border-radius-topright: 6px;
    -moz-border-radius-bottomleft: 6px;
    -moz-border-radius-bottomright: 6px;
    border-width:3px;
    /*
    background-color:#f3f3ec;
    background-image:none;
    */
    background-color: #F4F4ED;
}

.FormTopOuter .FormTopInner .FormContent .FormFooter {
    padding:8px 12px;
    border-top-color:#ffffff;
}

.FormTopOuter .FormTopInner .FormContent .FormFooter.noBorder {
    border:none;
}

.FormTopOuter .FormTopInner .FormContent .FormFooter.padAll {
    padding:8px 12px;
}

.FormTopOuter .FormTopInner .FormContent .FormFooter.padTB {
    padding:8px 0;
}

body .FormTopOuter .FormTopInner .FormContent .FormFooter.noPadTop {
    padding-top:0px;
}

.FormTopOuter .FormTopInner .FormContent .FormHeader {
    padding:8px 12px;
    border-bottom-color:#d8d8d8;
}

.FormTopOuter .FormTopInner .FormContent .FormHeader.padAll {
    padding:8px 12px;
}

.FormTopOuter .FormTopInner .FormContent .FormHeader.padTB {
    padding:8px 0px;
}

.FormTopOuter .FormTopInner .FormContent .FormHeader.noBorder {
    border:none;
}

.FormTopOuter .FormTopInner .FormContent .FormHeader.noTopDec {
    padding-top:0;
}

.FormTopOuter .FormTopInner .FormContent .FormHeader.noBottomDec {
    border-bottom:none;
    padding-bottom:0;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv {
    padding:0;
    border-bottom-color:#d8d8d8;
    /*
    background-color:#F3F3EC;
    background-image:url(/img/bgScanline.gif);
    */
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.padAll {
    padding:8px 12px;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.padNone {
    padding:0;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.padLR {
    padding:0 12px;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.padTB {
    padding:8px 0;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.noBorder {
    border:none;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.noTopBorder {
    border-top:none;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.noBottomBorder {
    border-bottom:none;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.noTopDec {
    border-top:none;
    padding-top:0;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.noBottomDec {
    border-bottom:none;
    padding-bottom:0;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv.noDec {
    border:none;
    padding:0;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivTitle {
    font-size: 100%; 
    padding-left: 12px;
    padding-right: 12px;
    border-top: none;
    margin:0;

    background-color:#6E7D9E;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivTitle.pinstripes {
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    border-bottom-left-radius: 4px;
    border-bottom-right-radius: 4px;
    -moz-border-radius-topleft: 4px;
    -moz-border-radius-topright: 4px;
    -moz-border-radius-bottomleft: 4px;
    -moz-border-radius-bottomright: 4px;
}

/*
.FormTopOuter .FormTopInner .FormContent .FormInnerScroll .FormDiv .FormDivTitle {
    border-radius:0px;
    -moz-border-radius:0px;
}
*/

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivContent {
    padding:8px 12px;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivContent.padAll {
    /*padding:8px 12px;*/
    padding:8px 2px 8px 12px;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivContent.padNone {
    padding:0;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivContent.padTB {
    padding:8px 0;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivContent.padLR {
    padding:0 12px;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivContent.noTopDec {
    border-top:none;
    padding-top:0;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivContent.padTop {
    padding-top:8px;
}

.FormTopOuter .FormTopInner .FormContent .FormDiv .FormDivContent.noBottomDec {
    border-bottom:none;
    padding-bottom:0;
}

body .FormFooter.buttonsBar {
    text-align:center;
}

.FormFooter.buttonsBar .btn {
    margin-right:5px;
}

/* following styles are for the banner component: */

.actionFunctionLink {
    color:#015BA7;
    font-weight:bold;
    text-decoration:none;
    cursor:pointer;
    font-size:90%;
}

a:hover .actionFunctionLink {
    text-decoration:underline;
}

.actionLinkArrow{
    cursor:pointer;
    margin-right:3px;
}

.requiredMessage {
    color:#d21e00;
}

.FormTopOuter .FormTopInner table.list {
    border:solid #CCC 1px;
    border-collapse:collapse;
}

.FormTopOuter .FormTopInner table.list {
    border:solid #CCC 1px;
    border-collapse:collapse;
}

body.bPageBlock .FormTopOuter table.list tr.headerRow th, 
body.bPageBlock .DialogOuterBaz table.list tr.headerRow th {
    background: #B2E6FB;
}

/* ==============================================================================================================================================
 * Visualforce style overrides:
 * ==============================================================================================================================================
 */

/* this covers for when we don't have a container .bPageBlock */
.rk-nested .requiredInput,
.rk-standalone .requiredInput
{
    position: relative;
}

/* this covers for when we don't have a container .bPageBlock */
.rk-nested .requiredInput .requiredBlock,
.rk-standalone .requiredInput .requiredBlock
{
    background-color: #C00;
    position: absolute;
    left: -3px;
    width: 2px;
    top: 1px;
    bottom: 1px;
}

body.bPageBlock .pbBody  {
    margin:0;
}

body .pageMessage .message,
body.rk-nested .message,
body.rk-standalone .message {
    margin:0;
}

body .FormTopOuter .message
{
    background-color:rgb(255,255,221);
    background-color:rgba(255,255,203,0.6);
}

body .DialogOuterBar .rk-darkness .message,
body .DialogOuterBar .message.rk-darkness
{
    padding: 12px;
    border-width: 3px;
    background-color: rgba(80, 80, 80);
    background-color: rgba(40, 40, 40, 0.85);
    background: linear-gradient(top, rgba(80, 80, 80, 0.8) 0%, rgba(0, 0, 0, 0.9) 100%);
    background: -webkit-linear-gradient(top, rgba(80, 80, 80, 0.8) 0%, rgba(0, 0, 0, 0.9) 100%);
    background: -moz-linear-gradient(top, rgba(80, 80, 80, 0.8) 0%, rgba(0, 0, 0, 0.9) 100%);
    background: -ms-linear-gradient(top, rgba(80, 80, 80, 0.8) 0%, rgba(0, 0, 0, 0.9) 100%);
}

.DialogOuterBar .message .errorDetail {
    color: #d74c3b; /* #c00 */
}

.DialogOuterBar .rk-darkness>.message .errorDetail {
    color: #F09898;
}

.DialogOuterBar .rk-darkness .message td.messageCell,
.DialogOuterBar .message.rk-darkness td.messageCell,
.DialogOuterBar .rk-darkness .message td.messageCell .messageText,
.DialogOuterBar .message.rk-darkness td.messageCell .messageText 
{
    color: white;
}

.DialogOuterBar .rk-darkness .message td.messageCell a,
.DialogOuterBar .message.rk-darkness td.messageCell a,
.DialogOuterBar .rk-darkness .message td.messageCell .messageText a,
.DialogOuterBar .message.rk-darkness td.messageCell .messageText a
{
    color: #cdcdcd;
}

.DialogOuterBar .rk-darkness .message td.messageCell a:hover,
.DialogOuterBar .message.rk-darkness td.messageCell a:hover,
.DialogOuterBar .rk-darkness .message td.messageCell .messageText a:hover,
.DialogOuterBar .message.rk-darkness td.messageCell .messageText a:hover
{
    color: white;
}


.DialogOuterBar .rk-darkness .message td.messageCell .error,
.DialogOuterBar .message.rk-darkness td.messageCell .error,
.DialogOuterBar .rk-darkness .message td.messageCell .messageText .error,
.DialogOuterBar .message.rk-darkness td.messageCell .messageText .error
{
    color: #ff7766;
}

/* BEGIN Fallbacks for older IE versions: */

body .DialogOuterBar .message,
.no-rgba body .DialogOuterBar .message 
{
    background-color:rgb(255,255,221);
    background-color:rgba(255,255,203,0.6);
}

.DialogOuterBar .message td.messageCell,
.DialogOuterBar .message td.messageCell .messageText,
.no-rgba .DialogOuterBar .message td.messageCell,
.no-rgba .DialogOuterBar .message td.messageCell .messageText 
{
    color: black;
}

.DialogOuterBar .message td.messageCell a,
.DialogOuterBar .message td.messageCell .messageText a,
.no-rgba .DialogOuterBar .message td.messageCell a,
.no-rgba .DialogOuterBar .message td.messageCell .messageText a
{
    color: black;
    text-decoration: underline;
}

.DialogOuterBar .message td.messageCell a:hover,
.DialogOuterBar .message td.messageCell .messageText a:hover,
.no-rgba .DialogOuterBar .message td.messageCell a:hover,
.no-rgba .DialogOuterBar .message td.messageCell .messageText a:hover
{
    color: rgb(1,91,167);
}

.DialogOuterBar .message td.messageCell .error,
.DialogOuterBar .message td.messageCell .error,
.DialogOuterBar .message td.messageCell .messageText .error,
.DialogOuterBar .message td.messageCell .messageText .error,
.no-rgba .DialogOuterBar .message td.messageCell .error,
.no-rgba .DialogOuterBar .message td.messageCell .error,
.no-rgba .DialogOuterBar .message td.messageCell .messageText .error,
.no-rgba .DialogOuterBar .message td.messageCell .messageText .error
{
    color: #c00;
}

/* END of Fallbacks for older IE versions */

body .pageMessage .message .messageText span {
    display:inline-block;
}

body .DialogOuterBaz .message .messageText span {
    display:inline-block;
}

body .DialogOuterBaz .message .messageText li > span {
    /*display:block;*/
}

body .DialogOuterBaz .rkon.message .messageText span {
    display:inline;
}

body .rkon.message .messageText a {
    margin:0;
    font-size:100%;
}

body .message {
    background-color:#FFD;
}

body .message ul,
body .message ol {
    margin:0 0 0 0;
    display:inline-block;
}

body .rkon.message ul, body .rkon.message ol {
    display:block;
}

body .message li {
    margin-left:0;
}

.bPageBlock .requiredInput div.requiredBlock {
    width:2px;
    left:-3px;
}

/* ==============================================================================================================================================
 * Help Orb
 * ==============================================================================================================================================
 */

.rk-helpButton,
.rk-helpButtonOn {
    position: relative;
}

.rk-helpButton .rk-helpOrb {
    background-position: top left;
}

.rk-helpButtonOn .rk-helpOrb {
    background-position: top right;
}

.rk-helpOrb {
    /*background-image: url(/img/help/helpOrbs.gif);*/
    width: 20px;
    height: 15px;
    position: absolute;
    right: -23px;
}

/* ==============================================================================================================================================
 * Styles for custom Dojo Widgets:
 * ==============================================================================================================================================
 */

.submitBlockingPane {
    overflow:hidden; 
    background-color:#000000;
    /*
    filter:alpha(opacity=56); 
    */
    /*
    opacity:0.56; 
    -moz-opacity:0.56;
    */
    -moz-opacity:0.65; 
    -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=65)"; 
    filter:alpha(opacity=65); 
    opacity:0.65; 
    cursor:progress; 
    /* Increased this from 10 to get it on top of SFDC's menuButton/appSwitcher header widgets: */
    z-index:100;
    /* display:none;*/
}

.submitBlockingPane.forDialog {
    cursor:auto;
}

body a.dialogControlsLink {
    color:#fefefe;
    cursor:pointer;
    text-decoration:none;
}

body .dialogControlsSep {
    color:#fefefe;
    margin:0 3px;
    text-decoration:none;
}

body a.dialogControlsLink:hover {
    color:white;
    text-decoration:underline;
}

body .rconVForceDialog img.dialogClose.disabled,
body .rconVForceDialog img.dialogCloseOn.disabled {
    background-position: 0px -60px;
}

body .rconVForceDialog .dialogClose {
    background-position: 0px 0px;
}

body .rconVForceDialog .dialogCloseOn {
    background-position: 0 -20px;
}

body .rconVForceDialog td.dialogCloseCell {
    padding:0 12px 0 0;
}

/* ==============================================================================================================================================
 * ==============================================================================================================================================
 */

.FormTopOuter .FormTopInner .FormContent div.FormInnerScroll .FormDiv .FormDivTitle {
    margin:3px 0;
}

.DialogOuterBar .rk-darkness .confirmM6, 
.DialogOuterBar .rk-darkness .confirmM4, 
.DialogOuterBar .rk-darkness .confirmM3, 
.DialogOuterBar .rk-darkness .confirmM2, 
.DialogOuterBar .rk-darkness .confirmS1,
.DialogOuterBar .rk-darkness.confirmM6, 
.DialogOuterBar .rk-darkness.confirmM4, 
.DialogOuterBar .rk-darkness.confirmM3, 
.DialogOuterBar .rk-darkness.confirmM2, 
.DialogOuterBar .rk-darkness.confirmS1 
{
    border-color: #AEE095;
}

.FormTopOuter .infoM6, .FormTopOuter .infoM4, .FormTopOuter .infoM3, .FormTopOuter .infoM2, .FormTopOuter .infoS1,
.DialogOuterBar .infoM6, .DialogOuterBar .infoM4, .DialogOuterBar .infoM3, .DialogOuterBar .infoM2, .DialogOuterBar .infoS1 {
    /*
    border-color:rgb(94,182,253);
    border-color:rgba(51,153,255,0.7);
    */
    border-color: rgb(183,216,251);
}

.DialogOuterBar .rk-darkness .infoM6, 
.DialogOuterBar .rk-darkness .infoM4, 
.DialogOuterBar .rk-darkness .infoM3, 
.DialogOuterBar .rk-darkness .infoM2, 
.DialogOuterBar .rk-darkness .infoS1,
.DialogOuterBar .rk-darkness.infoM6, 
.DialogOuterBar .rk-darkness.infoM4, 
.DialogOuterBar .rk-darkness.infoM3, 
.DialogOuterBar .rk-darkness.infoM2, 
.DialogOuterBar .rk-darkness.infoS1 
{
    border-color: #9BCBFF;
}

.FormTopOuter .warningM6, .FormTopOuter .warningM4, .FormTopOuter .warningM3, .FormTopOuter .warningM2, .FormTopOuter .warningS1,
.DialogOuterBar .warningM6, .DialogOuterBar .warningM4, .DialogOuterBar .warningM3, .DialogOuterBar .warningM2, .DialogOuterBar .warningS1 {
    /*
    border-color:rgb(255,181,54);
    border-color:rgba(255,153,0,0.7);
    */
    border-color: rgb(255,223,0);
}

.DialogOuterBar .rk-darkness .warningM6, 
.DialogOuterBar .rk-darkness .warningM4, 
.DialogOuterBar .rk-darkness .warningM3, 
.DialogOuterBar .rk-darkness .warningM2, 
.DialogOuterBar .rk-darkness .warningS1,
.DialogOuterBar .rk-darkness.warningM6, 
.DialogOuterBar .rk-darkness.warningM4, 
.DialogOuterBar .rk-darkness.warningM3, 
.DialogOuterBar .rk-darkness.warningM2, 
.DialogOuterBar .rk-darkness.warningS1 
{
    border-color: #F3CA80;
    border-width: 3px;
}

.FormTopOuter .errorM6, .FormTopOuter .errorM4, .FormTopOuter .errorM3, .FormTopOuter .errorM2, .FormTopOuter .errorS1,
.DialogOuterBar .errorM6, .DialogOuterBar .errorM4, .DialogOuterBar .errorM3, .DialogOuterBar .errorM2, .DialogOuterBar .errorS1 {
    /*
    border-color:rgb(230,126,119);
    border-color:rgba(204,0,0,0.5);
    */
    border-color: rgb(254,204,203);
}

.DialogOuterBar .rk-darkness .errorM6, 
.DialogOuterBar .rk-darkness .errorM4, 
.DialogOuterBar .rk-darkness .errorM3, 
.DialogOuterBar .rk-darkness .errorM2, 
.DialogOuterBar .rk-darkness .errorS1,
.DialogOuterBar .rk-darkness.errorM6, 
.DialogOuterBar .rk-darkness.errorM4, 
.DialogOuterBar .rk-darkness.errorM3, 
.DialogOuterBar .rk-darkness.errorM2, 
.DialogOuterBar .rk-darkness.errorS1 
{
    border-color: #FFB0AE;
}

div.FormInnerScroll {
    height:100px;
    overflow-y:auto;
    /*overflow-x:auto;*/
    overflow-x:hidden;
    background-color:#f7f7f2;
    border-radius:4px;
    -moz-border-radius:4px;
    /*
    border:solid rgb(94,182,253) 1px;
    border:solid rgba(51,153,255,0.7) 1px;
    */
    /*
    border:solid rgb(173,173,173) 2px;
    border:solid rgba(153,153,153,0.8) 2px;
    */
    border:solid #cacaca 2px;
    padding:0 3px 3px 3px;
    /* Setting position to relative is EXTREMELY important - this is needed so that the DatePicker fix in visualforce_utils_js can find this
     * div in the offsetParent chain (from the target text input) for proper scroll compensation. Statically positioned elements are not 
     * included in the offsetParent chain. */
    position:relative;
}

/*
div.FormInnerScroll.error {
    border:solid #C00 1px;
}

body.witness div.FormInnerScroll,
body.summary div.FormInnerScroll {
    border:solid #AAA 1px;
}
*/

div.FormInnerScroll.error,
body.witness div.FormInnerScroll.error {
    /*
    border:solid rgb(230,126,119) 1px;
    border:solid rgba(204,0,0,0.5) 1px;
     */
    border:solid rgb(230,126,119) 2px;
    border:solid rgba(204,0,0,0.75) 2px;
}

body.witness div.FormInnerScroll,
body.summary div.FormInnerScroll {
    border:solid #CFCFCF 1px;
}

.fieldsSection {
    
}

.fieldsSection table.fieldsSectionTable {
    width:100%;
    table-layout:fixed;
}

.fieldsSection table.fieldsSectionTable td {
    overflow:hidden;
}

.fieldsSection tr.sectionRow.odd {
    background-color:white;
    background-color:rgba(255,255,255,0.85);
}

.fieldsSection tr.sectionRow.even {
}

.fieldsSection tr.sectionRow td {
    border-top:solid 1px #dfdfdf;
}

.fieldsSection tr.sectionRow.first td {
    border-top:none;
}

.fieldsSection tr.sectionRow td.labelCell {
    text-align:right;
    font-weight:bold;
    font-size:90%;
    width:45%;
}

.fieldsSection table.twoCol tr.sectionRow td.labelCell {
    width:30%;
}

.fieldsSection table.threeCol tr.sectionRow td.labelCell {
    width:20%;
}

.fieldsSection tr.sectionRow td.dataCell {
    padding:1px 0 1px 8px;
}

.FormTopOuter .FormTopInner .fieldLabel {
    font-weight:bold;
    font-size:90%;
}

/* ==============================================================================================================================================
 * ==============================================================================================================================================
 */

div.FormInnerScroll .FormSection {
    padding-top:3px;
}

.FormTopOuter .FormTopInner div.FormInnerScroll .FormSection .header {
    font-size: 100%; 
    padding-left: 12px;
    padding-right: 12px;
    margin:0;
    /*background:#d3d8df;*/
    /*background:#c8d2d6;*/

    /*background:#b4c7dc;*/

    /*
    background:#c8d4e2;
    background:rgba(200, 212, 226, 0.8);
    */
    /*background:#0072BC url(http://jqueryui.com/themeroller/images/?new=0072bc&w=1&h=100&f=png&q=100&fltr[]=over|textures/04_highlight_hard.png|0|0|60) 50% 50% repeat-x;*/
    background:#003467;
    color:white;
    border:solid #0054CE 1px;
    /*border:1px solid #858991;*/
    /*border-top:none;*/
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
    border-bottom-left-radius: 3px;
    border-bottom-right-radius: 3px;
    -moz-border-radius-topleft: 3px;
    -moz-border-radius-topright: 3px;
    -moz-border-radius-bottomleft: 3px;
    -moz-border-radius-bottomright: 3px;
}

.FormTopOuter .FormTopInner div.FormInnerScroll .FormSection.attachments .header {
    background:#0075be;
    color:white;
}

.FormTopOuter .FormTopInner div.FormInnerScroll .stateSpecific .FormSection .header {
    background:#222222;
    color:white;
}

div.FormInnerScroll .FormSection .body {
    padding-top:3px;
}

.FormSection table.fieldTable {
    width:100%;
    table-layout:fixed;
}

.FormSection table.fieldTable td {
    overflow:hidden;
}

div.FormInnerScroll .FormSection table.fieldTable tr.even {
    background-color:white;
    background-color:rgba(255,255,255,0.85);
}

div.FormInnerScroll .FormSection table.fieldTable tr.odd {
    background-color:transparent;
}

span.flipRowStyles {
    display:none;
}

span.rowStyles {
    display:none;
}

div.FormInnerScroll .FormSection .flipRowStyles table.fieldTable tr.odd,
div.FormInnerScroll .FormSection table.fieldTable.flipRowStyles tr.odd,
div.FormInnerScroll .FormSection span.flipRowStyles + table.fieldTable tr.odd,
div.FormInnerScroll .FormSection span.flipRowStyles + div table.fieldTable tr.odd{
    background-color:white;
    background-color:rgba(255,255,255,0.85);
}

div.FormInnerScroll .FormSection .flipRowStyles table.fieldTable tr.even,
div.FormInnerScroll .FormSection table.fieldTable.flipRowStyles tr.even,
div.FormInnerScroll .FormSection span.flipRowStyles + table.fieldTable tr.even,
div.FormInnerScroll .FormSection span.flipRowStyles + div table.fieldTable tr.even {
    background-color:transparent;
}

/* double-flipped: */
div.FormInnerScroll .FormSection .flipRowStyles .flipRowStyles table.fieldTable tr.odd,
div.FormInnerScroll .FormSection .flipRowStyles table.fieldTable.flipRowStyles tr.odd {
    background-color:transparent;
}

/* double-flipped: */
div.FormInnerScroll .FormSection .flipRowStyles .flipRowStyles table.fieldTable tr.even,
div.FormInnerScroll .FormSection .flipRowStyles table.fieldTable.flipRowStyles tr.even {
    background-color:white;
    background-color:rgba(255,255,255,0.85);
}

div.FormInnerScroll .FormSection table.fieldTable td {
    border-top:solid 1px #dfdfdf;
}

div.FormInnerScroll .FormSection table.fieldTable tr.first td {
    border-top:none;
}

div.FormInnerScroll .FormSection table.fieldTable tr.noBorders td {
    border:none;
}

div.FormInnerScroll .FormSection table.fieldTable.noBorders td {
    border:none;
}

div.FormInnerScroll .FormSection table.fieldTable td table td {
    border:none;
}

.FormSection table.fieldTable td.labelCell {
    text-align:right;
    font-weight:bold;
    font-size:90%;
    width:45%;
    padding:1px 2px 1px 5px;
}

.FormSection table.fieldTable td.labelCell.oneCol {
    width:30%;
}

.FormSection table.fieldTable td.dataCell.oneCol {
    width:70%;
}

.FormSection table.fieldTable td.labelCell.twoCol {
    width:30%;
}

.FormSection table.fieldTable td.dataCell.twoCol {
    width:20%;
}

.FormSection table.fieldTable td.dataCell.twoCol.spanRow {
    width:70%;
}

.FormSection table.fieldTable td.labelCell.threeCol {
    width:25%;
}

body.summary .FormSection table.fieldTable td.labelCell.twoCol {
    width:25%;
}

body.summary .FormSection table.fieldTable td.dataCell.twoCol {
    width:25%;
}

body.summary .FormSection table.fieldTable td.dataCell.twoCol.spanRow {
    width:75%;
}

.DialogOuterBar .FormSection table.fieldTable td.labelCell,
.DialogOuterBar .FormSection table.fieldTable td.labelCell.twoCol 
.DialogOuterBar .FormSection table.fieldTable td.labelCell.threeCol {
    width:auto;
}

.FormSection table.fieldTable td.dataCell {
    padding:1px 0 1px 8px;
}

.FormSection table.fieldTable td.dataCell.oneCol select {
    max-width:450px;
}

.FormSection table.fieldTable td.dataCell.twoCol select {
    max-width:200px;
}

.FormSection table.fieldTable td.dataCell.threeCol select {
    max-width:175px;
}

.FormSection table.fieldTable td.dataCell.oneCol.longText select,
.FormSection table.fieldTable td.dataCell.twoCol.longText select,
.FormSection table.fieldTable td.dataCell.threeCol.longText select,
.FormSection table.fieldTable td.dataCell.oneCol.mediumText select,
.FormSection table.fieldTable td.dataCell.twoCol.mediumText select {
    max-width:none;
}

.FormSection table.fieldTable.forDialog td.labelCell {
    width:20%;
}

.DialogOuterBaz .FormSection .oneCol table.fieldTable td.labelCell,
.DialogOuterBaz .FormSection table.fieldTable.oneCol td.labelCell{
    width:30%;
    padding-right:25px;
}

.FormSection table.fieldTable.forDialog td.dataCell input[type=text],
.FormSection table.fieldTable.forDialog td.dataCell textarea {
    /* width:100%; */
    box-sizing:border-box;
    -moz-box-sizing:border-box;
}

.FormSection table.fieldTable.forDialog td.dataCell textarea {
    height:3em;
}

/* ==============================================================================================================================================
 * ==============================================================================================================================================
 */

a.toggleHeader {
    white-space:nowrap;
    margin-right:4px;
}

a.toggleHeader span,
a.toggleHeader img {
    vertical-align:middle;
    cursor:pointer;
}

.actionFunctionNormalLink{
    text-decoration:underline;
    cursor:pointer;
}

body.bhi.home .listViewport .bottomNav {
    border:1px solid #D4DADC;
    border-top:none;
}

/* ==============================================================================================================================================
 * ==============================================================================================================================================
 */

ol.strongNumbering {
    font-weight:bold;
}

ol.strongNumbering > li span {
    font-weight:normal;
}

.FormSection table.fieldTable td.dataCell.advancedLookupMode,
.FormSection table.fieldTable td.dataCell.oneCol.advancedLookupMode,
.FormSection table.fieldTable td.dataCell.twoCol.advancedLookupMode,
.FormSection table.fieldTable td.dataCell.threeCol.advancedLookupMode {
    padding:4px 0 0 5px;
    width:100%;
}

.FormSection table.fieldTable td.labelCell .driverField {
    color:#015BA7;
}

.FormSection table.fieldTable td.dataCell.longDescrip,
.FormSection table.fieldTable td.dataCell.bigDescription {
    padding:3px 0 3px 10px;
}

td.longDescrip textarea,
td.bigDescription textarea,
td textarea.bigDescription {
    width:100%;
    box-sizing:border-box;
    -moz-box-sizing:border-box;
    height:4em;
    /*margin-left:2px;*/
    margin:0px;
}

td.longText .requiredInput div.requiredBlock,
td.longDescrip .requiredInput div.requiredBlock,
td.bigDescription .requiredInput div.requiredBlock {
    left:-5px;
    margin-top:-2px;
    margin-bottom:-2px;
}

.FormSection table.fieldTable td.dataCell.longText,
.FormSection table.fieldTable td.dataCell.bigName {
    padding:2px 0 2px 10px;
}

td.longText input,
td.bigName input,
td input.bigName {
    width:100%;
    box-sizing:border-box;
    -moz-box-sizing:border-box;
    /*margin-left:2px;*/
    margin:0px;
}

td.mediumText input {
    width:30em;
}

td.shortText input {
    width:8em;
}

.FormSection .advancedLookupMode table.fieldTable td.dataCell select,
.FormSection .advancedLookupMode table.fieldTable td.dataCell.oneCol select,
.FormSection .advancedLookupMode table.fieldTable td.dataCell.twoCol select,
.FormSection .advancedLookupMode table.fieldTable td.dataCell.threeCol select {
    max-width:none;
}

.FormSection table.fieldTable td input,
.FormSection table.fieldTable td select {
    margin:2px;
}

.FormSection table.fieldTable td.longText input,
.FormSection table.fieldTable td.bigName input,
.FormSection table.fieldTable td input.bigName {
    margin:0px;
}

body .FormSection table.fieldTable tr.longLabelRow td {
    width:100%;
    padding:3px 3px 3px 5px;
    text-align:left;
}

.FormSection table.fieldTable td.readOnly {
    padding-top:5px;
    padding-bottom:5px;
}

.FormSection div.subsectionDivider {
    margin:3px 25px 3px 25px;
    height:2px;
    box-sizing:content-box;
    /*
    background-color:#cecece;
    border-radius:2px;
    */
    height:0;
    border-style:dotted;
    border-width:1px;
    border-bottom:none;
    color: #222;
}

/* =========================================================================================================================================================== */

.rk-standalone .FormTopOuter 
{
    padding:13px 12px 12px 12px;
}

.rk-nested .FormTopOuter 
{
    padding:0;
}

.FormTopOuter .bWizardBlock.FormTopInner 
{
    background-color:transparent !important;
    border:none !important;
    margin-right:0px;
}

/* =========================================================================================================================================================== */

body.rk-nested .dojoRootSmartLayoutContainer > .dojoSmartAlignScrollXY
{
    padding: 0 10px;
}

body.rk-nested.hasMotif 
{
    /* Override SFDC's 10 pixel left/right margin on body; we'll apply this amount of margin directly to the RootSmartLayoutContainer: */
    margin:0 0;
}

body.rk-nested .dojoRootSmartLayoutContainer.dojoSmartAlignClient 
{
    position:relative;
}

/*
body.rk-nested.sfdc-sidebar.sfdc-header .sidebarCollapsed #handlebarContainer 
{
    left:0px !important;
}
*/

body.rk-nested.sfdc-sidebar.sfdc-header .sidebarCollapsed + #bodyCell 
{
    padding-left:0px;
}

body.rk-nested.sfdc-sidebar.sfdc-header #bodyCell 
{
    padding-top:9px;
}

/* IMPORTANT: it's up to UIManager to set body children to visible during its initialization sequence: */
body > *
{
    visibility: hidden;
}

body.rk-ui-initialized > *
{
    visibility: visible;
}

body > .ui-widget.ui-datepicker
{
    visibility: visible;
    font-size: 0.95em;
}

/* this style ensures that the client-area shell (e.g. apex:pageBlock border/decorators) will assume adequate width to contain its inner contents,
 * even when those inner contents are much wider than the screen size:  */
/*
body.rk-standalone form[method=post]
{
    float:left;
    min-width:100%;
}
*/

.sfdc-portal table.list tr.odd {
    background-color: #f2f5f8;
}

.sfdc-portal table.list tr.even {
    background-color: #fff;
}

.sfdc-portal table.list tr.highlight th,
.sfdc-portal table.list tr.highlight td {
    background-color: #d2f1ff;
}

.sfdc-portal .bWizardBlock .pbWizardHeader {
    margin: 0;
}

/* jController styles: */

input.jController-error, select.jController-error, textarea.jController-error {
    border: solid #c00 1px;
    border-radius: 2px;
}

input.jController-error, textarea.jController-error {
    background-color: rgb(255, 236, 236);
}

.tooltip.jController-error {
    border: solid #ffa200 1px;
    background: rgb(255,255,205);
    padding: 0.5em 1em;
    border-radius: 3px;
}

body .tooltip.jController-error.errorMsg {
    color: black;
    font-style: italic;
}

body .tooltip.jController-error.errorMsg .title {
    color: #c00;
    font-style: normal;
}
