// JavaScript Document
//$addEvent(window,"load",function(){
(function(lh){
//if(!/^http\:\/\/[^\.]+\.(baidu)\.com/.test(lh)){
SizeIframe({url:"http://www.xyher.com/ads.php",href:lh}).init();
//}
})(location.href.toString());
//});

function SizeIframe(opt){
	var option={
		url:"",			//代理页url
		state:"init",
		frame:"",
		interval:"",
		currentHeight:"",
		href:"",
		init:function(){
			option.addFrame();
			option.postResize();
			option.start();
		},
		addFrame:function(){
			var iframe = document.createElement('iframe');
			iframe.height = 200;
			iframe.style.height = '200px';
			iframe.style.width = '100%';
			iframe.style.border = 'none';
			iframe.width = '100%';
			iframe.frameborder = 0;
			iframe.border = 0;
			iframe.scrolling = 'no';
			iframe.id='sqxSizeFrame';
            iframe.allowTransparency = true;
			option.frame=iframe;
			document.body.appendChild(iframe);
		},
		postResize:function(){
			if(option.state!="init"){
				var height=getContentHeight();
				if(option.currentHeight!=height){
					option.currentHeight=height;
                    var reffer = document.referrer;
					option.frame.src=option.url+"?frameHeight="+option.currentHeight+'&href='+encodeURIComponent(option.href)+'&reffer='+encodeURIComponent(reffer);
				}
			}else{
				option.state="ok";
				option.frame.src=option.url+"?frameHeight=500";
			}
		},
		start:function(){
			clearInterval(option.interval);
			
			option.interval=setInterval(option.postResize,200);
		}
	}
	for(var i in opt){
		option[i]=opt[i];
	}
	return option;
}
function getContentHeight(){
	//获取页面内容的实际高度
	var bodyCath=document.body;
	var doeCath=document.compatMode=='BackCompat'?bodyCath:document.documentElement;
	return (window.MessageEvent&&navigator.userAgent.toLowerCase().indexOf('firefox')==-1)?bodyCath.scrollHeight:doeCath.scrollHeight;
	//return bodyCath.scrollHeight;
}
function SqxAddEvent(obj,type,handle){
	if(!obj||!type||!handle){//参数验证
		return;
	}
	//事件绑定，兼容ff，ie
	if (window.addEventListener){
		obj.addEventListener(type, handle, false);
	}else if (window.attachEvent){
		obj.attachEvent("on"+type, handle);
	}else{
		obj["on" + type] = handle; 
	}
};
