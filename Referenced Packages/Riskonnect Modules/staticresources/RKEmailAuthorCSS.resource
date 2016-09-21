div#overlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: #000;
	-moz-opacity: 0.8;
	-khtml-opacity: 0.8;
	opacity: 0.8;
	z-index: 100;
}

div#attachment_overlay {
	display: none;
	position: absolute;
	z-index: 300;
	background-color: #fff;
	margin: -20px 0px 0px -20px;
	-moz-opacity: 0.9;
	-khtml-opacity: 0.9;
	opacity: 0.9;
	padding: 0;
}

div.attachment_dialog {
	display: none;
	position: absolute;
	z-index: 400;
	margin: 0;
	padding: 0;
	border: 1px solid #000;
	padding: 15px 15px;
	background: #fff;
	box-shadow: 3px 3px 10px 1px #777;
	border-radius: 4px;
	text-align: center;
}

div.attachment_dialog p strong {
	color: #b80000;
}

div#attachment_overlay_loader p {
	font-variant: small-caps;
	font-size: 16px;
	margin: 0px 0px 8px 0px;
	padding: 0;
}

.apexp .bPageBlock.apexDefaultPageBlock .pbBody .pbSubheader {
	color: #000 !important;
}

iframe#rk_file_uploader {
	border: none;
}

iframe.wysihtml5-sandbox {
	border: 1px solid gray !important;
}

table.recipientsTable td {
	vertical-align: middle !important;
}

table.recipientsTable p {
	margin: 0px 0px 0px 3px;
	font-weight: bold;
}

.dialogWrapper {
	display: none;
	position: fixed;
	border: 5px solid #AFCDF0;
	margin: 0;
	padding: 20px 20px;
	z-index: 200;
	background: #fff;
	box-shadow: 4px 4px 22px 2px #000;
	border-radius: 4px;
}

.errorDialog, .warningDialog {
	text-align: center;
	width: 300px;
}

.errorDialog p, .warningDialog p {
	text-align: left;
}

.errorDialog p strong {
	color: #b80000;
}

.warningDialog input[type="submit"] {
	margin: 0px 10px;
}

div#accordion ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

div#accordion ul li {
	display: block;
	margin: 0;
	padding: 6px 10px;
	border-bottom: 1px solid #aaa;
}

div#accordion ul li:hover {
	cursor: pointer;
	background: #eaeaea;
	color: #000;
}

.ui-accordion .ui-accordion-content {
	margin: 0;
	padding: 0;
}

div#ajaxDialog {
	text-align: center;
	padding: 10px 10px;
	width: 100px;
}

p#ajaxDialogMsg {
	margin: 0px 0px 10px 0px;
	font-variant: small-caps;
	font-size: 14px;
}

span#pageNum {
	padding: 0px 6px 0px 10px;
	font-size: 15px;
}

div#page_controls {
	float:right;
	margin-bottom: 2px;
}

div#page_controls img {
	margin-left: 4px;
}

div#page_controls img.inactive {
	opacity: 0.3;
	-moz-opacity: 0.3;
	-khtml-opacity: 0.3;
}

div#page_controls img.inactive:hover {
	cursor: default;
}

div#page_controls img:hover {
	cursor: pointer;
}

.selectedAttachments {
	margin-top: 20px;
}

#select_attachments {
	min-height: 222px;
}

#select_attachments th {
	background-color: #D8EAFF;
}

.attachmentTable {
	width: 100%;
	padding: 0;
	margin: 0;
	border: 1px solid #999 !important;
	border-collapse: collapse;
	cursor: default;
	clear: both;
}

.attachmentTable .tdDate {
	text-align: center;
}

.attachmentTable .tdSize {
	text-align: center;
	width: 50px;
}

.attachmentTable td, .attachmentTable th {
	padding: 6px;
	border: 1px solid #999 !important;
	vertical-align: middle !important;
}

.attachmentTable thead tr {
	background-color: #D8EAFF;
}

.attachmentTable tbody tr:hover {
	background-color: #EBF4FF;
}

div.localAttachStyle p {
	margin: 0;
	font-weight: bold;
}

div#attachmentsWrapper {
	width: 700px;
	min-height: 333px;
}

div#attachmentsWrapper h3 {
	float: left;
	top: 2px;
	position: relative;
	display: block;
	padding: 0;
	margin: 0px 0px 5px 0px;
}

div#attachmentsWrapper input[type=submit] {
	margin: 7px 7px 0px 0px;
}

div.attachmentSizeManagerWrapper {
	margin: 0px auto;
	width: 400px;
}

div.attachmentSizeManagerWrapper p {
	display: inline-block;
	margin-right: 10px;
}

div.attachmentSizeManager {
	display: inline-block;
	border: 1px solid #000;
	height: 25px;
	width: 300px;
	border-radius: 4px;
}

div#attachmentSize {
	height: 100%;
	width: 0%;
	background-color: green;
}

div.attachmentSizeManagerWrapper table.attachmentSizeManagerTable {
	padding: 0;
	margin: 0;
	border: none;
	cursor: default;
	font-size: 11px;
}

div.attachmentSizeManagerWrapper table.attachmentSizeManagerTable td.leftCell {
	width: 50px;
	text-align: right;
	padding: 8px 6px 0px 0px;
	color: #888;
}

div.attachmentSizeManagerWrapper table.attachmentSizeManagerTable td.rightCell {
	width: 50px;
	text-align: left;
	padding: 8px 0px 0px 6px;
	color: #888;
}