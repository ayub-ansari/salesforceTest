
/* Version 1.01 -- added z-idnex:3 to the rpp popup, to ensure that it is over any locked colset from a gridLayout control */

body .paginator .right {
	top:-2px;
}

body .listViewport .bottomNav {
	background: #F2F2F2 url(/img/alohaSkin/listFooter.png) repeat-x scroll 0 0;
}

body .selectionPaginator .listViewport .bottomNav {
    border:solid #D4DADC 1px;
    border-top:none;
}

body .listViewport .bottomNav .paginator span img {
    vertical-align:baseline;
}

.selector.rpp {
    z-index: 3;
}