 
<!DOCTYPE html">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>顶尖幽默</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
      
    <link rel="stylesheet" href="http://apps.bdimg.com/libs/jquerymobile/1.3.0/jquery.mobile-1.3.0.min.css">  
    <script src="http://apps.bdimg.com/libs/jquery/1.8.3/jquery.min.js"></script> 
    <script src="http://apps.bdimg.com/libs/jquerymobile/1.3.0/jquery.mobile-1.3.0.min.js"></script> 
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

<!--    <link rel="stylesheet" href="__PUBLIC__/css/jquery.mobile-1.3.0.min.css">  
    <script src="__PUBLIC__/js/jquery.min.js"></script> 
    <script src="__PUBLIC__/js/jquery.mobile-1.3.0.min.js"></script> 
    <script src="__PUBLIC__/js/jweixin-1.0.0.js"></script>-->
</head>
<body>
 
<div data-role="page">
     <div data-role="content">
		
        <div data-role="fieldcontain">
        <form action="">
            <div id="ps">  
                <input  name="name" placeholder="输入姓名" type="text"  class="ui-input-text ui-body-c" style="width: 95%;">
             <input   name="namea" placeholder="输入姓名" type="hidden"  class="ui-input-text ui-body-c" style="width: 95%;">
		<input  name="nameb" placeholder="输入手机号" type="text"  class="ui-input-text ui-body-c" style="width: 95%;">  
            </div>
		
            <input id="buttonCreate" type="submit" data-inline="true" class="ui-btn" value="生成广告">
 		 </form>点击生成后请耐心等待2-3秒即可生成</p></p>生成后手指长按图片位置即可保存到手机
        </div>
        <div id="imgresult">
            <?php if(@$_GET['name']){?>
              <img src="toutu_1.php?name=<?=$_GET['name']?>&namea=<?=$_GET['namea']?>&nameb=<?=$_GET['nameb']?>" width="100%"/>
              <img src="toutu_2.php?name=<?=$_GET['name']?>&namea=<?=$_GET['namea']?>&nameb=<?=$_GET['nameb']?>" width="100%"/>
              <img src="toutu_3.php?name=<?=$_GET['name']?>&namea=<?=$_GET['namea']?>&nameb=<?=$_GET['nameb']?>" width="100%"/>

            <?php }?>
        </div>
<div style="text-align: center" id="qrcode">
            <p><font color="red">公众号内回复"mb"百种模板供你选择</font></p>
            <p>公众号账号：DJ_humor</p>
            <p>长按下方图片识别二维码关注公众号</p>
            <img style="width: 60%" src="erweima.png">
<p>各种行业咨询，幽默，顶尖时尚内容等着你！</p>
	</div>
</div> 
</body>
</html>
