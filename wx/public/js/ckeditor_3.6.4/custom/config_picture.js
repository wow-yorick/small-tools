/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	//工具栏是否可以被收缩 plugins/toolbar/plugin.js
	//config.toolbarCanCollapse = true;

	//工具栏默认是否展开 plugins/toolbar/plugin.js
	//config.toolbarStartupExpanded = true;

	//编辑器的高度
	config.width = 300;
	config.height = 200;

	config.toolbar = 'Picture';
	config.toolbar_Picture =
	[
		['Source'],['ImageButton']
	];
};
