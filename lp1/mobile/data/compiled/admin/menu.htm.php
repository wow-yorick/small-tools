<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ECSHOP Menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="styles/general.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
<!--
var noHelp   = "<p align='center' style='color: #666'><?php echo $this->_var['lang']['no_help']; ?></p>";
var helpLang = "<?php echo $this->_var['help_lang']; ?>";
//-->
</script>

<style type="text/css">
body {
  background: #80BDCB;
}
#tabbar-div {
  background: #278296;
  padding-left: 10px;
  height: 21px;
  padding-top: 0px;
}
#tabbar-div p {
  margin: 1px 0 0 0;
}
.tab-front {
  background: #80BDCB;
  line-height: 20px;
  font-weight: bold;
  padding: 4px 15px 4px 18px;
  border-right: 2px solid #335b64;
  cursor: hand;
  cursor: pointer;
}
.tab-back {
  color: #F4FAFB;
  line-height: 20px;
  padding: 4px 15px 4px 18px;
  cursor: hand;
  cursor: pointer;
}
.tab-hover {
  color: #F4FAFB;
  line-height: 20px;
  padding: 4px 15px 4px 18px;
  cursor: hand;
  cursor: pointer;
  background: #2F9DB5;
}
#top-div
{
  padding: 3px 0 2px;
  background: #BBDDE5;
  margin: 5px;
  text-align: center;
}
#main-div {
  border: 1px solid #345C65;
  padding: 5px;
  margin: 5px;
  background: #FFF;
}
#menu-list {
  padding: 0;
  margin: 0;
}
#menu-list ul {
  padding: 0;
  margin: 0;
  list-style-type: none;
  color: #335B64;
}
#menu-list li {
  padding-left: 16px;
  line-height: 16px;
  cursor: hand;
  cursor: pointer;
}
#main-div a:visited, #menu-list a:link, #menu-list a:hover {
  color: #335B64
  text-decoration: none;
}
#menu-list a:active {
  color: #EB8A3D;
}
.explode {
  background: url(images/menu_minus.gif) no-repeat 0px 3px;
  font-weight: bold;
}
.collapse {
  background: url(images/menu_plus.gif) no-repeat 0px 3px;
  font-weight: bold;
}
.menu-item {
  background: url(images/menu_arrow.gif) no-repeat 0px 3px;
  font-weight: normal;
}
#help-title {
  font-size: 14px;
  color: #000080;
  margin: 5px 0;
  padding: 0px;
}
#help-content {
  margin: 0;
  padding: 0;
}
.tips {
  color: #CC0000;
}
.link {
  color: #000099;
}
</style>

</head>
<body>
<div id="tabbar-div">
<p><span style="float:right; padding: 3px 5px;" ><a href="javascript:toggleCollapse();"><img id="toggleImg" src="images/menu_minus.gif" width="9" height="9" border="0" alt="<?php echo $this->_var['lang']['collapse_all']; ?>" /></a></span>
  <span class="tab-front" id="menu-tab"><?php echo $this->_var['lang']['menu']; ?></span>
</p>
</div>
<div id="main-div">
<div id="menu-list">
<ul id="menu-ul">
<li name="menu" key="02_cat_and_goods" class="explode">
    商品管理        <ul style="display: block;">
          <li class="menu-item"><a target="main-frame" href="goods.php?act=list">商品列表</a></li>
          <li class="menu-item"><a target="main-frame" href="goods.php?act=add">添加新商品</a></li>
          <li class="menu-item"><a target="main-frame" href="category.php?act=list">商品分类</a></li>
        
         
          <li class="menu-item"><a target="main-frame" href="goods_type.php?act=manage">商品类型</a></li>
 
        </ul>
</li>
<li name="menu" key="02_cat_and_goods" class="explode">
    分销设置        <ul style="display: block;">
		<li class="menu-item"><a href="affiliate.php?act=list" target="main-frame">推荐设置</a></li>
		<li class="menu-item"><a href="affiliate_ck.php?act=list" target="main-frame">分成管理</a></li>
 
        </ul>
</li>
<li class="explode" key="menu_1" name="menu">
	系统设置
    <ul>
        <li class="menu-item"><a href="shop_config.php?act=list_edit" target="main-frame">基本设置</a></li>
        <li class="menu-item"><a href="brand.php?act=list" target="main-frame">品牌管理</a></li>
        <li class="menu-item"><a href="category.php?act=list" target="main-frame">分类图标</a></li>
        <li class="menu-item"><a href="ad_position.php?act=list" target="main-frame">广告管理</a></li>
        <li class="menu-item"><a href="payment.php?act=list" target="main-frame">支付方式</a></li>
       <li class="menu-item"><a href="shipping.php?act=list" target="main-frame">配送方式</a></li>
        <li class="menu-item"><a href="website.php?act=list" target="main-frame">授权登录</a></li>
        <li class="menu-item"><a href="navigator.php?act=list" target="main-frame">菜单管理</a></li>
		<li class="menu-item"><a href="shop_config.php?act=mail_settings" target="main-frame">邮件服务器设置</a></li>
		<li class="menu-item"><a href="user_card.php?act=ctlist" target="main-frame">会员卡管理</a></li>
    </ul>
</li>


<li class="explode" key="menu_2" name="menu">
	订单管理
    <ul>
        <li class="menu-item"><a href="order.php?act=list" target="main-frame">订单列表</a></li>
        <li class="menu-item"><a href="order.php?act=order_query" target="main-frame">订单查询</a></li>
        <li class="menu-item"><a href="order.php?act=merge" target="main-frame">合并订单</a></li>
        <li class="menu-item"><a href="goods_booking.php?act=list_all" target="main-frame">缺货登记</a></li>
        <li class="menu-item"><a href="order.php?act=delivery_list" target="main-frame">发货单列表</a></li>
        <li class="menu-item"><a href="order.php?act=back_list" target="main-frame">退货单列表</a></li>
    </ul>
</li>
<li class="explode" key="menu_2" name="menu">
	促销管理
    <ul>
        <li class="menu-item"><a href="bonus.php?act=list" target="main-frame">红包类型</a></li>
        <li class="menu-item"><a href="exchange_goods.php?act=list" target="main-frame">积分商城</a></li>
        <li class="menu-item"><a href="group_buy.php?act=list" target="main-frame">团购活动</a></li>
    </ul>
</li>
<li class="explode" key="menu_2" name="menu">
	模板管理
    <ul>
        <li class="menu-item"><a href="template.php?act=list" target="main-frame">模板选择</a></li>
        <li class="menu-item"><a href="template.php?act=setup" target="main-frame">设置模板</a></li>
        <li class="menu-item"><a href="template.php?act=library" target="main-frame">库项目管理</a></li>
        <li class="menu-item"><a href="edit_languages.php?act=list" target="main-frame">语言项编辑</a></li>
        <li class="menu-item"><a href="template.php?act=backup_setting" target="main-frame">模板设置备份</a></li>
    </ul>
</li>
<li class="explode" key="menu_3" name="menu">
	商创微信通
    <ul>
      <li class="menu-item"><a href="wxch-ent.php?act=wxconfig" target="main-frame">微信接口</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=menu" target="main-frame">微信菜单设置</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=config" target="main-frame">Ecshop微信通设置</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=bonus" target="main-frame">关注送红包</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=regmsg" target="main-frame">关注回复内容</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=lang" target="main-frame">语言设置</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=keywords" target="main-frame">关键词自动回复</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=point" target="main-frame">积分增加</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=fun" target="main-frame">功能变量</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=prize" target="main-frame">抽奖规则</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=zjd" target="main-frame">砸金蛋</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=dzp" target="main-frame">大转盘</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=qr" target="main-frame">多功能二维码</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=order" target="main-frame">发货提醒</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=pay" target="main-frame">付款提醒</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=reorder" target="main-frame">订单提醒</a></li>
          <li class="menu-item"><a href="wxch_users.php?act=list" target="main-frame">粉丝管理</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=oauth" target="main-frame">微信OAuth</a></li>
          <li class="menu-item"><a href="wxch-ent.php?act=tuijian" target="main-frame">扫码引荐</a></li>
		   <li class="menu-item">
		   <a href="users_invite.php?act=list" target="main-frame"><font style="color:red">推荐人列表</font></a></li>
        </ul>
</li>
<li class="explode" key="menu_4" name="menu">
使用手册
  <ul>
    <li class="menu-item"><a href="help_wei.php?act=ectouch" target="main-frame">ectouch使用手册</a></li>
    <li class="menu-item"><a href="help_wei.php?act=weixintong" target="main-frame">微信通使用手册</a></li>
  </ul>
</li>

<!--<?php if (! $this->_var['menus']): ?> 不显示菜单-->
<?php $_from = $this->_var['menus']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('k', 'menu');if (count($_from)):
    foreach ($_from AS $this->_var['k'] => $this->_var['menu']):
?>
<?php if ($this->_var['menu']['action']): ?>
  <li class="explode"><a href="<?php echo $this->_var['menu']['action']; ?>" target="main-frame"><?php echo $this->_var['menu']['label']; ?></a></li>
<?php else: ?>
  <li class="explode" key="<?php echo $this->_var['k']; ?>" name="menu">
    <?php echo $this->_var['menu']['label']; ?>
    <?php if ($this->_var['menu']['children']): ?>
    <ul>
    <?php $_from = $this->_var['menu']['children']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'child');if (count($_from)):
    foreach ($_from AS $this->_var['child']):
?>
      <li class="menu-item"><a href="<?php echo $this->_var['child']['action']; ?>" target="main-frame"><?php echo $this->_var['child']['label']; ?></a></li>
    <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
    </ul>
    <?php endif; ?>
  </li>
<?php endif; ?>
<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
<!--<?php endif; ?>-->
</ul>
</div>
<div id="help-div" style="display:none">
<h1 id="help-title"></h1>
<div id="help-content"></div>
</div>
</div>
<?php echo $this->smarty_insert_scripts(array('files'=>'../data/static/js/global.js,../data/static/js/utils.js,../data/static/js/transport.js')); ?>
<script language="JavaScript">
<!--
var collapse_all = "<?php echo $this->_var['lang']['collapse_all']; ?>";
var expand_all = "<?php echo $this->_var['lang']['expand_all']; ?>";
var collapse = true;

function toggleCollapse()
{
  var items = document.getElementsByTagName('LI');
  for (i = 0; i < items.length; i++)
  {
    if (collapse)
    {
      if (items[i].className == "explode")
      {
        toggleCollapseExpand(items[i], "collapse");
      }
    }
    else
    {
      if ( items[i].className == "collapse")
      {
        toggleCollapseExpand(items[i], "explode");
        ToggleHanlder.Reset();
      }
    }
  }

  collapse = !collapse;
  document.getElementById('toggleImg').src = collapse ? 'images/menu_minus.gif' : 'images/menu_plus.gif';
  document.getElementById('toggleImg').alt = collapse ? collapse_all : expand_all;
}

function toggleCollapseExpand(obj, status)
{
  if (obj.tagName.toLowerCase() == 'li' && obj.className != 'menu-item')
  {
    for (i = 0; i < obj.childNodes.length; i++)
    {
      if (obj.childNodes[i].tagName == "UL")
      {
        if (status == null)
        {
          if (obj.childNodes[1].style.display != "none")
          {
            obj.childNodes[1].style.display = "none";
            ToggleHanlder.RecordState(obj.getAttribute("key"), "collapse");
            obj.className = "collapse";
          }
          else
          {
            obj.childNodes[1].style.display = "block";
            ToggleHanlder.RecordState(obj.getAttribute("key"), "explode");
            obj.className = "explode";
          }
          break;
        }
        else
        {
          if( status == "collapse")
          {
            ToggleHanlder.RecordState(obj.getAttribute("key"), "collapse");
            obj.className = "collapse";
          }
          else
          {
            ToggleHanlder.RecordState(obj.getAttribute("key"), "explode");
            obj.className = "explode";
          }
          obj.childNodes[1].style.display = (status == "explode") ? "block" : "none";
        }
      }
    }
  }
}
document.getElementById('menu-list').onclick = function(e)
{
  var obj = Utils.srcElement(e);
  toggleCollapseExpand(obj);
}

document.getElementById('tabbar-div').onmouseover=function(e)
{
  var obj = Utils.srcElement(e);

  if (obj.className == "tab-back")
  {
    obj.className = "tab-hover";
  }
}

document.getElementById('tabbar-div').onmouseout=function(e)
{
  var obj = Utils.srcElement(e);

  if (obj.className == "tab-hover")
  {
    obj.className = "tab-back";
  }
}

document.getElementById('tabbar-div').onclick=function(e)
{
  var obj = Utils.srcElement(e);

 // var mnuTab = document.getElementById('menu-tab');
  var hlpTab = document.getElementById('help-tab');
  var mnuDiv = document.getElementById('menu-list');
  var hlpDiv = document.getElementById('help-div');

  //if (obj.id == 'menu-tab')
//  {
//    mnuTab.className = 'tab-front';
//    hlpTab.className = 'tab-back';
//    mnuDiv.style.display = "block";
//    hlpDiv.style.display = "none";
//  }

  if (obj.id == 'help-tab')
  {
    mnuTab.className = 'tab-back';
    hlpTab.className = 'tab-front';
    mnuDiv.style.display = "none";
    hlpDiv.style.display = "block";

    loc = parent.frames['main-frame'].location.href;
    pos1 = loc.lastIndexOf("/");
    pos2 = loc.lastIndexOf("?");
    pos3 = loc.indexOf("act=");
    pos4 = loc.indexOf("&", pos3);

    filename = loc.substring(pos1 + 1, pos2 - 4);
    act = pos4 < 0 ? loc.substring(pos3 + 4) : loc.substring(pos3 + 4, pos4);
    loadHelp(filename, act);
  }
}

/**
 * 创建XML对象
 */
function createDocument()
{
  var xmlDoc;

  // create a DOM object
  if (window.ActiveXObject)
  {
    try
    {
      xmlDoc = new ActiveXObject("Msxml2.DOMDocument.6.0");
    }
    catch (e)
    {
      try
      {
        xmlDoc = new ActiveXObject("Msxml2.DOMDocument.5.0");
      }
      catch (e)
      {
        try
        {
          xmlDoc = new ActiveXObject("Msxml2.DOMDocument.4.0");
        }
        catch (e)
        {
          try
          {
            xmlDoc = new ActiveXObject("Msxml2.DOMDocument.3.0");
          }
          catch (e)
          {
            alert(e.message);
          }
        }
      }
    }
  }
  else
  {
    if (document.implementation && document.implementation.createDocument)
    {
      xmlDoc = document.implementation.createDocument("","doc",null);
    }
    else
    {
      alert("Create XML object is failed.");
    }
  }
  xmlDoc.async = false;

  return xmlDoc;
}

//菜单展合状态处理器
var ToggleHanlder = new Object();

Object.extend(ToggleHanlder ,{
  SourceObject : new Object(),
  CookieName   : 'Toggle_State',
  RecordState : function(name,state)
  {
    if(state == "collapse")
    {
      this.SourceObject[name] = state;
    }
    else
    {
      if(this.SourceObject[name])
      {
        delete(this.SourceObject[name]);
      }
    }
    var date = new Date();
    date.setTime(date.getTime() + 99999999);
    document.setCookie(this.CookieName, this.SourceObject.toJSONString(), date.toGMTString());
  },

  Reset :function()
  {
    var date = new Date();
    date.setTime(date.getTime() + 99999999);
    document.setCookie(this.CookieName, "{}" , date.toGMTString());
  },

  Load : function()
  {
    if (document.getCookie(this.CookieName) != null)
    {
      this.SourceObject"("+ document.getCookie(this.CookieName) +")");
      var items = document.getElementsByTagName('LI');
      for (var i = 0; i < items.length; i++)
      {
        if ( items[0].getAttribute("name") == "menu" && items[0].getAttribute("id") != '20_yun')
        {
          for (var k in this.SourceObject)
          {
            if ( typeof(items[i]) == "object")
            {
              if (items[i].getAttribute('key') == k)
              {
                toggleCollapseExpand(items[i], this.SourceObject[k]);
                collapse = false;
              }
            }
          }
        }
     }
    }
    document.getElementById('toggleImg').src = collapse ? 'images/menu_minus.gif' : 'images/menu_plus.gif';
    document.getElementById('toggleImg').alt = collapse ? collapse_all : expand_all;
  }
});

ToggleHanlder.CookieName += "_<?php echo $this->_var['admin_id']; ?>";
//初始化菜单状态
ToggleHanlder.Load();
//-->
</script>

</body>
</html>