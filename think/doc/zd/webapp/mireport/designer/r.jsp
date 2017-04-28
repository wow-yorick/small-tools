<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page
	import="com.jatools.mireport.*,org.apache.commons.lang.*,java.io.File,java.util.regex.*"%>
<!DOCTYPE html>
<!--用下面的话，会使ie8，不支持:before,参照 http://www.w3schools.com/cssref/sel_before.asp>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"-->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=10;" />
<title>RuntimeReport 报表设计</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="js/jquery/jquery-ui-1.9.2.min.css">
<link rel="stylesheet" type="text/css"
	href="js/spectrum/spectrum.min.css">
<link rel="stylesheet" type="text/css" href="js/sh/sh.min.css" />
<script type="text/javascript" src="js/jquery/jquery-1.9.min.js"></script>
<script type="text/javascript" src="js/jquery/jquery-1.9.migrate.js"></script>
<script type="text/javascript" src="js/jquery/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/spectrum/spectrum.min.js"></script>
<script type="text/javascript" src="js/sh/sh.min.js"></script>
<%
	String report = request.getParameter("report");
	if (StringUtils.isBlank(report)) {
		report = "";
	}
	String ds = request.getParameter("ds");
	if (StringUtils.isBlank(ds)) {
		ds = Config.getInstance().getReportManager().load(report)
				.getString("datasource");
	}
	String debug = request.getParameter("debug");
	if (StringUtils.isBlank(debug)) {
		debug = "";
	}

	String ui = Config.getInstance().getDatasourceManager().load(ds)
			.get("ui").toString();
	int uploadMaxSize = Config.getInstance().getUploadMaxSize();
	String uploadMaxSizeError = Config.getInstance()
			.getUploadMaxSizeError();
%>
<script>
	var Request = {
		"debug":'<%=debug%>',
		report:'<%=report%>',
		datasource: '<%=ds%>',
		ui:<%=ui%>,
		uploadMaxSize : <%=uploadMaxSize%>,
		uploadMaxSizeError : '<%=uploadMaxSizeError%>'
	}
	//  已经有文件名的情况下，是否报表名称事先给，不弹出文件名对话框
	Request.showSaveDialog = !Request.report;
	var RuntimeReport = {
			ui : Request.ui,
			buildPageService : "../service/buildPage.jsp",
			uploadImageService : "../service/uploadImage.jsp",
			persistReportService : "../service/persistReport.jsp"
	}	
	var geditorSettings = {
			persistReportService : RuntimeReport.persistReportService,
			buildPageService : RuntimeReport.buildPageService,
			type : 'user.design.edit',
			uiMode:'runtimeReport',
			settingsID : Request.report,
			fields : RuntimeReport.ui.fields
		};		
var nobuttons = '<%=request.getParameter("nobuttons")%>';
</script>
<script type="text/javascript" src='js/jatoolsPrinter-min.js'></script>
<script type="text/javascript" src='js/core-min.js'></script>
<style>
.wrapper {
	position: relative;
}

.fakeuploadbutton {
	background: red url('myuploadbutton.png') no-repeat top left;
	width: 100px;
	height: 30px;
}

#file {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100px;
	height: 30px;
}

tbody1.jp-body-rows tr:first-child  td:first-child, tbody.jp-body-rows tr:first-child,
	tbody.jp-body-rows, table {
	overflow: visible;
}

tbody1.jp-body-rows tr:first-child  td:first-child span {
	position: relative;
	display: inline-block;
	height: 100%;
	background: url('./images/downoff.png') repeat-y;
	overflow: visible;
}

.jp-label {height:1em;width:10em;}

tbody1.jp-body-rows tr:first-child  td:first-child span:before {
	content: "";
	display: block;
	position: absolute;
	z-index: 100;
	top: 0;
	left: -20px;
	width: 20px;
	height: 100%;
	border-style: solid;
	border-width: 4px;
	border-color: #DDD;
}

html, body {
	width: 100%;
	height: 100%;
}

body {
	overflow: hidden;
	margin: 0;
	padding: 0;
}

.jp-main-tools .jp-button-set {
	display: none
}

body .ui-buttonset .ui-button {
	margin-right: -1px;
}

.jp-toolbar {
	height: 29px;
	background: url(js/jquery/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png)
		0 50% repeat-x;
	padding: 5px;
	width: 2500px;
}

.jp-content {
	background: white;
	overflow: auto;
	border: inset 1px white;
	top: 38px;
}

a.ui-button {
	margin-right: 2px;
	float: left;
}

a.ui-spinner-button {
	margin-right: 0 !important;
}

.jp-toolbar span, .jp-toolbar-transparent span {
	background-position: 50% 50%;
	background-repeat: no-repeat;
}

span.ui-icon-triangle-1-s {
	background-position: -64px -16px !important;
}

.jp-bold span {
	background-image: url(images/edit-bold.png);
}

.jp-italic span {
	background-image: url(images/edit-italic.png);
}

.jp-underline span {
	background-image: url(images/edit-underline.png);
}

.jp-align-left span {
	background-image: url(images/edit-align-left.png);
}

.jp-align-center span {
	background-image: url(images/edit-align-center.png);
}

.jp-align-right span {
	background-image: url(images/edit-align-right.png);
}

.jp-align-justify span {
	background-image: url(images/edit-alignment-justify-distribute.png);
}

.jp-undo span {
	background-image: url(images/undo.png);
}

.jp-redo span {
	background-image: url(images/redo.png);
}

.jp-copy span {
	background-image: url(images/copy.gif);
}

.jp-cut span {
	background-image: url(images/cut.gif);
}

.jp-paste span {
	background-image: url(images/paste.gif);
}

.jp-delete span {
	background-image: url(images/cross.png);
}

.jp-border-style span.jp-primary-icon {
	background-image: url(images/border-style.png);
}

.jp-border-width span.jp-primary-icon {
	background-image: url(images/border-weight.png);
}

.jp-size-up span {
	background-image: url(images/edit-size-up.png);
}

.jp-size-down span {
	background-image: url(images/edit-size-down.png);
}

.jp-color span {
	background-image: url(images/edit-color.png);
}

.jp-background span {
	background-image: url(images/edit-background.png);
}

.jp-border-color span {
	background-image: url(images/border-color.png);
}

.jp-border-none span {
	background-image: url(images/border-none.png);
}

.jp-border-all span {
	background-image: url(images/border-all.png);
}

.jp-border-left span {
	background-image: url(images/border-left.png);
}

.jp-border-top span {
	background-image: url(images/border-top.png);
}

.jp-border-right span {
	background-image: url(images/border-right.png);
}

.jp-border-bottom span {
	background-image: url(images/border-bottom.png);
}

.ui-buttonset span.ui-button-text {
	height: 16px;
	width: 6px;
	display: inline-block;
}

a.jp-checked {
	background: url(images/tick.png) 90% 50% no-repeat;
}

.jp-button-set .jp-new-label span {
	background-image: url(images/label.png);
}

.jp-button-set .jp-new-text span {
	background-image: url(images/text.png);
}

.jp-button-set .jp-new-image span {
	background-image: url(images/image.png);
}

.jp-button-set .jp-new-table span {
	background-image: url(images/table.png);
}

.jp-button-set .jp-new-line-vert span {
	background-image: url(images/line-vert.png);
}

.jp-button-set .jp-new-line-horz span {
	background-image: url(images/line-horz.png);
}

.jp-button-set .jp-new-barcode span, .jp-button-set .jp-layers span,
	.jp-button-set .jp-border span, .jp-button-set .jp-border-style span,
	.jp-button-set .jp-border-width span {
	height: 16px;
}

.jp-button-set .jp-save span {
	background-image: url(images/disk.png);
}

.jp-button-set .jp-open span {
	background-image: url(images/folder-open-document-text.png);
}

.jp-button-set .jp-new span {
	background-image: url(images/blue-document--plus.png);
}

.jp-button-set .jp-v-offset span {
	background-image: url(images/paper-v-offset.png);
}

.jp-button-set .jp-h-offset span {
	background-image: url(images/paper-h-offset.png);
}

.jp-button-set .jp-print span {
	background-image: url(images/printer.png);
}

a.jp-new-barcode, a.jp-layers {
	width: 40px;
}

.jp-new-barcode span.jp-primary-icon {
	background-image: url(images/barcode.png);
}

.jp-layers span.jp-primary-icon {
	background-image: url(images/layers-stack.png);
}

.jp-align2 span.jp-primary-icon {
	background-image: url(images/layers-alignment-left.png);
}

div.jp-toolbar .ui-state-default {
	border-color: #79b7e7;
}

.ui-buttonset label.jp-italic {
	margin-right: 0;
	border-right-width: 0;
}

.jp-page p {
	cursor: default;
	font-size: 14px;
	height: 18px;
	margin: 0;
	padding: 0;
}

.jp-text {
	white-space: nowrap;
	overflow: hidden;
	position: absolute;
	border: solid 1px gray;
	width: 150px;
	padding: 2px;
}

.jp-page p.jp-connector {
	position: absolute;
	line-height: 0;
	width: 7px;
	height: 7px;
	border2: solid 1px #000;
	background-image: url(images/connector.png);
	z-index: 20000;
}

.jp-page p.jp-h-ruler {
	position: absolute;
	line-height: 0;
	height: 1px;
	border-top: solid 1px #b2db81;
	display: none;
	z-index: 20000;
}

.jp-page p.jp-v-ruler {
	position: absolute;
	line-height: 0;
	width: 1px;
	border-left: solid 1px #b2db81;
	display: none;
	z-index: 20000;
}

#feedback {
	font-size: 1.4em;
}

.jp-page {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}

div.ui-resizable-se {
	right: -4px;
	bottom: -4px;
}

.sp-button-container {
	padding: 3px;
}

.sp-container {
	box-shadow: 0 0 13px rgba(0, 0, 0, 0.31);
}

.dropdown ul.dropdown-menu {
	background-color: #ECECEC;
}

span2 {
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	position: relative;
	width: auto;
	margin: auto;
}

.jp-inplace-editor {
	width: 100%;
	border: none;
	margin: 0;
	padding: 0;
}

a.jp-creating, body.jp-creating, body.jp-creating .jp-component, body.jp-creating .jp-paper-background
	{
	cursor: crosshair;
}

.jp-component {
	position: absolute;
	border: solid 1px #ddd;
	padding: 2px;
	overflow: hidden;
}

.jp-for-layout         .jp-component {
	border: none;
}

div.sp-replacer {
	width: 36px;
	padding: 3px;
}

div.sp-preview {
	width: 13px;
	height: 13px;
	float: left;
}

.sp-replacer .ui-icon-triangle-1-s {
	float: right;
}

.sp-replacer:hover .ui-icon-triangle-1-s {
	background-image:
		url(css/ui-lightness/images/ui-icons_217bc0_256x240.png);
}

#jp-pdf417-editor select, #jp-qr-editor select {
	width: 100px;
}

#jp-bar-1d-editor p {
	margin: 6px 0;
}

.jp-expression {
	color: white;
	background: blue;
}

.jp-field-label {
	width: 100px;
	display: inline-block;
	text-align: right;
	padding-right: 10px;
}

.label-short .jp-field-label {
	width: 100px;
}

.jp-barcode object, .jp-barcode embed, td>div, td object {
	width: 100%;
	height: 100%;
	z-index: -1;
}

.resizing2 td div object {
	height: 1px;
}

.jp-auto-stretch {
	width: 100%;
	height: 100%;
}

div.ui-selecting p.jp-selected-layer, div.ui-selected p.jp-selected-layer
	{
	background-color: #0000aa;
	filter: alpha(opacity = 3);
	opacity: 0.03;
}

div.ui-selected-first p.jp-selected-layer, div.ui-selected-first p.jp-selected-layer
	{
	background-color: #0000aa;
	filter: alpha(opacity = 10) !important;
	opacity: 0.1 !important;
}

.jp-selected-layer {
	background-color: white;
	filter: alpha(opacity = 1);
	opacity: 0.01;
}

.jp-component .jp-selected-layer {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	cursor: default;
}

.jp-text-content {
	display: block;
	cursor: default;
	text-justify2: distribute-all-lines; /*ie6-8*/
	text-align-last2: justify; /* ie9*/
	-moz-text-align-last2: justify; /*ff*/
	-webkit-text-align-last2: justify; /*chrome 20+*/
}

div.ui-dialog {
	box-shadow: 0 0 13px rgba(0, 0, 0, 0.15);
	padding: 1px;
}

div.ui-dialog-titlebar {
	border-bottom-left-radius: 0;
	border-bottom-right-radius: 0;
}

div.drop-with-icon .dropdown-menu li>a {
	padding-left: 30px;
	background-repeat: no-repeat;
	background-position: 5px 50%;
}

#jp-front {
	background-image: url(images/layers-arrange.png);
}

#jp-back {
	background-image: url(images/layers-arrange-back.png);
}

#jp-top {
	background-image: url(images/layers-stack-arrange.png);
}

#jp-bottom {
	background-image: url(images/layers-stack-arrange-back.png);
}

#jp-align2-left {
	background-image: url(images/layers-alignment-left.png);
}

#jp-align2-center {
	background-image: url(images/layers-alignment-center.png);
}

#jp-align2-right {
	background-image: url(images/layers-alignment-right.png);
}

#jp-align2-top {
	background-image: url(images/layers-alignment.png);
}

#jp-align2-middle {
	background-image: url(images/layers-alignment-middle.png);
}

#jp-align2-bottom {
	background-image: url(images/layers-alignment-bottom.png);
}

#jp-equal-width {
	background-image: url(images/layer-resize-replicate.png);
}

#jp-equal-height {
	background-image: url(images/layer-resize-replicate-vertical.png);
}

#jp-border-1px {
	background-image: url(images/border-all.png);
}

#jp-border-no {
	background-image: url(images/border-none.png);
}

#jp-copy-code span {
	background-image: url(images/copy.gif);
}

#jp-save-code span {
	background-image: url(images/disk.png);
}

#jp-grid-settings, .ui-dialog *, .jp-toolbar * {
	font-size: 12px;
}

#jp-grid-settings {
	padding: 20px;
}

.jp-new-barcode span.ui-button-icon-secondary, .jp-layers span.ui-button-icon-secondary,
	.jp-border span.ui-button-icon-secondary, .jp-border-style span.ui-button-icon-secondary,
	.jp-border-width span.ui-button-icon-secondary {
	right: 3px;
}

.jp-border span.jp-primary-icon, #jp-border-custom {
	background-image: url(images/border-draw.png);
}

.jp-button-set label, .jp-button-set {
	float: left;
}

.jp-inplace-editing .jp-text-content, .jp-dialog {
	display: none;
}

.jp-hidden {
	display: none
}

#jp-code div.syntaxhighlighter {
	height: 100%;
	margin: 0 !important
}

.jp-border-previewer div {
	position: absolute;
	width: 10px;
	height: 10px;
}

.jp-border-previewer div.jp-border-line {
	cursor: pointer;
	background2: blue;
}

.jp-style-setting a:hover span {
	border-top-color: white
}

.jp-style-setting span {
	padding-left: 120px;
	font-size: 1px;
	vertical-align: 1px;
	border-top: solid 1px black;
}

.jp-no-src {
	display: none
}

.jp-paper-background {
	position: absolute;
	background: white;
}

.jp-stretch {
	width: 100%;
	height: 100%;
}

.jp-keep-width {
	width: 100%;
}

.jp-keep-height {
	height: 100%;
}

.jp-orientation {
	line-height: 50px;
	height: 50px;
}

.jp-orientation span, .jp-orientation input {
	vertical-align: middle;
}

.jp-orientation-icon {
	display: inline-block;
	width: 50px;
	height: 100%;
	background: url(images/portrait.png) 50% 50% no-repeat
}

.jp-landscape-icon .jp-orientation-icon {
	background-image: url(images/landscape.png)
}

a:focus {
	outline: none;
}

.jp-error-dialog .ui-widget-header {
	background-image: url(images/ui-bg_cc0000_1x100.png);
	border-color: #cc0000
}

.jp-html-loader {
	position: absolute;
	left: 0px;
	top: 0px;
	width: 1px;
	height: 1px;
	z-index: -100;
	overflow: hidden
}

.jp-text, .jp-label {
	font-size: 12px;
	white-space: nowrap
}

#jp-v-offset-dialog {
	background-image: url(images/downoff.png);
}

#jp-v-offset-dialog.jp-upper-off {
	background-image: url(images/upoff.png);
}

#jp-h-offset-dialog {
	background-image: url(images/leftoff.png);
}

#jp-h-offset-dialog.jp-right-off {
	background-image: url(images/rightoff.png);
}

.jp-remote, .jp-with-remote .jp-local {
	display: none
}

.jp-with-remote .jp-remote {
	display: inline;
}

#jp-comp-list {
	border-top: 1px solid rgb(204, 204, 204);
	margin: 0;
	padding: 0
}

#jp-comp-list li {
	line-height: 20px;
	list-style-type: none;
	border-bottom: 1px solid rgb(204, 204, 204);
	margin: 0px;
	padding: 0px;
	background: none repeat scroll 0% 0% rgb(238, 238, 238);
}

#jp-comp-list li.jp-active {
	background-color: transparent;
}

#jp-comp-list a {
	text-decoration: none;
	display: block;
	font-weight: bold;
	font-size: 13px;
	color: rgb(63, 63, 63);
	text-shadow: 1px 1px rgb(255, 255, 255);
	padding: 2px 4px;
}

table {
	border-collapse: collapse;
	border: solid 1px #ece9d8;
	background2: white;
	table-layout: fixed
}

.jp-table-move-handle {
	display: none;
	position: absolute;
	left: -16px;
	top: -16px;
	width: 20px;
	height: 20px;
	background: url(images/arrow-move.png) center center no-repeat
}

.jp-static .jp-table-detail-master, .jp-static .jp-table-detail-body {
	display: none;
}

.jp-table-detail-master, .jp-table-detail-body {
	position: absolute;
	left: -11px;
	width: 8px;
	border-left: solid 2px lightgray;
	border-top: solid 2px lightgray;
	border-bottom: solid 2px lightgray;
}

div.jp-table-detail-body {
	left: -19px;
	width: 16px;
}

.jp-component:hover .jp-table-move-handle {
	display: block;
}

.col-separator {
	position: absolute;
	cursor: e-resize;
	background2: blue;
	width: 4px;
	height: 100%;
	border2: solid 1px black;
	top: 0;
	z-index: 1
}

.row-separator {
	position: absolute;
	cursor: s-resize;
	background2: blue;
	width: 100%;
	height: 4px;
	border2: solid 1px black;
	left: 0;
	z-index: 1
}

.cell-selected .selection-frame {
	display: block;
}

.selection-frame {
	display: none;
}

.ui-selected p.jp-selected-layer {
	display: block
}

.jp-table .jp-selected-layer {
	display: none
}

.jp-line-vert .ui-resizable-se {
	cursor: s-resize;
}

.jp-line-horz .ui-resizable-se {
	cursor: e-resize;
}

.jp-line .ui-resizable-se {
	background: white;
	border: solid 1px black;
	opacity: 0.2;
	width: 7px;
	height: 7px;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
}

div.jp-line {
	border: none;
	overflow: visible;
}

.jp-line-vert div.ui-resizable-se {
	right: 0;
	margin-left: -5px;
	left: 50%;
}

.jp-line-horz div.ui-resizable-se {
	bottom: 0;
	margin-top: -5px;
	top: 50%
}

div.ui-selected.jp-line div.ui-resizable-se {
	background: blue;
	opacity: 0.5;
}

div.ui-selecting.jp-line div.ui-resizable-se {
	background: blue;
	opacity: 0.5;
}

.jp-layouting div.jp-for-layout-outer, .jp-layouting div#jp-grid-settings
	{
	display: block;
}

p.jp-visible {
	display: block;
}

.jp-layouting .jp-page, .jp-layouting p.jp-bottom-bar, .jp-bottom-bar,
	#jp-grid-settings, .jp-for-layout-outer, .jp-layouting .jp-main-tools {
	display: none;
}

.jp-for-layout div.jp-page {
	display: block;
}

.jp-layout-dlg .ui-dialog-titlebar-close {
	display: none;
}

.jp-layouting .jp-component-list-dlg {
	display: none;
}

.jp-layouting .jp-content {
	top: 0;
}

.jp-label:before {
	display: none;
	content: '';
	border-radius: 3px;
	position: absolute;
	width: 18px;
	height: 18px;
	bottom: 0;
	right: -22px;
	border: solid 1px gray;
	background-color: white;
	background-image: url(images/dropdown.png);
	background-position: center center;
	background-repeat: no-repeat;
}

.jp-line-command .sp-container {
	border: none;
	box-shadow: none;
}
/*
         .jp-label:hover:before{display:block;}
         div.jp-menu-dropping:before{display:block;}
         div.jp-label:before:hover{background-color:lightgray}
         div.jp-label{overflow:visible;}
         .jp-text-wrapper{display:none;position:absolute;top:0;bottom:0;right:0;left:0;overflow:hidden;}
         // .jp-component:hover .jp-text-wrapper{display:block;}
         */
.jp-hline-handler {
	opacity: 0.1;
	filter: alpha(opacity = 10);
	width: 100%;
	height: 7px;
	margin-top: -4px;
	background: white;
	top: 50%;
	left: 0;
	position: absolute
}

.jp-vline-handler {
	opacity: 0.1;
	filter: alpha(opacity = 10);
	height: 100%;
	width: 7px;
	margin-left: -4px;
	background: white;
	left: 50%;
	top: 0;
	position: absolute
}
/* 可拖放字段纵缩进 */
.jp-level-1 {
	margin-left: 20px;
}

.jp-level-2 {
	margin-left: 40px;
}

.jp-level-3 {
	margin-left: 60px;
}

.jp-border-transparent, .jp-border-black {
	border: solid 1px gray;
	white-space: nowrap;
}
</style>
<style>
.dropdown {
	position: absolute;
	z-index: 9999999;
	display: none;
}

.dropdown .dropdown-menu, .dropdown .dropdown-panel {
	min-width: 160px;
	max-width: 360px;
	list-style: none;
	background: #ECECEC;
	border: solid 1px #DDD;
	border: solid 1px rgba(0, 0, 0, .2);
	border-radius: 6px;
	box-shadow: 0 0 13px rgba(0, 0, 0, 0.31);
	overflow: visible;
	padding: 4px 0;
	margin: 0;
}

.dropdown .dropdown-panel {
	padding: 10px;
}

.dropdown.dropdown-tip {
	margin-top: 8px;
}

.dropdown.dropdown-tip:before {
	position: absolute;
	top: -6px;
	left: 9px;
	content2: '';
	border-left: 7px solid transparent;
	border-right: 7px solid transparent;
	border-bottom: 7px solid #CCC;
	border-bottom-color: rgba(0, 0, 0, 0.2);
	display: inline-block;
}

.dropdown.dropdown-tip.dropdown-anchor-right:before {
	left: auto;
	right: 9px;
}

.dropdown.dropdown-tip:after {
	position: absolute;
	top: -5px;
	left: 10px;
	content: '';
	border-left: 6px solid transparent;
	border-right: 6px solid transparent;
	border-bottom: 6px solid #ECECEC;
	display: inline-block;
}

.dropdown.dropdown-tip.dropdown-anchor-right:after {
	left: auto;
	right: 10px;
}

.dropdown.dropdown-scroll .dropdown-menu, .dropdown.dropdown-scroll .dropdown-panel
	{
	max-height: 358px;
	overflow: auto;
}

.dropdown .dropdown-menu LI {
	list-style: none;
	padding: 0 0;
	margin: 0;
	line-height: 14px;
}

.dropdown .dropdown-menu LI>A, .dropdown .dropdown-menu LABEL {
	display: block;
	color: #555;
	text-decoration: none;
	line-height: 14px;
	padding: 3px 15px;
	white-space: nowrap;
}

.dropdown .dropdown-menu LI>A:hover, .dropdown .dropdown-menu LABEL:hover
	{
	background-color: #08C;
	color: #FFF;
	cursor: pointer;
}

.dropdown .dropdown-menu .dropdown-divider {
	font-size: 1px;
	border-top: solid 1px #E5E5E5;
	padding: 0;
	margin: 5px 0;
}

.dropdown.has-icons LI>A {
	padding-left: 30px;
	background-position: 8px center;
	background-repeat: no-repeat;
}

.dropdown-divider-up {
	border-bottom: solid 1px #ccc
}

.dropdown-divider-down {
	border-bottom: solid 1px #fff
}

.dropdown {
	font-size: 12px;
}

.drop-frame {
	display: none;
	border: dashed 3px lightgray;
	border-radius: 3px;
	position: absolute;
	left: -2px;
	top: -2px;
	width: 60px;
	height: 60px;
	z-index: 100;
}

.jp-creating .active-frame .drop-frame {
	display2: block;
}

.no-close .ui-dialog-titlebar-close {
	display: none
}
</style>
<!--noexcel中来-->
<style type="text/css">
div.ui-dialog {
	box-shadow: 0 0 13px rgba(0, 0, 0, 0.15);
	padding: 1px;
}

div.ui-dialog-titlebar {
	border-bottom-left-radius: 0;
	border-bottom-right-radius: 0;
}

.borderpattern p {
	margin: 0px;
	padding: 0px;
	height: 0px;
}

.borderpattern div {
	padding: 5px 3px;
	height: 0px;
	border: solid 1px F0F1EC;
}

.borderpattern div.selected {
	border: dotted 1px blue;
	padding-left: 10px;
	padding-right: 10px;
}

.borderthick p {
	margin: 0px;
	padding: 0px;
	background: black;
}

.borderthick div {
	border: solid 1px F0F1EC;
	padding: 3px
}

.borderthick div.selected {
	border: dotted 1px blue;
	padding-left: 10px;
	padding-right: 10px;
}

.separator {
	border-bottom: none;
	border-left: none;
	border-right: none;
}

.toggleselect button {
	height: 24px;
	width: 24px;
}

.preborder button {
	height: 40px;
	width: 40px;
}

.borderselect button {
	display2: block;
	position2: absolute;
}

legend {
	margin-left: 10px;
}

#mytable td {
	line-height: 1px;
	white-space: nowrap;
}

td2 {
	border: solid 1px black
}

button {
	margin: 0px;
	padding: 0px;
}

.selection-frame {
	position: absolute;
	border: solid 2px #3E63A8;
}

.selection-bg {
	background-color: #3E63A8;
	filter: Alpha(Opacity = 10);
	position: relative;
	opacity: 0.10;
	width: 100%;
	height: 100%;
}

.header-table td, #firstcell2 {
	border: #aaaaaa 1px solid;
	font-family: Arial sans;
	font-size: 12px;
	text-align: center;
	background-color: #dddddd;
	padding: 0px;
	margin: 0px;
	overflow2: hidden;
	white-space: nowrap;
}

.top-header-table td {
	height: 20px;
	line-height: 20px
}

.header-td-wrap {
	position: relative;
	height: 100%;
	width: 100%
}

.header-text {
	position: absolute;
	height: 100%;
	width: 100%;
}

.top-header-handle {
	position: absolute;
	right: 0px;
	top: 0px;
	cursor: e-resize;
	height: 100%;
	width: 3px;
	z-index: 100;
}

.left-header-handle {
	position: absolute;
	left: 0px;
	bottom: 0px;
	cursor: s-resize;
	width: 100%;
	height: 3px;
	z-index: 100;
}

.header-table td.focused {
	background-color: #B1BBD8;
}

table {
	border-spacing: 0;
}

.top-header-div {
	position: relative;
	top: 1px;
	left: 0;
}

.jp-page td {
	border: #ECE9D8 1px solid;
	font-family: Arial sans;
	font-size: 12px;
	text-align: center;
	overflow: hidden;
	white-space: nowrap;
}

div.jp-black-border td {
	border: black 1px solid;
}

div.jp-no-border table {
	border: none;
}

.jp-page td.noleft {
	border-left: none;
}

.jp-page td.noright {
	border-right: none;
}

.jp-page td.notop {
	border-top: none;
}

.jp-page td.nobottom {
	border-bottom: none;
}

.sheet-wrapper td {
	padding: 0px;
}
/*table
         {
         border-collapse: collapse;
         table-layout:fixed;
         }
         td{
         border:solid 1px;
         }
         */
.sheet-wrapper, table.sheet-wrapper table {
	border-collapse: collapse;
	table-layout: fixed;
}

.rubber {
	position: absolute;
	border-left: dotted 1px blue;
	border-top: dotted 1px blue;
	display: none
}

.celleditor {
	position: absolute;
	display: none
}

.header-row {
	height: 20px
}

.sheet-wrapper table {
	padding: 0;
	border-spacing: 0;
	border-collapse: collapse;
}

.top-header-div {
	overflow: hidden;
	margin: 0px;
	padding: 0px;
	height: 100%;
	width: 100%
}

.left-header-div {
	overflow: hidden;
	width: 100%;
}

.content-div { //
	overflow: scroll;
	width: 100%;
	height: 100%;
	position: relative;
	top: 0px;
	left: 0;
	padding: 0px;
}

.content-div input {
	z-index: 200;
	padding: 0px;
}

.left-header-table {
	overflow: hidden;
	width: 100%;
}

.top-header-table {
	overflow: hidden;
	height: 100%
}

#mytable {
	border: 1px solid black;
}
/*  边框对话框*/
.nx-button-set .nx-clear-border span {
	background-image: url(borderclear.gif);
}

.nx-button-set .nx-outline-border span {
	background-image: url(borderoutline.gif);
}

.nx-button-set .nx-cross-border span {
	background-image: url(bordercross.gif);
}

body .ui-buttonset .ui-button {
	margin-right: -1px;
}

.jp-layout-dlg .ui-dialog-buttonset button:first-child {
	margin-right: 100px;
}

.jp-total-menu:after {
	content: "";
	width: 0;
	height: 0;
	position: absolute;
	right: 15px;
	top: 50%;
	margin-top: -3px;
	border-width: 6px 6px 0 6px;
	border-style: solid;
	border-color: #8aa8bd transparent;
}

.custom-combobox {
	position: relative;
	display: inline-block;
}

.custom-combobox-toggle {
	position: absolute;
	top: 0;
	bottom: 0;
	margin-left: -1px;
	padding: 0;
}

.custom-combobox-input {
	margin: 0;
	padding: 2px 10px;
}

.jp-static .jp-dynamic-option {
	display: none
}

.jp-static-option {
	display: none
}

.jp-static .jp-static-option {
	display: inline
}
</style>
</head>
<body>
	<!-- 条形码对话框 -->
	<div id='jp-bar-1d-dialog' title='一维码设置' class='jp-dialog'>
		<p>
			<span class='jp-field-label'>旋转角度:</span> <input name="rotate"
				type="radio" id="jp-rotate-0" value="0" class='jp-code-ui'><label
				for='jp-rotate-0'> 不旋转</label> <input name="rotate" type="radio"
				id="jp-rotate-90" value="90" class='jp-code-ui'><label
				for='jp-rotate-90'>90度 </label> <input name="rotate" type="radio"
				id="jp-rotate-180" value="180" class='jp-code-ui'><label
				for='jp-rotate-180'> 180度</label> <input name="rotate" type="radio"
				id="jp-rotate-270" value="270" class='jp-code-ui'><label
				for='jp-rotate-270'> 270度</label>
		</p>
		<p>
			<span class='jp-field-label'>背景色:</span><span><input
				type="text" id="jp-bar-background" name="background" size="20"
				style='vertical-align: middle;'
				class="jp-code-ui jp-color-chooser jp-with-transparent" /></span>
		</p>
		<p>
			<span class='jp-field-label'>码条颜色:</span><span><input
				type="text" id="jp-bar-color" name="bar-color" size="20"
				style='vertical-align: middle;' class="jp-code-ui jp-color-chooser"></span>
		</p>
		<p>
			<span class='jp-field-label'>空码条颜色:</span><span><input
				type="text" id="jp-space-color" name="space-color" size="20"
				style='vertical-align: middle;'
				class="jp-code-ui jp-color-chooser jp-with-transparent"></span>
		</p>
		<p>
			<span class='jp-field-label'>显示文字码:</span><span><input
				type="checkbox" id="jp-show-text" value="true" name="show-text"
				class='jp-code-ui'></span>
		</p>
		<p>
			<span class='jp-field-label'>字体:</span> <span> <select
				size="1" name="font-name" id="jp-font-name" class='jp-code-ui'>
					<option value="" selected></option>
			</select>
			</span>
		</p>
		<p>
			<span class='jp-field-label'>字体大小(像素):</span> <span> <select
				size="1" name="font-size" class='jp-code-ui'>
					<option value="" selected></option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
			</select>
			</span>
		</p>
		<p>
			<span class='jp-field-label'>文本颜色:</span><span><input
				type="text" id="jp-text-color" name="text-color" size="20"
				style='vertical-align: middle;' class="jp-code-ui jp-color-chooser"></span>
		</p>
	</div>




	<!-- 表格属性对话框 -->
	<div id='jp-table-dialog' title='表格属性设置' class='jp-dialog'>
		<p class='jp-dynamic-option'>
			<span class='jp-field-label'>表头行数:</span> <span class="ui-widget">
				<select size="1" id="table-header-rows">
					<option value="0" selected>无</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
			</select>
			</span>
		</p>

		<p>
			<span id="jp-rows-label" class='jp-field-label'>表体最大行数:</span><span
				class="ui-widget"> <select size="1" id="table-body-rows">
					<option value="1" selected>1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
					<option value="60">60</option>
					<option value="70">70</option>
			</select>
			</span>
		</p>
		<p class='jp-dynamic-option'>
			<span class='jp-field-label'>表尾行数:</span> <span class="ui-widget">
				<select size="1" id="table-footer-rows">
					<option value="0" selected>无</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
			</select>
			</span>
		</p>
		<p>
			<span class='jp-field-label'>列数:</span> <span class="ui-widget"><select
				size="1" id="table-columns">
					<option value="0" selected>自动(按字段数自动扩展)</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
			</select> </span>
		</p>
		<p>
			<span class='jp-field-label'>有边框线:</span><span><input
				type="checkbox" id="table-no-borders" value="true"></span>

		</p>
	</div>
	<div id='jp-pdf417-dialog' title='PDF 417 设置' class='jp-dialog'>
		<p>
			<span class='jp-field-label'>数据列数(1-30):</span> <span> <select
				size="1" name="data-cols" class='jp-code-ui'>
					<option value="" selected></option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
			</select>
			</span>
		</p>
		<p>
			<span class='jp-field-label'>数据行数(3-90):</span> <span> <select
				size="1" name="data-rows" class='jp-code-ui'>
					<option value="" selected></option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
					<option value="60">60</option>
					<option value="70">70</option>
					<option value="80">80</option>
					<option value="90">90</option>
			</select>
			</span>
		</p>
		<p>
			<span class='jp-field-label'>纠错等级(0-7):</span> <span> <select
				size="1" name="err-level" class='jp-code-ui'>
					<option value="" selected></option>
					<option value="0">0</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
			</select>
			</span>
		</p>
		<p>
			<span class='jp-field-label'>背景色:</span><span><input
				type="text" id="jp-bar-background" name="background" size="20"
				style='vertical-align: middle;'
				class="jp-code-ui jp-color-chooser jp-with-transparent" /></span>
		</p>
		<p>
			<span class='jp-field-label'>码条颜色:</span><span><input
				type="text" id="jp-bar-color" name="bar-color" size="20"
				style='vertical-align: middle;' class="jp-code-ui jp-color-chooser"></span>
		</p>
		<p>
			<span class='jp-field-label'>空码条颜色:</span><span><input
				type="text" id="jp-space-color" name="space-color" size="20"
				style='vertical-align: middle;'
				class="jp-code-ui jp-color-chooser jp-with-transparent"></span>
		</p>
	</div>
	<div id='jp-qr-dialog' title='QRCode 设置' class='jp-dialog'>
		<p>
			<span class='jp-field-label'>版本号(1-40)-(l/m/q/h):</span> <span>
				<select size="1" id='jp-qr-version' name="ver"
				class='jp-code-ui qr-version'>
					<option value="" selected></option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
					<option value="21">31</option>
					<option value="22">32</option>
					<option value="23">33</option>
					<option value="24">34</option>
					<option value="25">35</option>
					<option value="26">36</option>
					<option value="27">37</option>
					<option value="28">38</option>
					<option value="29">39</option>
					<option value="30">40</option>
			</select>
			</span> <span> <select size="1" id='jp-qr-version-2' name="err-level"
				class='jp-code-ui'>
					<option value="" selected></option>
					<option value="l">L</option>
					<option value="m">M</option>
					<option value="q">Q</option>
					<option value="h">H</option>
			</select>
			</span>
		</p>
		<p>
			<span class='jp-field-label'>背景色:</span><span><input
				type="text" id="jp-bar-background" name="background" size="20"
				style='vertical-align: middle;'
				class="jp-code-ui jp-color-chooser jp-with-transparent" /></span>
		</p>
		<p>
			<span class='jp-field-label'>码条颜色:</span><span><input
				type="text" id="jp-bar-color" name="bar-color" size="20"
				style='vertical-align: middle;' class="jp-code-ui jp-color-chooser"></span>
		</p>
		<p>
			<span class='jp-field-label'>空码条颜色:</span><span><input
				type="text" id="jp-space-color" name="space-color" size="20"
				style='vertical-align: middle;'
				class="jp-code-ui jp-color-chooser jp-with-transparent"></span>
		</p>
	</div>
	<div id='jp-datamatrix-dialog' title='Data Matrix 设置' class='jp-dialog'>
		<p>
			<span class='jp-field-label'>版本号(1-40)-(l/m/q/h):</span> <span>
				<select size="1" name="moudles" class='jp-code-ui'>
					<option value="" selected></option>
					<option value="8x18">8x18</option>
					<option value="8x32">8x32</option>
					<option value="10x10">10x10</option>
					<option value="12x12">12x12</option>
					<option value="12x26">12x26</option>
					<option value="12x36">12x36</option>
					<option value="14x14">14x14</option>
					<option value="16x16">16x16</option>
					<option value="16x36">16x36</option>
					<option value="16x48">16x48</option>
					<option value="18x18">18x18</option>
					<option value="20x20">20x20</option>
					<option value="22x22">22x22</option>
					<option value="24x24">24x24</option>
					<option value="26x26">26x26</option>
					<option value="32x32">32x32</option>
					<option value="36x36">36x36</option>
					<option value="40x40">40x40</option>
					<option value="44x44">44x44</option>
					<option value="48x48">48x48</option>
					<option value="52x52">52x52</option>
					<option value="64x64">64x64</option>
					<option value="72x72">72x72</option>
					<option value="80x80">80x80</option>
					<option value="88x88">88x88</option>
					<option value="96x96">96x96</option>
					<option value="104x104">104x104</option>
					<option value="120x120">120x120</option>
					<option value="132x132">132x132</option>
			</select>
			</span>
		</p>
		<p>
			<span class='jp-field-label'>背景色:</span><span><input
				type="text" id="jp-bar-background" name="background" size="20"
				style='vertical-align: middle;'
				class="jp-code-ui jp-color-chooser jp-with-transparent" /></span>
		</p>
		<p>
			<span class='jp-field-label'>码条颜色:</span><span><input
				type="text" id="jp-bar-color" name="bar-color" size="20"
				style='vertical-align: middle;' class="jp-code-ui jp-color-chooser"></span>
		</p>
		<p>
			<span class='jp-field-label'>空码条颜色:</span><span><input
				type="text" id="jp-space-color" name="space-color" size="20"
				style='vertical-align: middle;'
				class="jp-code-ui jp-color-chooser jp-with-transparent"></span>
		</p>
	</div>
	<!-- 下拉框 -->
	<div id="jp-barcode-chooser" class="dropdown dropdown-tip">
		<ul class="dropdown-menu">
			<li><a href="#" code-type='code39'>Code 39</a></li>
			<li><a href="#" code-type='code93'>Code 93</a></li>
			<li><a href="#" code-type='2of5'>Code 2 of 5</a></li>
			<li><a href="#" code-type='code128'>Code 128</a></li>
			<li><a href="#" code-type='code128a'>Code 128A</a></li>
			<li><a href="#" code-type='code128b'>Code 128B</a></li>
			<li><a href="#" code-type='code128c'>Code 128C</a></li>
			<li><a href="#" code-type='ean13'>Ean 13</a></li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#" code-type='pdf417'>PDF 417</a></li>
			<li><a href="#" code-type='qr'>QR Code</a></li>
			<li><a href="#" code-type='datamatrix'>DataMatrix</a></li>
		</ul>
	</div>
	<div id="jp-layer-actions"
		class="jp-common-command dropdown dropdown-tip drop-with-icon">
		<ul class="dropdown-menu">
			<li><a href="#" id='jp-front'>靠前一层&nbsp;&nbsp;(Ctrl+PgUp)</a></li>
			<li><a href="#" id='jp-back'>靠后一层&nbsp;&nbsp;(Ctrl+PgDn)</a></li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#" id='jp-top'>最前&nbsp;&nbsp;(Ctrl+Home)</a></li>
			<li><a href="#" id='jp-bottom'>最后&nbsp;&nbsp;(Ctrl+End)</a></li>
		</ul>
	</div>
	<div id="jp-align2-actions"
		class="jp-common-command dropdown dropdown-tip drop-with-icon">
		<ul class="dropdown-menu">
			<li><a href="#" id='jp-align2-left'>左对齐</a></li>
			<li><a href="#" id='jp-align2-center'>水平居中</a></li>
			<li><a href="#" id='jp-align2-right'>右对齐</a></li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#" id='jp-align2-top'>上对齐</a></li>
			<li><a href="#" id='jp-align2-middle'>垂直居中</a></li>
			<li><a href="#" id='jp-align2-bottom'>下对齐</a></li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#" id='jp-equal-width'>等宽</a></li>
			<li><a href="#" id='jp-equal-height'>等高</a></li>
		</ul>
	</div>
	<div id="jp-border-actions"
		class="jp-common-command dropdown dropdown-tip drop-with-icon">
		<ul class="dropdown-menu">
			<li><a href="#" id='jp-border-1px'>边框</a></li>
			<li><a href="#" id='jp-border-no'>清除边框</a></li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#" id='jp-border-custom'>自定义边框...</a></li>
		</ul>
	</div>
	<div id="jp-border-style-actions"
		class="jp-border-command dropdown dropdown-tip">
		<ul class="dropdown-menu jp-style-setting">
			<li><a href="#" id='jp-border-style-solid'><span
					style='border-top-style: solid'></span></a></li>
			<li><a href="#" id='jp-border-style-dotted'><span
					style='border-top-style: dotted'></span></a></li>
			<li><a href="#" id='jp-border-style-dashed'><span
					style='border-top-style: dashed'></span></a></li>
		</ul>
	</div>
	<div id="jp-border-width-actions"
		class="jp-border-command dropdown dropdown-tip">
		<ul class="dropdown-menu jp-style-setting">
			<li><a href="#" id='jp-border-style-1px'><span
					style='border-top-width: 1px'></span></a></li>
			<li><a href="#" id='jp-border-style-2px'><span
					style='border-top-width: 2px'></span></a></li>
			<li><a href="#" id='jp-border-style-3px'><span
					style='border-top-width: 3px'></span></a></li>
			<li><a href="#" id='jp-border-style-4px'><span
					style='border-top-width: 4px'></span></a></li>
			<li><a href="#" id='jp-border-style-5px'><span
					style='border-top-width: 5px'></span></a></li>
			<li><a href="#" id='jp-border-style-6px'><span
					style='border-top-width: 6px'></span></a></li>
		</ul>
	</div>
	<div id="jp-table-actions" class="jp-table-command dropdown">
		<ul class="dropdown-menu">
			<li><a href="#" id='jp-table-merge'>合并单元格</a></li>
			<li><a href="#" id='jp-table-unmerge'>撤销合并</a></li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#" id='jp-table-insert-1-row-before'>向前插入1行</a></li>
			<li><a href="#" id='jp-table-insert-3-row-before'>向前插入3行</a></li>
			<li><a href="#" id='jp-table-insert-1-row-after'>向后插入1行</a></li>
			<li><a href="#" id='jp-table-insert-3-row-after'>向后插入3行</a></li>
			<li><a href="#" id='jp-table-delete-rows'>删除行</a></li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#" id='jp-table-insert-1-col-before'>向前插入1列</a></li>
			<li><a href="#" id='jp-table-insert-3-col-before'>向前插入3列</a></li>
			<li><a href="#" id='jp-table-insert-1-col-after'>向后插入1列</a></li>
			<li><a href="#" id='jp-table-insert-3-col-after'>向后插入3列</a></li>
			<li><a href="#" id='jp-table-delete-cols'>删除列</a></li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#" id='jp-table-border'>显示边框</a></li>
			<li><a href="#" id='jp-table-body'>设为明细行</a></li>
		</ul>
	</div>
	<div id="jp-detail-section-actions" class="jp-table-command dropdown">
		<ul class="dropdown-menu">
			<li><a href="#" id='jp-reset-details'>重置明细行</a></li>
		</ul>
	</div>
	<!-- 线型弹出式菜单 -->
	<div id="jp-line-actions" class="jp-line-command dropdown">
		<ul class="dropdown-menu">
			<li><a class="jp-style-setting" href="#"
				id='jp-border-style-1px'><span style='border-top-width: 1px'></span></a>
			</li>
			<li><a class="jp-style-setting" href="#"
				id='jp-border-style-2px'><span style='border-top-width: 2px'></span></a>
			</li>
			<li><a class="jp-style-setting" href="#"
				id='jp-border-style-3px'><span style='border-top-width: 3px'></span></a>
			</li>
			<li><a class="jp-style-setting" href="#"
				id='jp-border-style-4px'><span style='border-top-width: 4px'></span></a>
			</li>
			<li><a class="jp-style-setting" href="#"
				id='jp-border-style-5px'><span style='border-top-width: 5px'></span></a>
			</li>
			<li><a class="jp-style-setting" href="#"
				id='jp-border-style-6px'><span style='border-top-width: 6px'></span></a>
			</li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#" id='jp-line-color'>颜色</a></li>
		</ul>
	</div>
	<div id="jp-text-actions" class="jp-text-command dropdown">
		<ul class="dropdown-menu">
			<li><a href="#" id='jp-word-wrap'>自动折行</a></li>
			<li><a href="#" id='jp-font-fit'>字体自适应</a></li>
		</ul>
	</div>
	<!-- 边框设置对话框 -->
	<div id="jp-border-dialog" title='边框属性'
		style="width: 805px; height: 513px" class='jp-dialog'>
		<div id='jp-temp' style='display: none'></div>
		<div style='height: 50px;'>
			<div style='line-height: 30px; padding-right: 22px; float: left'>线型设置:</div>
			<div
				style='height: 30px; width: 100px; margin: 0 3px 10px; background: white; float: left'>
				<div id='jp-line-viewer'
					style='position: relative; height: 2px; width: 80%; margin: auto auto; top: 15px; border-top: solid 1px black;'></div>
			</div>
			<div class="jp-button-set jp-toolbar-transparent">
				<a href="#" class='jp-border-style' id='jp-border-style' title='线型'
					data-dropdown='#jp-border-style-actions'></a> <a href="#"
					class='jp-border-width' id='jp-border-width' title='线宽'
					data-dropdown='#jp-border-width-actions'></a> <a href="#"
					class='jp-border-color' id='jp-border-color' title='颜色'></a>
			</div>
		</div>
		<div class='jp-border-previewer'
			style='position: relative; height: 150px; width: 150px; margin: 20px auto 10px; background: white;'>
			<div
				style='left: 0; top: 0; border-bottom: solid 1px #ddd; border-right: solid 1px #ddd;'></div>
			<div
				style='left: 0; bottom: 0; border-top: solid 1px #ddd; border-right: solid 1px #ddd;'></div>
			<div
				style='right: 0; top: 0; border-left: solid 1px #ddd; border-bottom: solid 1px #ddd;'></div>
			<div
				style='right: 0; bottom: 0; border-top: solid 1px #ddd; border-left: solid 1px #ddd;'></div>
			<p id='jp-border-viewer'
				style='position: absolute; left: 10px; top: 10px; right: 10px; bottom: 10px; border: solid 1px gray; padding: 0; margin: 0'></p>
			<div class='jp-border-line border-top'
				style='left: 15px; top: 0; width: 120px; height: 20px;'></div>
			<div class='jp-border-line border-bottom'
				style='left: 15px; bottom: 0; width: 120px; height: 20px;'></div>
			<div class='jp-border-line border-left'
				style='left: 0; top: 15px; height: 120px; width: 20px;'></div>
			<div class='jp-border-line border-right'
				style='right: 0; top: 15px; height: 120px; width: 20px;'></div>
		</div>
		<div class="jp-border-command jp-button-set jp-toolbar-transparent"
			style='float: none; position: relative; width: 186px; margin: 0 auto'>
			<a href="#" class='jp-border-none' id='jp-border-none'></a> <a
				href="#" class='jp-border-all' id='jp-border-all'></a> <a href="#"
				class='jp-border-left' id='jp-border-left'></a> <a href="#"
				class='jp-border-top' id='jp-border-top'></a> <a href="#"
				class='jp-border-right' id='jp-border-right'></a> <a href="#"
				class='jp-border-bottom' id='jp-border-bottom'></a>
		</div>
	</div>
	<!-- 插入图片对话框 -->
	<div id="jp-image-dialog" title='图片属性' class='jp-dialog'>
		<p>
			<span class='jp-field-label'>图片来源：</span> <input type='text'
				id='jp-image-src' style='width: 260px;'></input>
			<button id='jp-file-chooser'
				style='height: 23px; vertical-align: bottom;'>选择文件...</button>
		</p>
		<p>
			<span class='jp-field-label'>原始大小：</span> <input
				id='jp-original-size' type='checkbox'></input>
		</p>
	</div>
	<!-- 出错提示对话框 -->
	<div id="jp-error-dialog" title='出错了!' class='jp-dialog'>
		<p class='jp-error-text'></p>
	</div>
	<!-- 新建报表模板 local -->
	<div id="jp-new-dialog" class='jp-dialog' title='纸张设置'
		style='padding-bottom: 30px'>
		<p>
			<span class='jp-field-label'>纸张：</span> <select id='jp-paper-name'
				size="1" style='width: 150px'>
				<option value="420,594" selected>A2</option>
				<option value="297,420">A3</option>
				<option value="210,297">A4</option>
				<option value="148,210">A5</option>
				<option value="105,148">A6</option>
				<option value="500,707">B2</option>
				<option value="353,500">B3</option>
				<option value="250,353">B4</option>
				<option value="176,250">B5</option>
				<option value="125,176">B6</option>
				<option value="">自定义纸张</option>
			</select>
		</p>
		<p>
			<span class='jp-field-label'></span><input id='jp-paper-width'
				style='width: 60px;'></input>mm(宽) X <input id='jp-paper-height'
				style='width: 60px;'></input>mm(高)
		</p>
		<p class='jp-orientation' style='line-height: 50px; height: 50px;'>
			<span class='jp-field-label'></span> <span
				class='jp-orientation-icon'></span> <input type='radio'
				name='jp-paper-orientation' id='jp-paper-portrait' value='|'></input><label
				for='jp-paper-portrait'>纵向</label> <input type='radio'
				name='jp-paper-orientation' id='jp-paper-landscape'
				style='margin-left: 15px;' value='-'></input><label
				for='jp-paper-landscape'>横向</label>
		</p>
		<br>
		<p style='position: relative; overflow: hidden'>
			<span class='jp-field-label'>底图：</span><span class='jp-local'
				style='display: inline;'><input type='text' id='jp-image-src'
				style='width: 260px;'></input>
				<button id='jp-file-chooser'
					style='height: 23px; vertical-align: bottom; width: 60px;'>浏览...</button></span><input
				class='jp-remote' type='file' id='jp-file-input'
				name='jp-file-input'
				style='position: absolute; top: 0px; border: solid 1px black; height: 23px; width: 65px; vertical-align: bottom; display: block; right: 40px; display: none;'
				value='选择文件...'></input>
		</p>
		<p class='jp-background-settings'>
			<span class='jp-field-label'>透明度：</span><span id="jp-alpha"
				style='margin-left: 6px; padding-left: 200px; display: inline-block;'></span><br>
			<span class='jp-field-label'>比例：</span><input type='radio'
				name='jp-background-ratio' id='jp-stretch' value='jp-stretch'><label
				for='jp-stretch'>铺满</label> <input type='radio'
				name='jp-background-ratio' id='jp-keep-width' value='jp-keep-width'><label
				for='jp-keep-width'>宽度优先</label></input><input type='radio'
				name='jp-background-ratio' id='jp-keep-height'
				style='margin-left: 15px;' value='jp-keep-height'></input><label
				for='jp-keep-height'>高度优先</label>

		</p>

	</div>

	<!-- 保存模板对话框 -->
	<div id="jp-template-save-dialog" title='保存模板' class='jp-dialog'>
		<p>
			<span class='jp-field-label' style='width: auto;'>模板名称：</span> <input
				type='text' id='jp-settings-id' style='width: 260px;'></input>
		</p>
	</div>
	<!-- 上下偏移调整 -->
	<div id="jp-v-offset-dialog" class='jp-dialog' title='上下偏移调整'
		style='height: 400px; background-color2: gray; background-position: 10px 50%; background-repeat: no-repeat;'>
		<div class='jp-orientation'
			style='float: right; margin-top: 220px; line-height: 32px; height: 150px;'>
			<p style='padding: 0; margin: 0;'>
				<input type='radio' name='jp-paper-orientation' id='jp-paper-down'
					checked="checked"></input> <label for='jp-paper-down'>往下偏</label> <input
					type='radio' name='jp-paper-orientation' id='jp-paper-up'
					style='margin-left: 15px;' value='-'></input> <label
					for='jp-paper-up'>往上偏</label>
			</p>
			<label for='jp-paper-landscape'>偏多少(mm):</label> <input
				id='jp-paper-offset' style='width: 50px; margin-left: 5px;'
				value='0.0'></input>
		</div>
	</div>
	<!-- 左右偏移调整 -->
	<div id="jp-h-offset-dialog" class='jp-dialog' title='左右偏移调整'
		style='height: 100%; background-position: 10px 10px; background-repeat: no-repeat;'>
		<div
			style='position: absolute; bottom: 0; right: 50px; line-height: 32px;'>
			<p style='padding: 0; margin: 0;'>
				<input type='radio' name='jp-paper-orientation' id='jp-paper-left'
					checked="checked"></input> <label for='jp-paper-left'>往左偏</label> <input
					type='radio' name='jp-paper-orientation' id='jp-paper-right'
					style='margin-left: 15px;' value='-'></input> <label
					for='jp-paper-right'>往右偏</label> <label for='jp-paper-landscape'
					style='width: 50px; margin-left: 100px;'>偏多少(mm):</label> <input
					id='jp-paper-offset' style='width: 50px;' value='0.0'></input>
			</p>
		</div>
	</div>
	<!-- 模板创建代码查看 -->
	<div id="jp-source-code-dialog" title='代码查看' style='overflow: hidden;'
		class='jp-dialog'>
		<div class='jp-toolbar-transparent' style='margin-bottom: 3px;'>
			<div class="jp-button-set" style='float: right; margin-bottom: 5px;'>
				<a href="#" class='jp-copy-code' id='jp-copy-code' title='复制代码'></a>
				<a href="#" class='jp-save-code' id='jp-save-code' title='保存'></a>
			</div>
			<div style='float: right; padding-top: 3px; margin-right: 25px;'>
				<input type='checkbox' checked id='jp-debug-code'
					title='生成的代码包含打印预览、提示打印、直接打印按钮代码'> <label
					for='jp-debug-code' title='生成的代码包含打印预览、提示打印、直接打印按钮代码'>包含测试按钮</label>
				<input type='checkbox' checked id='jp-cross-browser'
					title='生成的代码支持除 IE 外的浏览器，如firefox,chrome,safari'> <label
					for='jp-cross-browser'
					title='生成的代码支持除 IE 外的浏览器，如firefox,chrome,safari'>跨浏览器支持</label>
			</div>
		</div>
		<div id='jp-code'
			style='padding: 0; margin: 0; height: 400px; overflow: hidden; position: relative; width: 100%;'></div>
		<textarea id='jp-plain-code' style='display: none'></textarea>
	</div>
	<!-- 组件面板,在新建套打模板时使用 -->
	<div id="jp-comp-list-dialog" title='可用组件' class='jp-dialog'>
		<ul id='jp-comp-list'></ul>
	</div>
	<!-- 工具栏 -->
	<div class='jp-main-tools jp-toolbar jp-common-command'>
		<div class="jp-button-set">
			<a href="#" class='jp-new jp-view100' id='jp-new' title='新建报表模板'></a>
			<a href="#" class='jp-v-offset jp-view010' id='jp-v-offset'
				title='纸张上下偏移调整'></a> <a href="#" class='jp-h-offset jp-view010'
				id='jp-h-offset' title='纸张左右偏移调整'></a> <a href="#"
				class='jp-open jp-view100' id='jp-open' title='打开'></a> <a href="#"
				class='jp-save jp-view100' id='jp-save' title='保存'></a>
			<!--a href="#" class='jp-print' id='jp-print' title='打印'></a-->
		</div>
		<div class="jp-button-set">
			<a href="#" class='jp-undo' id='jp-undo' title='撤销(ctrl+z) '></a> <a
				href="#" class='jp-redo' id='jp-redo' title='重做(ctrl+y)'></a> <a
				href="#" class='jp-copy jp-view101' id='jp-copy' title='复制(ctrl+c)'></a>
			<a href="#" class='jp-cut jp-view101' id='jp-cut' title='剪切(ctrl+x)'></a>
			<a href="#" class='jp-paste jp-view101' id='jp-paste'
				title='粘贴(ctrl+v)'></a> <a href="#" class='jp-delete jp-view101'
				id='jp-delete' title='删除(Delete)'></a>
		</div>

		<div class="jp-button-set">
			  <a href="#"
				class='jp-new-image jp-view111' id='jp-new-image' title='新建图像'></a>
			<a href="#"
				class='jp-new-table jp-view111' id='jp-new-table' title='新建表格'></a>
		</div>

		<!-- div class="jp-button-set">
			<a href="#" class='jp-new-label jp-view111' id='jp-new-label'
				title='新建标签'></a> <a href="#" class='jp-new-text jp-view111'
				id='jp-new-text' title='新建文本字段'></a> <a href="#"
				class='jp-new-barcode jp-view111'
				data-dropdown="#jp-barcode-chooser" title='新建条形码'></a> <a href="#"
				class='jp-new-image jp-view111' id='jp-new-image' title='新建图像'></a>
			<a href="#" class='jp-new-line-vert jp-view111' id='jp-new-line-vert'
				title='新建竖线'></a> <a href="#" class='jp-new-line-horz jp-view111'
				id='jp-new-line-horz' title='新建横线'></a> <a href="#"
				class='jp-new-table jp-view111' id='jp-new-table' title='新建表格'></a>
		</div-->
		<select id='jp-font-chooser'
			style='height: 24px; float: left; margin: 2px 5px 2px 2px; width: 100px;'></select>
		<div class="jp-button-set jp-font-style">
			<input type="checkbox" id="jp-bold" name="font-style"
				value="Column3D" /> <label for="jp-bold" class="jp-bold"></label> <input
				type="checkbox" id="jp-italic" name="font-style" value="Pie3D" /> <label
				for="jp-italic" class="jp-italic"></label> <input type="checkbox"
				id="jp-underline" name="font-style" value="Line" /> <label
				for="jp-underline" class="jp-underline"></label>
		</div>
		<div class="jp-button-set" style='float: left;'>
			<a href="#" title='字体变大(ctrl+])' class='jp-size-up' id='jp-size-up'></a>
			<a href="#" title='字体变小(ctrl+[)' class='jp-size-down'
				id='jp-size-down'></a> <a href="#" title='字体颜色' class='jp-color'
				id='jp-color'></a> <a href="#" title='背景颜色'
				class='jp-background jp-with-transparent' id='jp-background'></a> <a
				href="#" title='边框' class='jp-border' id='jp-border'
				data-dropdown='#jp-border-actions'></a>
		</div>
		<div class="jp-button-set jp-align">
			<input type="radio" id="jp-align-left" name="jp-align" value="left" />
			<label for="jp-align-left" class="jp-align-left"></label> <input
				type="radio" id="jp-align-center" name="jp-align" value="center" />
			<label for="jp-align-center" class="jp-align-center"></label> <input
				type="radio" id="jp-align-right" name="jp-align" value="right" /> <label
				for="jp-align-right" class="jp-align-right"></label> <input
				type="radio" id="jp-align-justify" name="jp-align" value="justify" />
			<label for="jp-align-justify" class="jp-align-justify"></label>
		</div>
		<div class="jp-button-set">
			<a href="#" class='jp-align2' data-dropdown="#jp-align2-actions"
				title='同大小、对齐调整'></a> <a href="#" class='jp-layers'
				data-dropdown="#jp-layer-actions" title='前后次序调整'></a>
		</div>
		<div class="jp-button-set jp-commands">
			<a href="#" title='清除注册表中的位置调整信息、最后一次打印所选打印机,纸张,方向等'
				id='jp-reset-all' class='jp-view010'>重置所有</a> <a href="#"
				title='清除注册表中的位置调整信息' id='jp-reset-position' class='jp-view010'>重置位置</a>
			<a href="#" title='保存本次调整' class='jp-ok jp-view010' id='jp-ok'>确定</a>
			<a href="#" class='jp-cancel jp-view010' id='jp-cancel'>取消</a> <a
				href="#" title='标签页面布局' class='jp-layout jp-view111' id='jp-layout'>页面设置</a>

			<a href="#" title='标签页面布局' class='jp-test-print jp-view111'
				id='jp-test-print'>打印测试</a> <a href="#" title='保存本次设计'
				class='jp-upload-template jp-view111' id='jp-upload-template'
				style="">保存</a> <a href="#" class='jp-close jp-view100'
				id='jp-close'>退出</a>
		</div>
	</div>
	<a href='http://print.jatools.com' title='帮助'
		style='background: url(images/question.png) no-repeat; width: 20px; height: 20px; display: block; color: white; top: 10px; right: 20px; position: absolute;'
		target='_blank'></a>
	<div class='jp-content'
		style='position: absolute; left: 0; bottom: 0; right: 0;'>
		<div class='jp-page jp-portrait jp-hidden content-div'
			style='margin: 5px; position: relative; width: 210mm; height: 297mm; box-shadow: 0 0 13px rgba(0, 0, 0, 0.31); border: solid 1px gray;'>
			<img class='jp-paper-background jp-stretch screen-only'
				src='images/blank.png'></img>
			<p class='jp-h-ruler jp-ruler-element'></p>
			<p class='jp-v-ruler jp-ruler-element'></p>
		</div>
		<div class='jp-for-layout-outer'
			style='left: 0; top: 0; bottom: 0; right: 340px; position: absolute; background: #cccccc; overflow: hidden; margin: auto auto;'>
			<div class='jp-for-layout'
				style='overflow: hidden; margin: 0; position: absolute; width: 210mm; height: 297mm; box-shadow: 0 0 13px rgba(0, 0, 0, 0.31); border: solid 1px gray; transform-origin2: 0 0; -ms-transform-origin2: 50% 60%; -webkit-transform-origin2: 50% 50%; background: #fff'></div>
		</div>
		<div id='jp-grid-settings'
			style='width: 300px; top: 0; bottom: 0; right: 0; position: absolute; background: #f6f6f6'>
			<p>
				<span class='jp-field-label'>纸张：</span> <select id='jp-paper-name2'
					size="1" style='width: 150px;'>
					<option value="420,594" selected>A2</option>
					<option value="297,420">A3</option>
					<option value="210,297">A4</option>
					<option value="148,210">A5</option>
					<option value="105,148">A6</option>
					<option value="500,707">B2</option>
					<option value="353,500">B3</option>
					<option value="250,353">B4</option>
					<option value="176,250">B5</option>
					<option value="125,176">B6</option>
					<option value="">自定义纸张</option>
				</select>
			</p>
			<p style='margin-bottom: 0'>
				<span class='jp-field-label'></span> <input id='jp-paper-width2'
					style='width: 60px;'></input>mm(宽)
			</p>
			<p style='margin-top: 5px'>
				<span class='jp-field-label'></span> <input id='jp-paper-height2'
					style='width: 60px;'></input>mm(高)
			</p>
			<p class='jp-orientation' style='line-height: 50px; height: 50px;'>
				<span class='jp-field-label'></span> <span
					class='jp-orientation-icon'></span> <input type='radio'
					name='jp-paper-orientation2' id='jp-paper-portrait2' value='|'></input>
				<label for='jp-paper-portrait2'>纵向</label> <input type='radio'
					name='jp-paper-orientation2' id='jp-paper-landscape2'
					style='margin-left: 15px;' value='-'></input> <label
					for='jp-paper-landscape2'>横向</label>
			</p>
			<p>
				<a class='auto-layout' style='clear: both;'>自动排列</a>
			</p>
			<br> <br>
			<p style='display2: none;'>
				<span class='jp-field-label'>行数：</span> <input id="jp-layout-rows"
					style='width: 35px;'></input>
			</p>
			<p style='display2: none;'>
				<span class='jp-field-label'>列数：</span> <input id="jp-layout-cols"
					style='width: 35px;'></input>
			</p>
			<p style='display2: none;'>
				<span class='jp-field-label'>左边距(mm)：</span> <input
					id="jp-layout-left" style='width: 35px;'></input>
			</p>
			<p style='display2: none;'>
				<span class='jp-field-label'>上边距(mm)：</span> <input
					id="jp-layout-top" style='width: 35px;'></input>
			</p>
			<p style='display2: none;'>
				<span class='jp-field-label'>行间隔(mm)：</span> <input
					id="jp-layout-row-gap" style='width: 35px;'></input>
			</p>
			<p style='display2: none;'>
				<span class='jp-field-label'>列间隔(mm)：</span> <input
					id="jp-layout-col-gap" style='width: 35px;'></input>
			</p>
			<br>
			<!--p><span class='jp-field-label'>缩放预览<span id='jp-zoom-value' style='margin-left:5px;'></span>：</span><span id="jp-layout-zoom" style='padding-left:150px;display:inline-block;'></span></p-->
			<p>
				<a class='layout-print' style='float: left; margin-right: 60px;'>打印测试</a>
				<a class='layout-ok' style='float: right;'>确定</a><a
					class='layout-cancel' style='float: right;'>取消</a>
			</p>
		</div>
		<p></p>
	</div>
	<iframe id='jp-ax' style='width: 0; height: 0'></iframe>
	<p class='jp-bottom-bar'
		style='position: absolute; left: 0; bottom: 0; width: 200mm; font-size: 12px; margin-left: 30px;'>
		宽度(mm): <input id='jp-width-input'
			style='width: 50px; margin-right: 10px;'></input>高度(mm): <input
			id='jp-height-input' style='width: 50px;'></input> </span>
	</p>

	<div id="jp-total-menu" class="dropdown">
		<ul class="dropdown-menu">
			<li><a href="#">总计</a></li>
			<li><a href="#">平均</a></li>
			<li><a href="#">最大</a></li>
			<li><a href="#">最小</a></li>
			<li class="dropdown-divider-up"></li>
			<li class="dropdown-divider-down"></li>
			<li><a href="#">本页合计</a></li>
			<li><a href="#">本页平均</a></li>
			<li><a href="#">本页最大</a></li>
			<li><a href="#">本页最小</a></li>

		</ul>
	</div>

</body>
</html>
<script>
	if (nobuttons) {
		$(nobuttons).css("display", "none")
	}
</script>
