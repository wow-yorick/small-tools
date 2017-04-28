$(function(){
	var level=0;
	var LOOP_SIZE=100;
	var _blank='js/print/blank.png'
	function finishTabifier(code,callback){
		code=code.replace(/\n\s*\n/g,'\n'); // blank lines
		code=code.replace(/^[\s\n]*/,''); // leading space
		code=code.replace(/[\s\n]*$/,''); // trailing space
		level=0;
		callback(code);
	}
	function cleanHTML(code,callback){
		var i=0;
		function cleanAsync(){
			var iStart=i;
			for(;i<code.length&&i<iStart+LOOP_SIZE;i++){
				point=i;
				// if no more tags, copy and exit
				if(-1==code.substr(i).indexOf('<')){
					out+=code.substr(i);
					finishTabifier(out,callback);
					return;
				}
				// copy verbatim until a tag
				while(point<code.length&&'<'!=code.charAt(point))
					point++;
				if(i!=point){
					cont=code.substr(i,point-i);
					if(!cont.match(/^\s+$/)){
						if('\n'==out.charAt(out.length-1)){
							out+=tabs();
						}else if('\n'==cont.charAt(0)){
							out+='\n'+tabs();
							cont=cont.replace(/^\s+/,'');
						}
						cont=cont.replace(/\s+/g,' ');
						out+=cont;
					}
					if(cont.match(/\n/)){
						out+='\n'+tabs();
					}
				}
				start=point;
				// find the end of the tag
				while(point<code.length&&'>'!=code.charAt(point))
					point++;
				tag=code.substr(start,point-start);
				i=point;
				// if this is a special tag, deal with it!
				if('!--'==tag.substr(1,3)){
					if(!tag.match(/--$/)){
						while('-->'!=code.substr(point,3))
							point++;
						point+=2;
						tag=code.substr(start,point-start);
						i=point;
					}
					if('\n'!=out.charAt(out.length-1))
						out+='\n';
					out+=tabs();
					out+=tag+'>\n';
				}else if('!'==tag[1]){
					out=placeTag(tag+'>',out);
				}else if('?'==tag[1]){
					out+=tag+'>\n';
				}else if(t=tag.match(/^<(script|style)/i)){
					t[1]=t[1].toLowerCase();
					tag=cleanTag(tag);
					out=placeTag(tag,out);
					var isStyle=tag.match(/^<style/i);
					end=String(code.substr(i+1)).toLowerCase().indexOf('</'+t[1]);
					if(end){
						cont=code.substr(i+1,end);
						if(isStyle)
							cont=cont.replace(/^([\s]*)(.*)$/gm,function(matched,g1,g2){
										return('\t'+(g2||''));
									})
						i+=end;
						out+=cont;
					}
				}else{
					tag=cleanTag(tag);
					out=placeTag(tag,out);
				}
			}
			if(i<code.length){
				setTimeout(cleanAsync,0);
			}else{
				finishTabifier(out,callback);
			}
		}
		var point=0,start=null,end=null,tag='',out='',cont='';
		cleanAsync();
	}
	function tabs(){
		var s='';
		for(var j=0;j<level;j++)
			s+='\t';
		return s;
	}
	function cleanTag(tag){
		var tagout='';
		tag=tag.replace(/\n/g,' '); // remove newlines
		tag=tag.replace(/[\s]{2,}/g,' '); // collapse whitespace
		tag=tag.replace(/^\s+|\s+$/g,' '); // collapse whitespace
		var suffix='';
		if(tag.match(/\/$/)){
			suffix='/';
			tag=tag.replace(/\/+$/,'');
		}
		var m,partRe=/\s*([^= ]+)(?:=((['"']).*?\3|[^ ]+))?/;
		while(m=partRe.exec(tag)){
			if(m[2]){
				tagout+=m[1].toLowerCase()+'='+m[2];
			}else if(m[1]){
				tagout+=m[1].toLowerCase();
			}
			tagout+=' ';
			// Why is this necessary? I thought .exec() went from where it left off.
			tag=tag.substr(m[0].length);
		}
		return tagout.replace(/\s*$/,'')+suffix+'>';
	}
	var ownLine=['area','body','head','hr','i?frame','link','meta','noscript',
			'style','table','tbody','thead','tfoot'];
	var contOwnLine=['li','dt','dt','h[1-6]','option','script'];
	var lineBefore=new RegExp('^<(/?'+ownLine.join('|/?')+'|'
			+contOwnLine.join('|')+')[ >]');
	lineAfter=new RegExp('^<(br|/?'+ownLine.join('|/?')+'|/'
			+contOwnLine.join('|/')+')[ >]');
	var newLevel=['blockquote','div','dl','fieldset','form','frameset','map',
			'ol','p','pre','select','td','th','tr','ul','object'];
	newLevel=new RegExp('^</?('+newLevel.join('|')+')[ >]');
	function placeTag(tag,out){
		var nl=tag.match(newLevel);
		if(tag.match(lineBefore)||nl){
			out=out.replace(/\s*$/,'');
			out+="\n";
		}
		if(nl&&'/'==tag.charAt(1))
			level--;
		if('\n'==out.charAt(out.length-1))
			out+=tabs();
		if(nl&&'/'!=tag.charAt(1))
			level++;
		out+=tag;
		if(tag.match(lineAfter)||tag.match(newLevel)){
			out=out.replace(/ *$/,'');
			out+="\n";
		}
		return out;
	}
	var htmlfilter='html 文件 (*.htm;*.html)|*.htm;*.html|所有文件 (*.*)|*.*';
	function j(){
		return navigator.userAgent.indexOf('MSIE')>-1?document
				.getElementById('ojatoolsPrinter'):document
				.getElementById('ejatoolsPrinter');
	}
	function copy(data){
		j().copy(data);
	}
	function copied(){
		return j().copied();
	}
	function savefile(data){
		var _j=j();
		var file=_j.chooseFile(htmlfilter,'htm',true);
		if(file){
			_j.writeHTML(file,data);
		}
	}
	function jpAlert(text){
		var $d=$('#jp-error-box').dialog({
					dialogClass:'jp-error-dialog',
					width2:200,
					buttons:{
						'知道了':function(){
							$(this).dialog('close');
						}
					}
				}).find('.jp-error-text').html(text);
	}
	// function htmlLoaded(loader){
	// var $doc=$(loader).contents();
	//		
	// }
	function openfile(){
		var _j=j();
		var file=_j.chooseFile(htmlfilter,'htm',false);
		if(file){
			var html=_j.readHTML(file);
			var $loader=$('<iframe class="jp-html-loader"><iframe>');
			// if($.browser.msie){
			// loader.onreadystatechange=function(){
			// if(loader.readyState=="complete"){
			// htmlLoaded(loader);
			// }
			// };
			// }else{
			// loader.onload=function(){
			// htmlLoaded(loader);
			// };
			// }
			$(document.body).append($loader);
			var doc=$loader.contents()[0];
			doc.open();
			doc.writeln(html);
			doc.close();
			var $p=$('.jp-page',doc);
			// 检查是否是正确的jatoolsPrinter可打印文档
			if(!$p.length){
				jpAlert("你的文档有问题啊,没找到 <strong>id</strong> 为 <strong>page1</strong> 对象啊!");
			}else
				handlers.sourceCodeViewer.util.decode($p);
			$loader.remove();
		}
	}
	var showingDropdown=null;
	function clickHides(){
		showingDropdown&&showingDropdown.data('dropdown-trigger').dropdown('hide');
		showingColorChooser&&$(showingColorChooser).spectrum("hide");
	}
	function enableDropdown($){
		$.extend($.fn,{
					dropdown:function(method,data){
						switch(method){
							case 'hide':
								hide();
								return $(this);
							case 'attach':
								return $(this).attr('data-dropdown',data);
							case 'detach':
								hide();
								return $(this).removeAttr('data-dropdown');
							case 'disable':
								return $(this).addClass('dropdown-disabled');
							case 'enable':
								hide();
								return $(this).removeClass('dropdown-disabled');
						}
					}
				});
		function show(event){
			var trigger=$(this),dropdown=$(trigger.attr('data-dropdown')),isOpen=trigger
					.hasClass('dropdown-open');
			if(trigger!==event.target&&$(event.target).hasClass('dropdown-ignore'))
				return;
			event.preventDefault();
			event.stopPropagation();
			hide();
			if(isOpen||trigger.hasClass('dropdown-disabled'))
				return;
			trigger.addClass('dropdown-open');
			dropdown.data('dropdown-trigger',trigger).show();
			position();
			dropdown.trigger('show',{
						dropdown:dropdown,
						trigger:trigger
					});
			showingDropdown=dropdown;
		}
		function hide(event){
			var targetGroup=event?$(event.target).parents().addBack():null;
			if(targetGroup&&targetGroup.is('.dropdown')){
				if(targetGroup.is('.dropdown-menu')){
					if(!targetGroup.is('A'))
						return;
				}else{
					return;
				}
			}
			$(document).find('.dropdown:visible').each(function(){
						var dropdown=$(this);
						dropdown.hide().removeData('dropdown-trigger').trigger('hide',{
									dropdown:dropdown
								});
					});
			$(document).find('.dropdown-open').removeClass('dropdown-open');
			showingDropdown=null;
		}
		function position(){
			var dropdown=$('.dropdown:visible').eq(0),trigger=dropdown
					.data('dropdown-trigger'),hOffset=trigger?parseInt(trigger
							.attr('data-horizontal-offset')
							||0,10):null,vOffset=trigger?parseInt(trigger
							.attr('data-vertical-offset')
							||0,10):null;
			if(dropdown.length===0||!trigger)
				return;
			dropdown.css({
						left:dropdown.hasClass('dropdown-anchor-right')
								?trigger.offset().left
										-(dropdown.outerWidth()-trigger.outerWidth())+hOffset
								:trigger.offset().left+hOffset,
						top:trigger.offset().top+trigger.outerHeight()+vOffset
					});
		}
		$(document).on('click.dropdown','[data-dropdown]',show);
		$(document).on('click.dropdown',hide);
		$(window).on('resize',position);
	}
	enableDropdown(jQuery);
	// undo
	function $Edit(target,fn,oldval,newval,callback){
		this.target=target;
		if($.isFunction(fn[0])){
			this.$unfn=fn[0];
			this.$refn=fn[1];
			this.arg=fn[2]||null;
		}else{
			this.$fn=$.fn[fn[0]];
			this.arg=fn.slice(1);
			this.arg.push(null);
			this.oldval=$.isArray(oldval)?oldval:[oldval];
			this.newval=newval;
		}
		this.callback=callback;
	}
	$Edit.prototype.undo=function(){
		var _this=this;
		this.target.each(function(i){
					if(_this.$unfn){
						_this.$unfn.call(_this);
					}else
						_this.$fn.apply($(this),_this.arg._last(_this.oldval[i]||''));
				});
		this.callback&&this.callback(this);
		return this;
	}
	$Edit.prototype.redo=function(){
		var _this=this,multiple=$.isArray(this.newval)
		this.target.each(function(i){
					if(_this.$refn){
						_this.$refn.call(_this);
					}else
						_this.$fn.apply($(this),_this.arg._last((multiple
										?_this.newval[i]
										:_this.newval)));
				});
		this.callback&&this.callback(this);
		return this;
	}
	function $GroupEdit(callback){
		this.callback=callback;
		this.edits=[];
	}
	$GroupEdit.prototype.undo=function(){
		for(var i=this.edits.length-1;i>=0;i--)
			this.edits[i].undo();
		return this;
	}
	$GroupEdit.prototype.redo=function(){
		for(var i=0;i<this.edits.length;i++)
			this.edits[i].redo();
		return this;
	}
	function Undo(matrix,listener){
		this.listener=listener;
		this.undos=[];
		this.redos=[];
	}
	Undo.prototype.clear=function(){
		this.undos=[];
		this.redos=[];
	}
	Undo.prototype.fire=function(edit){
		// this.listener(this.undos.length,this.redos.length);
		edit&&edit.callback&&edit.callback.call(edit,edit.target);
	}
	Undo.prototype.undo=function(){
		var e=null;
		this.undos.length&&this.redos.push(e=this.undos.pop().undo())&&this.fire(e);
	}
	Undo.prototype.redo=function(){
		var e=null;
		this.redos.length&&this.undos.push(e=this.redos.pop().redo())&&this.fire(e);
	}
	Undo.prototype.add=function(e){
		if(this.group)
			this.group.edits.push(e);
		else{
			this.undos.push(e);
			this.redos=[];
			this.fire();
		}
	}
	Undo.prototype.open=function(){
		this.group=new $GroupEdit();
	}
	Undo.prototype.close=function(){
		var e=this.group;
		this.group=null;
		this.add(e);
	}
	var undo=new Undo();
	$s=function(){
		return $(".ui-selected");
	}
	$.fn.extend({
				'select':function(){
					return $(this).addClass('ui-selected');
				},
				'unselect':function(){
					return $(this).removeClass('ui-selected');
				},
				'selected':function(){
					return $(this[0]).hasClass('ui-selected');
				},
				'vals':function(f,dest){
					var fn=$.fn[f[0]],arg=f.slice(1);
					return this.each(function(){
								dest.push(fn.apply($(this),arg));
							});
				},
				'cssFrom':function(from,styles){
					var me=this;
					$.each(styles,function(){
								me.css(this,$(from).css(this));
							});
					return this;
				},
				'_css':function(style,newval){
					var oldval=[],fn=['css',style];
					this.vals(fn,oldval).css(style,newval);
					undo.add(new $Edit(this,fn,oldval,newval));
					return this;
				},
				'_object':function(){
					return this.find('object,embed').first();
				},
				'borderStyle':function(val){
					var result={},me=this,styles=($(this).attr('style')||'').split(';');
					if(typeof(val)=="undefined"){
						$.each(styles,function(){
									var style=this.split(':');
									if(style.length==2&&$.trim(style[0]).match(/^border.*$/)){
										result[$.trim(style[0])]=$.trim(style[1]);
									}
								})
						return result;
					}else{
						$.each(styles,function(){
									var style=this.split(':');
									if(style.length==2&&$.trim(style[0]).match(/^border.*$/)){
										$(me).css($.trim(style[0]),'');
									}
								})
						return this.css(val);
					}
				},
				'_outerHTML':function(){
					return jQuery('<p>').append(this.eq(0).clone()).html();
				},
				'_border':function(){
					var result={},lastStyle='',eq=true,me=this[0];
					$.each(['Top','Right','Bottom','Left'],function(i,el){
								var style=$.css(me,'border'+el+'Style')+' '
										+$.css(me,'border'+el+'Color')+' '
										+$.css(me,'border'+el+'Width');
								result['border-'+el.toLowerCase()]=style.match(/^none.*/)
										?''
										:style;
								if(i){
									if(lastStyle!=style){
										eq=false;
									}
								}
								lastStyle=style;
							})
					return eq?{
						'border':result['border-top']
					}:result;
				},
				'_style':function(p){
					return $.style(this[0],p);
				},
				'_copyClass':function(from,cls){
					if($(from).is('.'+cls)){
						this.addClass(cls);
					}else
						this.removeClass(cls);
					return this;
				},
				'_copyCss':function(from,p){
					if(!$.isArray(p))
						p=[p];
					var $me=this;
					$.each(p,function(i,e){
								$me.css(e,$(from).css(e));
							});
					return this;
				},
				'_copyAttr':function(from,p,def){
					if(!$.isArray(p))
						p=[p];
					var $me=this;
					$.each(p,function(i,e){
								if(def){
									$me.attr(e,$(from).attr(e)||def);
								}else
									$me.attr(e,$(from).attr(e));
							});
					return this;
				},
				'_appendTo':function(val){
					// 追加一个组件, 如果val没有定义，则表示undo,有定义，表示redo，
					if(!val){
						// 删除
						this.remove();
					}else{
						initComponent($(this).appendTo($page).select());
					}
					return this;
				},
				'_removeFrom':function(val){
					// 删除一个组件
					if(!val){
						// 增加
						initComponent($(this).appendTo($page).select());
					}else{
						this.remove();
					}
					return this;
				}
			});
	Array.prototype._last=function(val){
		this[this.length-1]=val;
		return this;
	}
	function FileChooser(input,button,filter,changed){
		$(input).keydown(function(e){
					if(e.keyCode==13){
						e.preventDefault();
						changed($(input).val());
					}
				});
		$(button).click(function(){
					var file=j().chooseFile(filter,'',false);
					if(file){
						$(input).val('file:///'+file.replace(/(\\)/g,'/'));
						changed($(input).val());
					}
				})
	}
	// 纸张设置对话框
	function PaperEditor(){
		var me=this;
		this.setPaper=function(){
			if(me.$paperWidth.val()&&me.$paperHeight.val()){
				var portrait=!this.$orientation.is('.jp-landscape-icon'),//
				w=this.$paperWidth.val()+'mm',//
				h=this.$paperHeight.val()+'mm';//
				if(portrait){
					$page.css({
								width:w,
								height:h
							}).removeClass('jp-landscape');
				}else{
					$page.addClass('jp-landscape').css({
								width:h,
								height:w
							})
				}
			}
		}
		this.getDialog=function(){
			if(!this.$dialog){
				this.$dialog=$('#jp-new-local').dialog({
					autoOpen:false,
					width:510,
					buttons:{
						"确定":function(){
							var d=me.oldData;
							undo.open();
							var oldval=d.src,newval=me.$background.attr('src'),fn=['attr',
									'src'];
							undo.add(new $Edit(me.$background,fn,oldval,newval));
							fn=['css'];
							undo.add(new $Edit(me.$background,fn,{
										filter:d.filter,
										opacity:d.opacity
									},{
										filter:me.$background.css('filter'),
										opacity:me.$background.css('opacity')
									}));
							undo.add(new $Edit($page,fn,{
										width:d.portrait?d.width:d.height,
										height:d.portrait?d.height:d.width
									},{
										width:$page._style('width'),
										height:$page._style('height')
									}));
							if(d.portrait&&$page.is('.jp-landscape')){
								undo.add(new $Edit($page,[//
										function(){
													$page.removeClass('jp-landscape')
												},//
												function(){
													$page.addClass('jp-landscape')
												}]));
							}else if(!d.portrait&&!$page.is('.jp-landscape')){
								undo.add(new $Edit($page,[function(){
													$page.addClass('jp-landscape')
												},function(){
													$page.removeClass('jp-landscape')
												}]));
							}
							undo.add(new $Edit($page,fn,{
										width:d.width,
										height:d.height
									},{
										width:$page._style('width'),
										height:$page._style('height')
									}));
							undo.close();
							$(this).dialog("close");
						},
						"取消":function(){
							var oldval=me.oldData;
							me.$background.attr('src',oldval.src).css({
										filter:oldval.filter,
										opacity:oldval.opacity
									});
							$page.css({
										width:oldval.portrait?oldval.width:oldval.height,
										height:oldval.portrait?oldval.height:oldval.width
									});
							if(oldval.portrait){
								$page.removeClass('jp-landscape')
							}else
								$page.addClass('jp-landscape')
							$(this).dialog("close");
						}
					}
				}), //
				this.$background=$('.jp-paper-background',$page), //
				this.$paperWidth=$('#jp-paper-width',this.$dialog), //
				this.$paperHeight=$('#jp-paper-height',this.$dialog), //
				this.$alpha=$('#jp-alpha',this.$dialog), //
				this.$src=$('#jp-image-src',this.$dialog);
				this.$paperSelect=$('#jp-paper-name',this.$dialog).change(function(){
							var size=$(this).val().split(',');
							if(size.length>1){
								me.$paperWidth.val(size[0]);
								me.$paperHeight.val(size[1]);
								me.setPaper();
							}else{
								// 如果是自定义纸张，则选中宽度输入框
								me.$paperWidth.focus(function(){
											var me=this;
											setTimeout(function(){
														me.select();
													},10)
										}).focus();
							}
						}), //
				setAlpha=function(){
					var val=me.$alpha.slider('value');
					if(val>0){
						var opacity=(100-val)/100;
						me.$background.css({
									'filter':'alpha(opacity='+(100-val)+')',
									'opacity':opacity
								});
					}else{
						me.$background.css({
									'filter':'',
									'opacity':''
								});
					}
				};
				this.$paperWidth.add(this.$paperHeight).keydown(function(e){
							if(e.keyCode==13){
								me.setPaper();
							}
						});
				this.$alpha.slider({
							orientation:"horizontal",
							range:"min",
							max:100,
							value:0,
							slide:setAlpha,
							change:setAlpha
						});
				$('.jp-orientation input',this.$dialog).change(function(){
							if($(this).val()=='-'){
								me.$orientation.addClass('jp-landscape-icon');
								if(!$page.is('.jp-landscape')){
									$page.css({
												width:$page._style('height'),
												height:$page._style('width')
											}).addClass('jp-landscape');
								}
							}else{
								me.$orientation.removeClass('jp-landscape-icon');
								if($page.is('.jp-landscape')){
									$page.css({
												width:$page._style('height'),
												height:$page._style('width')
											}).removeClass('jp-landscape');
								}
							}
						});
				this.$orientation=$('.jp-orientation',this.$dialog);
				// 处理图片选择
				var fileChanged=function(file){
					me.$background.attr('src',file||_blank);
				};
				var $src=$('#jp-image-src',this.$dialog);
				var $button=$('#jp-file-chooser',this.$dialog);
				var imagefilter='图片文件 (*.png;*.jpg;*.gif)|*.png;*.jpg;*.gif|所有文件 (*.*)|*.*';
				new FileChooser($src,$button,imagefilter,fileChanged);
			}
			return this.$dialog;
		}
		this.updateUI=function(){
			var portrait=!$page.is('.jp-landscape'),w=$.style($page[0],'width'),h=$
					.style($page[0],'height');
			this.oldData={
				portrait:portrait,//
				width:portrait?w:h,//
				height:portrait?h:w,//
				src:this.$background.attr('src'),//
				filter:this.$background.css('filter')||'',//
				opacity:this.$background.css('opacity')||''
				//
			}
			// 查询当前纸张 select中，有没有相应的纸张大小，如果有，选中，没有创建一个，然后，选中
			var expected=parseInt(this.oldData.width)+','
					+parseInt(this.oldData.height);
			if(!$("option[value='"+expected+"']",this.$paperSelect).length){
				$('<option value="'+expected+'">'+this.oldData.width+'X'
						+this.oldData.height+'</option>').insertBefore($('option',
						this.$paperSelect).last());
			}
			this.$paperSelect.val(expected);
			this.$paperWidth.val(parseInt(this.oldData.width));
			this.$paperHeight.val(parseInt(this.oldData.height));
			var checked=null;
			if(portrait){
				this.$orientation.removeClass('jp-landscape-icon');
				checked='#jp-paper-portrait';
			}else{
				this.$orientation.addClass('jp-landscape-icon');
				checked='#jp-paper-landscape';
			}
			$(checked,this.$dialog)[0].checked=true;
			this.$src.val(this.oldData.src==_blank?'':this.oldData.src);
			this.$alpha.slider('value',100*(1-(this.oldData.opacity||0)));
		}
		this.open=function(){
			var $dialog=this.getDialog();
			this.updateUI();
			$dialog.dialog('open');
		}
	}
	/* 文件，标签双击编辑器 */
	function InplaceEditor(){
		var me=this;
		this.editor=$("<input class='jp-inplace-editor' type='text'></input>");
		this.mousedown=function(e){
			// 如果正在编辑,且不是编辑组件发出的点击，要关闭
			if(me.editor[0]!=e.target){
				me.close();
			}
		};
		this.keydown=function(e){
			if(e.keyCode==13){
				me.close();
			}
		};
		this.close=function(){
			var content=$(this.target).find('.jp-text-content');
			var text=$(this.editor).val();
			if(this.isText&&!text.match(/^[\s]*$/)){
				text='${'+text+'}';
			}
			var oldval=content.text();
			content.text(text);
			var newval=content.text();
			if(newval!=oldval){
				undo.add(new $Edit(content,['text'],oldval,newval));
			}
			$(this.target).removeClass('jp-inplace-editing');
			$(document).unbind('mousedown',this.mousedown);
			this.editor.unbind('keydown',this.keydown).remove();
			this.target=null;
		}
		this.open=function(target){
			this.target=target;
			this.isText=$(target).is('.jp-text');
			$(target).addClass('jp-inplace-editing');
			// this.editor.appendTo(target).cssFrom(target,
			// ['font-size']).val($(target)
			var text=$('.jp-text-content',target).text();
			var expression=text.match(/^\$\{([^}]*)[}]$/);
			if(expression){
				text=expression[1];
			}
			this.editor.appendTo(target).css({
						'font-size':$(target).css('font-size'),
						'font-family':$(target).css('font-family'),
						'text-align':$(target).css('text-align')
					}).val(text).focus();
			$(document).bind('mousedown',this.mousedown);
			this.editor.bind('keydown',this.keydown);
			return null;
		}
	}
	// 条形码编辑器
	function BarcodeEditor(){
		var me=this;
		this.dialogCache={};
		this.bar_1d=['code39','code93','2of5','code128','code128a','code128b',
				'code128c','ean13'];
		this.defaults={
			'bar-1d':{
				'type':'none',
				'rotate':'0',
				'background':null,
				'bar-color':'#000',
				'space-color':null,
				'show-text':'true',
				'text-color':'#000',
				'font-size':'11',
				'font-name':'Arial',
				'autofit':'false'
			},
			'pdf417':{
				'type':'none',
				'err-level':'',
				'data-rows':'',
				'data-cols':'',
				'background':null,
				'bar-color':'#000',
				'space-color':null
			},
			'qr':{
				'type':'none',
				'version':'',
				'background':null,
				'bar-color':'#000',
				'space-color':null
			},
			'datamatrix':{
				'type':'none',
				'mod-height':'',
				'mod-width':'',
				'background':null,
				'bar-color':'#000',
				'space-color':null
			}
		};
		this.getGroup=function(t){
			return $.inArray(t,this.bar_1d)>-1?'bar-1d':t;
		}, //
		this.close=function(){
		}, //
		this.parseData=function(target){
			var data=$(target).data('jp-barcode-data');
			if(!data){
				var data={};
				var styles=$(target)._object().attr('_codestyle').split(';');
				for(var i=0;i<styles.length;i++){
					var style=styles[i].split(':');
					// 只有在默认属性中的数据，才行
					// if(this.defaults[style[0]]!=undefined){
					data[style[0]]=style[1];
					// }
				}
				data=$.extend({},this.defaults[this.getGroup(data.type)],data);
				$(target).data('jp-code-data',data)
			}
			return data;
		}, // 
		this.apply=function(target,data){
			var styles=[],defaults=this.defaults[this.getGroup(data.type)];
			for(p in data){
				var v=data[p];
				if(v!=defaults[p]&&v){
					styles.push(p+':'+v);
				}
			}
			$embed=$(target)._object().attr('_codestyle',styles.join(';'));
			// if(typeof $embed[0].refresh!='undefined')
			!$.browser.msie&&$embed[0].refresh();
		}, this.updateUI=function(data){
			if(!this.updating){
				this.updating=true;
				this.$dialog.find('.jp-code-ui').each(function(){
					var name=$(this).attr('name');
					if($(this).is('.jp-color-chooser')){
						$(this).spectrum('set',data[name]||'rgba(255, 255, 255,0)');
					}else if($(this).is(':radio')
							&&(this.id==='jp-'+$(this).attr('name')+'-'+data[name])){
						this.checked=true;
					}else if($(this).is(':checkbox')){
						this.checked=data[name]===$(this).val();
					}else if(this.id=='jp-qr-version'||this.id=='jp-qr-version-2'){
						$(this).val('');
						var index=$(this).is('#jp-qr-version')?0:1;
						if(data.version){
							var ver=data.version.split('-')[index].toLowerCase();
							$(this).val(ver=='auto'?'':ver);
						}
					}else if(name=='moudles'){
						if(data['mod-height'])
							$(this).val(data['mod-height']+'x'+data['mod-width']);
						else
							$(this).val('');
					}else if($(this).is('select')&&data[name]){
						$(this).val(data[name]);
					}
				})
				this.updating=false;
			}
		}, //
		this.updateData=function(){
			var data=$.extend({},this.$target.data('jp-code-data'));
			this.$dialog.find('.jp-code-ui').each(function(){
				var name=$(this).attr('name');
				if($(this).is('.jp-color-chooser')){
					data[name]=$(this).val()=='transparent'?null:$(this).val();
				}else if($(this).is(':radio')&&this.checked){
					data[name]=$(this).val();
				}else if($(this).is(':checkbox')){
					data[name]=this.checked+'';
				}else if($(this).is('select.qr-version')){
					var val=($('#jp-qr-version',this.$dialog).val()||'auto')+'-'
							+($('#jp-qr-version-2',this.$dialog).val()||'auto');
					if(val=='auto-auto')
						val='';
					data['version']=val;
				}else if(name=='moudles'){
					var modules=$(this).val().split('x');
					data['mod-height']=modules.length?modules[0]:'';
					data['mod-width']=modules.length?modules[1]:'';
				}else if($(this).is('select')){
					data[name]=$(this).val();
				}
			});
			// ////////////////////////////////
			// data['rotate']=this.$dialog.find('#_rotate').slider('value');
			this.$target.data('jp-code-data',data)
			return data;
		}, //		
		this.getDialog=function(bartype){
			var g=this.getGroup(bartype),me=this;
			if(!this.dialogCache[g]){
				var dialog=$('#jp-'+g+'-editor');
				makeColorChooser($('.jp-color-chooser',dialog));
				setFonts($('#jp-font-name',this.$dialog));
				$('.jp-code-ui',dialog).change(function(e){
							if(!me.updating){
								me.apply(me.$target,me.updateData());
							}
						});
				$('#jp-show-text',dialog).change(function(){
					$(this).closest('p').nextAll().css('display',
							this.checked?'block':'none');
				});
				this.dialogCache[g]=dialog;
			}
			return this.dialogCache[g];
		}, //
		this.open=function(target){
			var me=this;
			this.$target=$(target);
			this.$dialog&&this.$dialog.dialog('close');
			this.oldval=$(target)._object().attr('_codestyle');
			var data=this.parseData(target);
			this.$dialog=this.getDialog(data.type);
			this.updateUI(data);
			if($('#jp-show-text',this.$dialog).length)
				$('#jp-show-text',this.$dialog).closest('p').nextAll().css('display',
						$('#jp-show-text',this.$dialog)[0].checked?'block':'none');
			this.$dialog.dialog({
						width:420,
						buttons:{
							'确定':function(){
								var newval=me.$target._object().attr('_codestyle'),fn=['attr',
										'_codestyle'];
								undo.add(new $Edit(me.$target._object(),fn,me.oldval,newval));
								$(this).dialog("close");
							},
							'取消':function(){
								me.$target._object().attr('_codestyle',me.oldval);
								$(this).dialog("close");
							}
						}
					});
			return this.$dialog;
		}
	}
	// 图片插入编辑器
	function ImageEditor(){
		var me=this;
		this.close=function(){
		}, //
		this.open=function(target){
			this.$target=$(target);
			if(!this.$dialog){
				this.$dialog=$('#jp-image-chooser').dialog({
					width:510,
					autoOpen:false,
					buttons:{
						'确定':function(){
							var $img=$('.jp-image-view',me.$target);
							undo.open();
							undo.add(new $Edit($img,['attr','src'],me.lastVal.src,$img
											.attr('src')));
							var stretched=$img.is('.jp-auto-stretch');
							if(stretched!==me.lastVal.stretched){
								if(stretched)
									undo.add(new $Edit($img,[//
											function(){
														this.target.removeClass('jp-auto-stretch')
													},//
													function(){
														this.target.addClass('jp-auto-stretch')
													}]));
								else
									undo.add(new $Edit($img,[//
											function(){
														this.target.addClass('jp-auto-stretch')
													},//
													function(){
														this.target.removeClass('jp-auto-stretch')
													}]));
							}
							undo.close();
							$(this).dialog("close");
						},
						'取消':function(){
							if(me.lastVal.stretched)
								$('.jp-image-view',me.$target).addClass('jp-auto-stretch');
							else
								$('.jp-image-view',me.$target).removeClass('jp-auto-stretch');
							$('.jp-image-view',me.$target).attr('src',me.lastVal.src);
							$(this).dialog("close");
						}
					}
				});
				var changed=function(){
					$('.jp-image-view',me.$target).attr('src',$src.val()||_blank);
					if($autoSize[0].checked){
						$('.jp-image-view',me.$target).removeClass('jp-auto-stretch');
					}else{
						$('.jp-image-view',me.$target).addClass('jp-auto-stretch');
					}
				}
				var $src=$('#jp-image-src',this.$dialog);
				var $button=$('#jp-file-chooser',this.$dialog);
				var imagefilter='图片文件 (*.png;*.jpg;*.gif)|*.png;*.jpg;*.gif|所有文件 (*.*)|*.*';
				new FileChooser($src,$button,imagefilter,changed);
				// 处理自动缩放设置
				var $autoSize=$('#jp-original-size',this.$dialog).change(changed);
			}
			var src=$('.jp-image-view',this.$target).attr('src')||'';
			$('#jp-image-src',this.$dialog).val(src==_blank?'':src);
			var stretched=$('.jp-image-view',this.$target).is('.jp-auto-stretch');
			$('#jp-original-size',this.$dialog)[0].checked=!stretched;
			this.lastVal={
				src:src,
				stretched:stretched
			};
			return this.$dialog.dialog('open');
		}
	}
	// 代码打开，保存工具
	function SourceCodeUtil(){
		this.decode=function($p){
			var me=this;
			// 清除原来的组件
			$('.jp-component',$page).remove();
			// undo要清掉
			undo.clear();
			var w=$p._style('width'),h=$p._style('height');
			// 修改jp-page的高度，宽度，方向，
			w&&$page.css('width',w);
			h&&$page.css('height',h);
			$page._copyClass($p,'jp-landscape');
			$page.find('.jp-paper-background').attr('src',_blank);
			$p.children().each(function(i){
				for(e in me.decoders){
					if($(this).is(e)){
						var newcomp=me.decoders[e].call(me,$(this),i);
						if(newcomp){
							initComponent(newcomp.appendTo($page)._copyCss($(this),
											['left','top','width','height']),true);
							var border=$(this)._border();
							if(border){
								$(newcomp).css(border);
							}
						}
						return;
					}
				}
			})
		}, //
		// 打开文件
		this.decoders={
			'.jp-paper-background':function($target,id){
				// 底图，透明度
				$('.jp-paper-background',$page)._copyAttr($target,'src',_blank)
						._copyCss($target,['filter','opacity']);
			},
			'.jp-label':function($target,id){
				// newLabel:"<div class='jp-label jp-component'><span
				// class='jp-text-content'></span><p
				// class='jp-selected-layer'></p></div>",
				// 创建一个新对象
				var $label=$(handlers.newLabel);
				$('.jp-text-content',$label).text($target.text());
				return $label._copyCss($target,['font-family','font-weight',
								'font-style','text-decoration','font-size','color',
								'background-color','text-align','z-index']);
			},
			'.jp-text':function($target,id){
				var $text=$(handlers.newText);
				$('.jp-text-content',$text).text($target.text());
				return $text._copyCss($target,['font-family','font-weight',
								'font-style','text-decoration','font-size','color',
								'background-color','text-align','z-index']);
			},
			'.jp-barcode':function($target,id){
				var $barcode=$(handlers.newBarcode);
				$barcode._object()._copyAttr($target._object(),['_code','_codestyle']);
				return $barcode._copyCss($target,['background-color','z-index']);
			},
			'.jp-image':function($target,id){
				var $image=$(handlers.newImage),$srcimg=$target.find('img'),$newimg=$image
						.find('img')._copyAttr($srcimg,'src',_blank)._copyClass($srcimg,
								'jp-auto-stretch');
				return $image._copyCss($target,['background-color','z-index']);
			}
		}, //
		this.encoders={
			'.jp-paper-background':function($target,id){
				if($target.attr('src')==_blank)
					return null;
				else
					return {
						style:$target.attr('style'),
						comp:$('<img class="jp-paper-background screen-only">').attr('src',
								$target.attr('src'))
					};
			},
			'.jp-label':function($target,id){
				var text=$('.jp-text-content',$target).text();
				return {
					style:$target.attr('style'),
					comp:$('<div class="jp-label jp-comp-'+id+'">').text(text)
				};
			},
			'.jp-text':function($target,id){
				var text=$('.jp-text-content',$target).text();
				return {
					style:$target.attr('style'),
					comp:$('<div class="jp-text jp-comp-'+id+'">').text(text)
				};
			},
			'.jp-barcode':function($target,id,cross){
				var ax=$('<object classid="CLSID:E5A01FF5-FC6E-42F3-AF48-DEA5777DED62" '
						+'data="data:application/x-oleobject;base64,9R+g5W7880KvSN6ld33tYgADAADALAAAWh0AAA==" '
						+'><embed type="application/x-vnd.jatoolsCoder"></embed></object>')
						._copyAttr($('object,embed',$target).first(),['_code','_codestyle']);
				ax.find('embed')._copyAttr(ax,['_code','_codestyle']);
				if(!cross){
					ax.find('embed').remove();
				}
				return {
					style:$target.attr('style'),
					comp:$('<div class="jp-barcode jp-comp-'+id+'">').append(ax)
				};
			},
			'.jp-image':function($target,id){
				var $srcImg=$('img',$target);
				var $newImg=$($srcImg[0].cloneNode());
				if($newImg.attr('src')==_blank)
					$newImg.attr('src','');
				return {
					style:$target.attr('style'),
					comp:$('<div class="jp-image jp-comp-'+id+'">').append($newImg)
				};
			}
		}, //
		this.headObject=function(){
			return '<OBJECT ID="jatoolsPrinter" CLASSID="CLSID:B43D3361-D075-4BE2-87FE-057188254255" codebase="jatoolsPrinter.cab#version=5,7,0,0"></OBJECT>';
		}
		this.bodyObject=function(){
			return [
					'<object id="ojatoolsPrinter" codebase="jatoolsPrinter.cab#version=5,4,0,0"',
					'	classid="clsid:B43D3361-D075-4BE2-87FE-057188254255" width="0" height="0">',
					'	<embed id="ejatoolsPrinter" type="application/x-vnd.jatoolsPrinter" width="0" height="0"></embed>',
					'</object>'].join('\n');
		}
		this.debugButtons=function(cross){
			return [
					'<div>',
					'<input type="button" value="打印预览..." onClick="doPrint(\'打印预览...\')">',//
					'<input type="button" value="打印..." onClick="doPrint(\'打印...\')">',//
					'<input type="button" value="打印" onClick="doPrint(\'打印\')">',//
					'<span style="font-size:12px;color:gray;margin-left:20px;">'
							+(cross
									?'本网页代码可以在IE,Firefox,Chrome,Safari 上打印.'
									:'本网页代码只可以在IE上打印噢.')+'</span>',//					
					'</div>'].join('\n')
		}, //
		this.debugScript=function(crossbrowser){
			var myDoc=getMyDoc();
			return ["<script>",
					"function doPrint(how){",//
					"	var myDoc={",//
					"		settings:{",//
					"			paperWidth:"+myDoc.settings.paperWidth+",",//
					"			paperHeight:"+myDoc.settings.paperHeight+",",//
					"			orientation:"+myDoc.settings.orientation,//
					"		},",//
					"		marginIgnored:true,",//
					"		enableScreenOnlyClass:true,",//
					"		documents:document,",//
					"		copyrights:'杰创软件拥有版权  www.jatools.com'",//
					"	};",//
					crossbrowser
							?"	var jatoolsPrinter = navigator.userAgent.indexOf('MSIE') > -1 ? "
									+"document.getElementById('ojatoolsPrinter'): document.getElementById('ejatoolsPrinter');"
							:'',"	if(how=='打印预览...')",//
					"		jatoolsPrinter.printPreview(myDoc);",//
					"	else if(how=='打印...')",//
					"		jatoolsPrinter.print(myDoc,true);",//
					"	else",//
					"		jatoolsPrinter.print(myDoc,false);",//
					"}",//	
					"</script>"//		
			].join('\n');
		}
		this.encode=function(debug,crossbrowser){
			var me=this;
			var _page=$('<div id="page1" class="jp-page">').css({
						width:$page._style('width'),
						height:$page._style('height')
					})._copyClass($page,'jp-landscape');//
			var index=0;
			var css=[];
			$page.children().each(function(){
						for(e in me.encoders){
							if($(this).is(e)){
								var encoded=me.encoders[e].call(me,$(this),index,crossbrowser);
								if(encoded){
									_page.append(encoded.comp);
									if(encoded.style){
										css.push('.jp-comp-'+index+'{'+encoded.style+'}');
									}
									index++;
								}
							}
						}
					})
			return [
					// '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
					// "http://www.w3.org/TR/html4/loose.dtd">',//
					'<html>',//
					'<head>',//
					'<title>jatoolsPrinter打印</title>',//
					'<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">',//
					crossbrowser?'':this.headObject(),
					'<style>',
					'.jp-page{position:relative}',
					'.jp-text,.jp-label,.jp-image,.jp-barcode{position:absolute;overflow:hidden}',//
					'.jp-auto-stretch,.jp-barcode object,.jp-barcode embed{width: 100%; height: 100%;}',//
					'.jp-paper-background{position:absolute;width:100%;height:100%;}',//
					rgb2hex(css.join('\n')),//
					'</style>',//
					debug?this.debugScript(crossbrowser):'',
					'</head>',//
					'<body>',//
					debug?this.debugButtons(crossbrowser):'',
					_page.appendTo(document.body)._outerHTML(),//
					(crossbrowser&&debug)?this.bodyObject():'','</body>',//
					'</html>']//
					.join('\n');
		}
	};
	// 代码查看对话框
	function SourceCodeViewer(){
		var me=this;
		this.util=new SourceCodeUtil();
		this.close=function(){
		}, //
		this.setCode=function(debug,cross){
			var brush=new SyntaxHighlighter.HtmlScript('js');
			brush.init({
						toolbar:false,
						'brush':'htmlscript'
					});
			cleanHTML(this.util.encode(debug,cross),function(code){
						$('#jp-plain-code',me.$dialog).val(code);
						code=brush.getHtml(code.replace(/</g,"&lt;").replace(/>/g,"&gt;"));
						// 将表达式格式化
						code=code.replace(/([$][{][^}]*[}])/gm,
								"<span class='jp-expression'>$1</span>");
						$('#jp-code',me.$dialog).html(code);
						me.$dialog.dialog('open').find('.syntaxhighlighter').scrollLeft(0);
					});
		}//
		this.open=function(){
			if(!this.$dialog){
				this.$dialog=$('#jp-source-code-viewer').dialog({
							width:610,
							autoOpen:false
						});
				$('#jp-copy-code',this.$dialog).click(function(){
							copy($('#jp-plain-code',me.$dialog).val());
						});
				$('#jp-save-code',this.$dialog).click(function(){
							savefile($('#jp-plain-code',me.$dialog).val());
						});
				$('input:checkbox',this.$dialog).change(function(){
							var debug=$('#jp-debug-code',me.$dialog)[0].checked;
							var cross=$('#jp-cross-browser',me.$dialog)[0].checked;
							me.setCode(debug,cross);
						});
			}
			// html-script : [$][{][^}]*[}]
			// var sh = new SyntaxHighlighter();
			var debug=$('#jp-debug-code',this.$dialog)[0].checked;
			var cross=$('#jp-cross-browser',this.$dialog)[0].checked;
			this.setCode(debug,cross);
			return this.$dialog;
		}
	}
	var $page=$('.jp-page');
	var _textEditor=new InplaceEditor();
	var _barcodeEditor=new BarcodeEditor();
	function endCreateClick(e){
		// 如果是生成按钮，忽略
		// 如果
		if($created
				&&$(e.target).closest('.jp-page').add($(e.target)
						.closest('a.jp-creating')).length==0){
			endCreate();
		}
	};
	function getMyDoc(){
		var myDoc={
			settings:{},
			marginIgnored:true,
			enableScreenOnlyClass:true,
			logPage:true,
			copyrights:'杰创软件拥有版权  www.jatools.com'
		};
		var settings=myDoc.settings;
		var portrait=!$page.is('.jp-landscape'),//
		w=$.style($page[0],'width'),//
		h=$.style($page[0],'height'),//
		paperWidth=portrait?w:h,//
		paperHeight=portrait?h:w//
		/*
		 * // 查询当前纸张 select中，有没有相应的纸张大小，如果有，选中，没有创建一个，然后，选中
		 * ,expected=parseInt(paperWidth)+','+parseInt(paperHeight),paperName=$("#jp-paper-name
		 * option[value='" +expected+"']").text() ||'';
		 * if(paperName.match(/^[ab][1-6]$/i)){ settings.paperName=paperName; }else{
		 */
		settings.paperWidth=parseInt(paperWidth)*10;
		settings.paperHeight=parseInt(paperHeight)*10;
		// }
		settings.orientation=portrait?1:2;
		return myDoc;
	}
	function startCreate($button){
		$created&&endCreate();
		$button.closest('a').add($(document.body)).addClass('jp-creating');
		$(document).one('mousedown',endCreateClick);
		$('.ui-draggable',$page).each(function(){
					$(this).data('draggable').options.disabled=true;
				})
	}
	function endCreate(){
		$created=null;
		$('.ui-draggable',$page).each(function(){
					$(this).data('draggable').options.disabled=false;
				})
		$('.jp-creating').removeClass('jp-creating');
		$(document).unbind('mousedown',endCreateClick)
	}
	function setBorder(target,newval){
		var fn=['borderStyle'],oldval=[];
		target.vals(fn,oldval).borderStyle(newval);
		undo.add(new $Edit(target,fn,oldval,newval));
		return target;
	}
	var handlers={
		'copied-flag':'jp-component-copied:',
		'copied-flag-test':/^jp\-component\-copied\:/,
		paperEditor:new PaperEditor(),
		sourceCodeViewer:new SourceCodeViewer(),
		newLabel:"<div class='jp-label jp-component'><span class='jp-text-content'></span><p class='jp-selected-layer'></p></div>",
		newText:"<div class='jp-text jp-component'><span class='jp-text-content'></span><p class='jp-selected-layer'></p></div>",
		newBarcode:'<div class="jp-barcode jp-component" style2="background-color:black;" >'
				+(($.browser.msie)
						?('<OBJECT windowless="true" type="application/x-vnd.jatoolsCoder" '
								+'classid=CLSID:E5A01FF5-FC6E-42F3-AF48-DEA5777DED62 '
								+'data="data:application/x-oleobject;base64,9R+g5W7880KvSN6ld33tYgADAABvDQAARAgAAA==" _code="6938012345670">'+'</OBJECT>')
						:('<embed style2="background-color:black;" type="application/x-vnd.jatoolsCoder"  windowless="true"></embed>'))
				+'<p class="jp-selected-layer"></p></div>',
		newImage:"<div class='jp-image jp-component'><img class='jp-image-view' src='"
				+_blank+"'></img><p class='jp-selected-layer'></p></div>",
		'jp-new':function(){
			this.paperEditor.open();
		},
		'jp-open':function(){
			openfile();
		},
		'jp-save':function(){
			this.sourceCodeViewer.open();
		},
		'jp-print':function(){
			var $loader=$('#jp-for-print',document.body);
			if(!$loader.length)
				$loader=$('<iframe id="jp-for-print" class="jp-html-loader"><iframe>');
			$(document.body).append($loader);
			var doc=$loader.contents()[0];
			doc.open();
			doc.writeln(handlers.sourceCodeViewer.util.encode(false,!$.browser.msie));
			doc.close();
			var myDoc=getMyDoc();
			myDoc.documents=doc;
			j().printPreview(myDoc);
		},
		'jp-undo':function(){
			undo.undo();
		},
		'jp-redo':function(){
			undo.redo();
		},
		'jp-delete':function(e){
			// 注册undo
			undo.add(new $Edit($s(),['_removeFrom'],null,$page));
			$s().remove();
		},
		'jp-copy':function(e){
			var copyed=$s().clone();
			copyed.find('.ui-resizable-handle').remove();
			copy(this['copied-flag']+$('<div>').append(copyed)._outerHTML());
		},
		'jp-cut':function(e){
			undo.add(new $Edit($s(),['_removeFrom'],null,$page));
			this['jp-copy'].call(this);
			$s().remove();
		},
		'jp-paste':function(e){
			var _copied=copied()||'';
			if(_copied.match(this['copied-flag-test'])){
				$s().unselect();
				var pasted=$(_copied.substring(this['copied-flag'].length)).children()
						.each(function(i,c){
							if($(this).is('.jp-barcode')){
								var $replaced=$(this)._object();
								if(($.browser.msie&&$replaced.is('embed'))
										||((!$.browser.msie)&&$replaced.is('object'))){
									var $with=$(handlers.newBarcode)._object()._copyAttr(
											$replaced,['_code','_codestyle']);
									$(this).append($with);
									$replaced.remove();
								}
							}
						});
				pasted=initComponent(pasted.appendTo($page).animate({
							left:'+=5',
							top:'+=5'
						},0).select());
				undo.add(new $Edit(pasted,['_appendTo'],null,$page));
			}
		},
		'jp-font':function(e){
			$s()._css('font-family',$(e.target).val());
		},
		'jp-bold':function(e){
			var fontWeight=$(e.target)[0].checked?'700':'normal';
			$s()._css('font-weight',fontWeight);
		},
		'jp-italic':function(e){
			var fontStyle=$(e.target)[0].checked?'italic':'normal';
			$s()._css('font-style',fontStyle);
		},
		'jp-color':function(e){
		},
		'jp-background':function(e){
		},
		'jp-underline':function(e){
			var fontDecoration=$(e.target)[0].checked?'underline':'none';
			$s()._css('text-decoration',fontDecoration);
		},
		'jp-align-left':function(e){
			$s()._css('text-align',$(e.target).val());
		},
		'jp-align-center':function(e){
			$s()._css('text-align',$(e.target).val());
		},
		'jp-align-right':function(e){
			$s()._css('text-align',$(e.target).val());
		},
		'jp-new-label':function(e){
			startCreate($(e.target));
			$created=$(this.newLabel);
		},
		'jp-new-text':function(e){
			startCreate($(e.target));
			$created=$(this.newText);
		},
		'jp-new-barcode':function(e){
			var codetype=$(e.target).attr('code-type');
			startCreate($(e.target));
			$created=$(this.newBarcode);
			$created._object().attr({
						'_code':codetype=='2of5'?'1234567':'6938012345670',
						'_codestyle':'type:'+codetype+';autofit:true'
					});
		},
		'jp-new-image':function(e){
			startCreate($(e.target));
			$created=$(this.newImage);
		},
		'jp-font-size':function(down){
			var oldval=[],newval=[],fn=['css','font-size'];
			var dt=down?-2:2;
			$s().vals(fn,oldval).each(function(){
						var fontsize=(parseInt($(this).css('font-size'))+dt)+'px';
						$(this).css({
									'font-size':fontsize
								});
					}).vals(fn,newval);
			undo.add(new $Edit($s(),fn,oldval,newval));
		},
		'jp-size-up':function(e){
			this['jp-font-size'].call(this,false);
		},
		'jp-size-down':function(e){
			this['jp-font-size'].call(this,true);
		},
		'jp-front':function(e){
			if($s().length==1){
				var target=$s()[0],zindexs=[],zmap={};
				$('.jp-component',$page).each(function(e){
							var zindex=$(this).css('z-index');
							zindexs.push(zindex);
							zmap[zindex]=this;
						}).each(function(){
							if(target==this){
								zindexs.sort();
								var zindex=$(this).css('z-index');
								var i=$.inArray(zindex,zindexs);
								if(i<zindexs.length-1){
									var nextzindex=zindexs[i+1];
									var nexttarget=zmap[nextzindex];
									undo.open();
									$(target)._css('z-index',nextzindex);
									$(nexttarget)._css('z-index',zindex);
									undo.close();
								}
							}
						});
			}
		},
		'jp-back':function(e){
			if($s().length==1){
				var target=$s()[0],zindexs=[],zmap={};
				$('.jp-component',$page).each(function(e){
							var zindex=$(this).css('z-index');
							zindexs.push(zindex);
							zmap[zindex]=this;
						}).each(function(){
							if(target==this){
								zindexs.sort();
								var zindex=$(this).css('z-index');
								var i=$.inArray(zindex,zindexs);
								if(i>0){
									var nextzindex=zindexs[i-1];
									var nexttarget=zmap[nextzindex];
									undo.open();
									$(target)._css('z-index',nextzindex);
									$(nexttarget)._css('z-index',zindex);
									undo.close();
								}
							}
						});
			}
		},
		'jp-top':function(e){
			if($s().length==1){
				var target=$s()[0],zindexs=[],zmap={};
				$('.jp-component',$page).vals(['css','z-index'],zindexs);
				$(target)._css('z-index',Math.max.apply(null,zindexs)+1);
			}
		},
		'jp-bottom':function(e){
			if($s().length==1){
				var target=$s()[0],zindexs=[],zmap={};
				$('.jp-component',$page).vals(['css','z-index'],zindexs);
				$(target)._css('z-index',Math.min.apply(null,zindexs)-1);
			}
		},
		'jp-border-1px':function(e){
			setBorder($s(),{
						border:'solid 1px black'
					});
		},
		'jp-border-no':function(e){
			setBorder($s(),{
						border:''
					});
		},
		'jp-border-custom':function(e){
			if($s().length){
				var $d=$("#jp-border-chooser"),$selected=$s();
				if(!$d.is('.ui-dialog-content')){
					var $viewer=$('#jp-border-viewer',$d),$line=$('#jp-line-viewer',$d),borderhandlers={
						'jp-border-none':function(){
							$viewer.css('border','');
						},
						'jp-border-all':function(){
							$viewer.css('border',$line._border()['border-top']);
						},
						'jp-border-left':function(){
							$viewer.css('border-left',$line._border()['border-top']);
						},
						'jp-border-top':function(){
							$viewer.css('border-top',$line._border()['border-top']);
						},
						'jp-border-right':function(){
							$viewer.css('border-right',$line._border()['border-top']);
						},
						'jp-border-bottom':function(){
							$viewer.css('border-bottom',$line._border()['border-top']);
						},
						'jp-border-style-1px':function(){
							$line.css('border-top-width','1px');
						},
						'jp-border-style-2px':function(){
							$line.css('border-top-width','2px');
						},
						'jp-border-style-3px':function(){
							$line.css('border-top-width','3px');
						},
						'jp-border-style-4px':function(){
							$line.css('border-top-width','4px');
						},
						'jp-border-style-5px':function(){
							$line.css('border-top-width','5px');
						},
						'jp-border-style-6px':function(){
							$line.css('border-top-width','6px');
						},
						'jp-border-style-solid':function(){
							$line.css('border-top-style','solid');
						},
						'jp-border-style-dashed':function(){
							$line.css('border-top-style','dashed');
						},
						'jp-border-style-dotted':function(){
							$line.css('border-top-style','dotted');
						}
					}
					$d.dialog({
								autoOpen:false,
								width:425,
								height:390,
								buttons:{
									"确定":function(){
										var newval=$viewer._border();
										// //console.log(newval);
										setBorder($s(),newval);
										$(this).dialog("close");
									},
									"取消":function(){
										$(this).dialog("close");
									}
								}
							});
					$('.jp-border-previewer',$d).click(function(e){
						$.each(['.border-top','.border-right','.border-bottom',
										'.border-left'],function(i,el){
									if($(e.target).is(el)){
										var style=el.substring(1);
										old=$.style($viewer[0],style)||$.style($viewer[0],'border');
										$viewer.css(style,old?'':$.style($line[0],'border-top'));
									}
								})
					});
					$('.jp-border-command a').click(function(e){
								var id=$(this)[0].id;
								borderhandlers[id]&&borderhandlers[id]();
							});
					makeColorChooser($('#jp-border-color',$d),null,function(color){
								$line.css('border-top-color',color.toHexString());
							});
				}
				var lineviewer=$('#jp-line-viewer',$d),//
				borders=$('#jp-temp',$d).borderStyle($s().first().borderStyle())
						._border(),//
				firstBorder=null;
				for(p in borders){
					if(!borders[p].match(/^none.*/)){
						firstBorder=borders[p];
						break;
					}
				}
				lineviewer.css('border-top',firstBorder||'solid 1px black');
				var b=$('#jp-border-viewer',$d).borderStyle($s().first().borderStyle());
				$('#jp-border-viewer',$d).borderStyle($s().first().borderStyle());
				$d.dialog("open");
			}
		}
	}
	function setFonts(target){
		try{
			var fonts=j().getFonts();
			if(fonts){
				var fontSelect=$(target)[0];
				for(var i=0;i<fonts.length;i++){
					fontSelect.options[i]=new Option(fonts[i],fonts[i]);
				}
			};
		}catch(e){
		}
	}
	setTimeout(function(){
				setFonts($('#jp-font-chooser').change(handlers['jp-font']))
			},1000);
	var hotkeys={
		'ctrl+c':'jp-copy',
		'ctrl+x':'jp-cut',
		'ctrl+v':'jp-paste',
		'ctrl+z':'jp-undo',
		'ctrl+y':'jp-redo',
		'ctrl+]':'jp-size-up',
		'ctrl+[':'jp-size-down',
		'ctrl+PgUp':'jp-front',
		'ctrl+PgDn':'jp-back',
		'ctrl+End':'jp-bottom',
		'ctrl+Home':'jp-top',
		'46':'jp-delete'
	};
	var ctrlkeys={//
		'33':'PgUp',// page up
		'34':'PgDn',// page down
		'35':'End',// end
		'36':'Home',// home
		'219':'[',
		'221':']'
		// }
	}
	$(document).keydown(function(e){
		// 如果正在输入控件<input>按键，则设计面板快捷键不可用
		if(!$(e.target).is('input')){
			var key=null;
			if(e.ctrlKey){
				key='ctrl+'
						+(ctrlkeys[e.keyCode+'']||String.fromCharCode(e.keyCode)
								.toLowerCase());
			}else if(e.keyCode==46/* del */){
				key=e.keyCode+'';
			}
			if(key&&hotkeys[key]){
				key=hotkeys[key];
				handlers[key]&&handlers[key].call(handlers);
				e.preventDefault();
				return false;
			}
		}
	});
	var showingColorChooser=null;
	function makeColorChooser(target,extraOptions,callback){
		$(target).each(function(e){
			var me=this;
			var options={
				showInitial:true,
				showPalette:true,
				showSelectionPalette:true,
				maxPaletteSize:10,
				preferredFormat:"hex",
				cancelText:"取消",
				chooseText:"确定",
				localStorageKey:"spectrum.demo",
				palette:[
						["rgba(255, 255, 255,0)","rgb(0, 0, 0)","rgb(67, 67, 67)",
								"rgb(102, 102, 102)","rgb(255, 255, 255)"].slice($(this)
								.is('.jp-with-transparent')?0:1),
						["rgb(152, 0, 0)","rgb(255, 0, 0)","rgb(255, 153, 0)",
								"rgb(255, 255, 0)","rgb(0, 255, 0)","rgb(0, 255, 255)",
								"rgb(74, 134, 232)","rgb(0, 0, 255)","rgb(153, 0, 255)",
								"rgb(255, 0, 255)"]],
				change:function(color,opts){
					callback&&callback(color,opts);
				},
				show:function(){
					showingColorChooser=me;
				},
				hide:function(){
					showingColorChooser=null;
				}
			};
			extraOptions&&(options=$.extend(extraOptions,options));
			$(this).spectrum(options);
		});
	}
	var colorChanged=function(color,opts){
		$s()._css(opts.style,color.alpha?color.toHexString():'transparent');
	}
	function hex(x){
		return ("0"+parseInt(x).toString(16)).slice(-2);
	}
	function rgb2hex(code){
		return code.replace(/rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/g,function(
						matched,r,g,b){
					return "#"+hex(r)+hex(g)+hex(b);
				})
	}
	makeColorChooser($('#jp-color'),{
				style:'color'
			},colorChanged);
	makeColorChooser($('#jp-background'),{
				style:'background-color'
			},colorChanged);
	$.ui.plugin.add("resizable","rulerSet",{
				resize:function(event,ui){
					var $this=$(ui.helper),that=$this.data("resizable"),cs=that.size;
					var old=$this.data('oldVals');
					cs.width+=old.dx;
					cs.height+=old.dy;
					var connectors=$this.data('connectors').slice(0);
					connectors[1]=connectors[0]+Math.round(cs.width/2);
					connectors[2]=connectors[0]+cs.width;
					connectors[4]=connectors[3]+Math.round(cs.height/2);
					connectors[5]=connectors[3]+cs.height;
					siblingConnectors=$this.data('sibling-connectors');
					var doSet=function(c1,// 拖动组件
							expected,// 理想的位置
							baseIndex,// 位置起始处,0/3=横对齐/纵对齐
							thisIndex// 正在对拖动组件哪一边对齐,左中右上中下=012345
					){
						// 如果是下边、右边,则高宽度就是理想位置减上，下边位置，否则加倍
						var n=(thisIndex-baseIndex)==2?1:2;
						that.size[baseIndex?'height':'width']=(expected-c1[baseIndex])*n
								-(baseIndex?old.dy:old.dx);
					}
					var rulers=rulerSet(connectors,siblingConnectors,
							[2,1]/* 只对右中边进行对齐 */,[5,4]/* 只对下中边,进行对齐 */,doSet);
					$this.data('rulers',rulers);
				}
			});
	var getPositions=function(target){
		var p2=$(target).offset(),w=$(target).outerWidth(),h=$(target)
				.outerHeight();
		// 计算每个物件的9个点,可以用6个值得到
		// [左,中,右,上,中,下,宽,高]
		return [p2.left, //
				p2.left+Math.round(w/2), //
				p2.left+w, //
				p2.top,//
				p2.top+Math.round(h/2),//
				p2.top+h,w,h,$(target)];
	}
	var getConnectorPositions=function(target){
		var siblingConnectors=[];
		// 计算各连接点
		// $('.jp-connector').remove();
		$(".ui-draggable",$page).each(function(){
			var p2=$(this).offset();
			// 计算每个物件的9个点,可以用6个值得到
			// [x1,x2,x3,y1,y2,y3]
			var connectors=$(this).data('connectors');
			if(true||!connectors){
				// [左,中,右,上,中,下,宽,高]
				connectors=getPositions(this);
				// //console.log(connectors);
				$(this).data('connectors',connectors);
			}
			var connector=$(this).data('connector');
			if(!connector){
				connector=$('<p class="jp-connector jp-ruler-element"></p>')
						.appendTo($(target).parent());
				$(this).data('connector',connector);
				// 被拖动组件,有可能有两个对齐点
				$(this).data(
						'connector2',
						$('<p class="jp-connector jp-ruler-element"></p>')
								.appendTo($(target).parent()));
			}
			connector.offset({
						left:connectors[1]-3,
						top:connectors[4]-3
					});
			if(this!=target)
				siblingConnectors.push(connectors);
			else
				$(target).data('sibling-connectors',siblingConnectors);
		});
	}
	var renderRulers=function(target,rulers){
		var connectors=getPositions(target);
		$.each(rulers,function(i){
					var x1=connectors[this.from[1]];
					var y1=connectors[this.from[2]];
					$(target).data(i?'connector2':'connector').css('display','block')
							.offset({
										left:x1-3,
										top:y1-3
									});
					var _connectors=this.to[0].data('connectors');
					var x2=_connectors[this.to[1]];
					var y2=_connectors[this.to[2]];
					this.to[0].data('connector').css('display','block').offset({
								left:x2-3,
								top:y2-3
							});
					if(this.name=='h'){
						$('.jp-h-ruler').css({
									'width':Math.abs(x1-x2),
									'display':'block'
								}).offset({
									left:Math.min(x1,x2),
									top:y2
								});
					}else{
						$('.jp-v-ruler').css({
									'height':Math.abs(y1-y2),
									'display':'block'
								}).offset({
									left:x2,
									top:Math.min(y1,y2)
								});
					}
				})
	}
	var getShortestLine=function(//
			c1,// 被拖动组件的起始位置
			c2,// 静止，被检测组件的座标
			e1,// 拖动组件的边
			e2,// 静止组件的边
			start/* c1,c2中点的起始为止 x为0,y为3 */){
		var maxlen=Number.MAX_VALUE,result=[];//
		var start1=(e1==1)?start+1:start;
		var start2=(e2==1)?start+1:start;
		var end1=(e1==1)?start1+1:start+3;
		var end2=(e2==1)?start2+1:start+3;
		for(var i=start1;i<end1;i++){
			var p1=c1[i];
			for(var k=start2;k<end2;k++){
				var p2=c2[k];
				if(Math.abs(p2-p1)<maxlen){
					result[0]=i;
					result[1]=k;
					maxlen=Math.abs(p2-p1);
				}
			}
		}
		return result;
	}
	var rulerSet=function(//
			connectors,// 拖动组件的座标
			siblingConnectors,// 静止组件的座标
			ex,// 拖动组件横向对比边,如 [2,1]只对右边，中间对齐
			ey,// 拖动组件纵向对比边,如 [5,4]只对下边，中间对齐
			doSet){
		$('.jp-ruler-element').css('display','none');
		var vertical=false;
		var horizental=false;
		var rulers=[];
		$.each(siblingConnectors,function(){
					var that=this;
					// 中，下，上进行对比
					$.each(ey,function(i,_activeIndex){
								// 拖动组件的中/上/下的y
								var y1=connectors[_activeIndex],thisIndex=_activeIndex;
								$.each([4,5,3],function(i,_followedIndex){
											// 未拖动组件的座标
											var y2=that[_followedIndex];
											if(y2-2<=y1&&y1<=y2+2){
												doSet(connectors,y2,3,thisIndex);
												var shortest=getShortestLine(connectors,that,thisIndex
																-3,_followedIndex-3,0);
												var ex1=shortest[0],ex2=shortest[1];
												rulers.push({
															name:'h',
															from:[connectors[8],ex1,thisIndex],
															to:[that[8],ex2,_followedIndex]
														});
												horizental=true;
												return !horizental;
											}
										});
								return !horizental;
							})
					$.each(ex,function(i,_activeIndex){
								// 拖动组件的中/上/下的y
								var x1=connectors[_activeIndex],thisIndex=_activeIndex;
								$.each([1,2,0],function(i,_followedIndex){
											// 未拖动组件的座标
											var x2=that[_followedIndex];
											if(x2-2<=x1&&x1<=x2+2){
												doSet(connectors,x2,0,thisIndex);
												var shortest=getShortestLine(connectors,that,thisIndex,
														_followedIndex,3);
												var ey1=shortest[0],ey2=shortest[1];
												rulers.push({
															name:'v',
															from:[connectors[8],thisIndex,ey1],
															to:[that[8],_followedIndex,ey2]
														});
												vertical=true;
												return !vertical;
											}
										});
								return !vertical;
							})
					return !(horizental&&vertical);
				});
		return rulers;
	}
	$.widget("ui.mydraggable",$.ui.draggable,{
		_create:function(){
			this.element.data($.ui.draggable.prototype.widgetName,this.element
							.data($.ui.mydraggable.prototype.widgetName));
			$.ui.draggable.prototype._create.call(this);
		},
		_generatePosition:function(e){
			e.target=$(e.target).closest('.jp-component')[0];
			var result=$.ui.draggable.prototype._generatePosition.call(this,e),$this=$(e.target);
			var me=this;
			if($(e.target).data('dragging')){
				var doSet=function(c1,// 拖动组件
						expected,// 理想的位置
						baseIndex,// 位置起始处,0/3=横对齐/纵对齐
						thisIndex// 正在对拖动组件哪一边对齐,左中右上中下=012345
				){
					var p=baseIndex?'top':'left';
					result[p]=expected+c1[baseIndex]-c1[thisIndex]-me.offset.parent[p];
				}
				var connectors=$this.data('connectors').slice(0),siblingConnectors=$this
						.data('sibling-connectors'),//
				dx=e.pageX-this.lastPageX,// *this.offset.parent.left+*/result.left
				dy=e.pageY-this.lastPageY;// *this.offset.parent.top+*/result.top-connectors[3];
				for(var i=0;i<6;i++){
					connectors[i]+=((i<3)?dx:dy);
				}
				// console.log(dx,dy);
				var rulers=rulerSet(connectors,siblingConnectors,[1,2,0],[4,5,3],doSet);
				$(e.target).data('rulers',rulers);
			}
			return result;
		},
		_mouseStart:function(event){
			this.lastPageX=event.pageX;
			this.lastPageY=event.pageY;
			event.target=$(event.target).closest('.jp-component')[0];
			// //console.log(e.target);
			var p=$(event.target).position(),container=[p.left,p.top];
			$s().not(event.target).each(function(){
						var p2=$(this).position();
						(p2.left<container[0])&&(container[0]=p2.left);
						(p2.top<container[1])&&(container[1]=p2.top);
					});
			var parentOffset=$(event.target).parent().offset();
			container[0]=parentOffset.left+p.left-container[0];
			container[1]=parentOffset.top+p.top-container[1];
			container[2]=container[3]=1000000;
			this.options.containment=container;
			// var offset=$(this).offset();
			getConnectorPositions(event.target);
			$.ui.draggable.prototype._mouseStart.call(this,event);
		}
	});
	var $lastZIndex=1000;
	var $created=null;
	$('.jp-common-command a,.jp-common-command input').click(function(e){
				var handler=handlers[$(this).attr('id')];
				handler&&handler.call(handlers,e);
			});
	$('.jp-new-barcode').button({
				icons:{
					primary:"jp-primary-icon",
					secondary:"ui-icon-triangle-1-s"
				},
				text:false
			});
	$('.jp-layers').button({
				icons:{
					primary:"jp-primary-icon",
					secondary:"ui-icon-triangle-1-s"
				},
				text:false
			});
	$('.jp-border').button({
				icons:{
					primary:"jp-primary-icon",
					secondary:"ui-icon-triangle-1-s"
				},
				text:false
			});
	$('.jp-border-style').button({
				icons:{
					primary:"jp-primary-icon",
					secondary:"ui-icon-triangle-1-s"
				},
				text:false
			});
	$('.jp-border-width').button({
				icons:{
					primary:"jp-primary-icon",
					secondary:"ui-icon-triangle-1-s"
				},
				text:false
			});
	$('#jp-barcode-chooser a').click(function(e){
				handlers['jp-new-barcode'].call(handlers,e);
			});
	$(".jp-button-set").buttonset();
	function getLastZIndex(x){
		var indexs=[100],selections=$('.jp-component',$page);
		if(x)
			selections=selections.not(x);
		selections.vals(['css','z-index'],indexs);
		return Math.max.apply(null,indexs)+1;
	}
	$(".jp-page").selectable({
		distance:1,
		filter:'.jp-component',
		start:function(e){
			clickHides();
			var selectable=$(e.target).data('selectable-item',null)
					.data('selectable');
			selectable.helper.css('z-index',getLastZIndex());
			if($created){
				// 因为是autoRefresh，所以设置任何组件，不可选中
				// 保留之前的filter设置，以便在 stop 时恢复
				var _filter=selectable.options.filter;
				selectable.options.filter='#jp-undefined';
				selectable.selectees=$('#jp-undefined',e.target);
				$(e.target).data('_filter',_filter)
			}
		},
		stop:function(e){
			if($created){
				var helper=$(e.target).data('selectable').helper;
				var offset=helper.offset();
				var w=helper.width();
				if(w<10)
					w=150;
				var h=helper.height();
				if(h<10)
					h=30;
				$s().unselect();
				initComponent($created.appendTo($page).offset(offset).width(w)
						.height(h));
				// 注册undo
				undo.add(new $Edit($created,['_appendTo'],null,$page));
				// 编辑
				_editorFactory.edit($created);
				$(e.target).data('selectable').options.filter=$(e.target)
						.data('_filter');
				endCreate();
			}
		}
	}).find('.jp-paper-background').click(function(e){
				if($(e.target).is('.jp-paper-background')){
					$s().unselect();
				}
			}).dblclick(function(e){
				// alert('aaaa');
				if(!$(e.target).closest('.jp-component').length){
					handlers['jp-new'].call(handlers);
				}
			});
	var _editorFactory={
		edit:function($target){
			for(e in this.editors){
				if($target.is(e)){
					this.editors[e].open($target);
				}
			}
		},
		editors:{
			'.jp-text':_textEditor,
			'.jp-label':_textEditor,
			'.jp-barcode':_barcodeEditor,
			'.jp-image':new ImageEditor()
		}
	};
	$(window).resize(function(){
				var height=$(this).innerHeight()-$('.jp-toolbar').height()-4;
				$('.jp-content').outerHeight(height);
			})
	$(window).resize(); // on page load
	function initComponent(_target,noIndex){
		var result=$(_target).each(function(){
			var target=this;
			if(!$(target).is('.jp-ininted'))
				$(target).addClass('.jp-ininted').mydraggable({
							// containment:'parent',
							// grid:[20,20],
							start:function(ev,ui){
								// //console.log(ui.helper.text());
								selected=$s().each(function(){
											var el=$(this);
											el.data("offset",el.offset());
										});
								if(!$(this).selected())
									$(this).select();
								offset=$(this).offset();
								var oldval=[],fn=['offset'];
								selected.vals(fn,oldval);
								$(ev.target).data({
											'oldOffsets':oldval,
											'dragging':selected.length==1
										});
							},
							stop:function(e){
								$(e.target).data({
											'dragging':false,
											'rulers':null
										});
								$('.jp-ruler-element').css('display','none');
								// undo 处理
								var newval=[],fn=['offset'];
								$s().vals(fn,newval);
								undo.add(new $Edit($s(),fn,$(e.target).data('oldOffsets'),
										newval));
							},
							drag:function(ev,ui){
								var dt=ui.position.top-offset.top,dl=ui.position.left
										-offset.left;
								// take all the elements that are selected expect $("this"),
								// which
								// is the element being dragged and loop through each.
								selected.not(this).each(function(){
											// create the variable for we don't need to keep calling
											// $("this")
											// el = current element we are on
											// off = what position was this element at when it was
											// selected, before drag
											var el=$(this),off=el.data("offset");
											el.css({
														top:off.top+dt,
														left:off.left+dl
													});
										});
								var rulers=$(ev.target).data('rulers');
								if(rulers)
									renderRulers(ev.target,rulers);
							}
						})//
						.resizable({
									rulerSet:true,
									start:function(e,ui){
										getConnectorPositions(e.target);
										var oldVals={
											width:$(e.target).width(),
											height:$(e.target).height()
										};
										oldVals.dx=$(e.target).outerWidth()-oldVals.width;
										oldVals.dy=$(e.target).outerHeight()-oldVals.height;
										$(e.target).data({
													'oldVals':oldVals,
													'dragging':true
												});
									},
									resize:function(e,ui){
										var rulers=$(e.target).data('rulers');
										if(rulers)
											renderRulers(e.target,rulers);
									},
									stop:function(e){
										var $t=$(e.target);
										$('.jp-ruler-element').css('display','none');
										var newwidth=$t.width(),newheight=$t.height();
										var oldVals=$t.data('oldVals');
										undo.open();
										undo.add(new $Edit($t,['width'],oldVals.width,newwidth));
										undo.add(new $Edit($t,['height'],oldVals.height,newheight));
										undo.close();
										$t.data({
													'dragging':false,
													'rulers':null,
													'oldVals':null
												});
									}
								}).mousedown(function(e){
									if(!$(this).selected()){
										$(this).select();
										if(!e.ctrlKey)
											$(this).siblings().unselect();
									}
								}).dblclick(function(e){
									_editorFactory.edit($(this));
								}).select()
		});
		if(!noIndex){
			result.css('z-index',getLastZIndex(result));
		}
		return result;
	}
});
