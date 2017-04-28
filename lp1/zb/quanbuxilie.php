<?php
require_once "public.php";
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/> 
<title><?php echo "$title";?></title>
<link type="text/css" rel="stylesheet" href="frozen.css" />
<style>
.follow{font-size:20px;line-height:30px;color:#fff;text-align:center;padding-top:30%;z-index:2000;position:fixed;top:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,.9);display:none;}
.follow span{font-size:40px;position:absolute;top:10px;left:10px;}
.follow img{width:180px;margin-top:10px;}
</style></head>
<body ontouchstart="">
<header class="ui-header ui-header-positive ui-border-b">
	<h1><?php echo "$h1";?></h1>
</header>
<section class="ui-container" style="padding-bottom:55px;">
<ul class="ui-list ui-list-link ui-border-tb">

<li class="ui-border-t" onClick="javascript:window.location.href='huoche/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(huoche/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">火车票生成器(自定义所有信息)</h4>
            <p class="ui-nowrap">踏上火车奔向远方</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='xxsqs/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(xxsqs/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">小学生情书生成器</h4>
            <p class="ui-nowrap">还记得哪年我们写的情书吗？</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='iphone7/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(iphone7/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">iPhone 7订单生成器</h4>
            <p class="ui-nowrap">不贵才1万多而已，来一台</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='diannao/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(diannao/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">土豪电脑销售单生成器</h4>
            <p class="ui-nowrap">神机配置，这下你也可以拥有了！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='beida/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(beida/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">北京大学录取通知书生成器</h4>
            <p class="ui-nowrap">兄弟，我成功考上北大了！</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='gaokao/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(gaokao/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">高考准考证生成器</h4>
            <p class="ui-nowrap">兄弟！社会混不下去了，我回校重造去了</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='ty/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(ty/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">太阳就在我隔壁生成器</h4>
            <p class="ui-nowrap">尼玛！太阳就在我隔壁，能不热吗？</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='peixun/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(peixun/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">职业培训证书生成器</h4>
            <p class="ui-nowrap">各种奇葩职业，等你来体验哈~</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='qinghua/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(qinghua/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">清华大学录取通知书生成器</h4>
            <p class="ui-nowrap">兄弟，我成功考上清华了！</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='dddh/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(dddh/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">滴滴代喝业务生成器</h4>
            <p class="ui-nowrap">我就是单身狗，我愿意帮你</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='bingli/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(bingli/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">宾利欧陆驾驶证生成器</h4>
            <p class="ui-nowrap">宾利欧陆驾驶证生成器</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='hrbf/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(hrbf/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">胡润百富证书生成器</h4>
            <p class="ui-nowrap">快喊小伙伴们来投资你的公司！</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='pn/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(pn/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">奔跑吧兄弟工作牌生成器</h4>
            <p class="ui-nowrap">我加入跑男了！</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='2016top/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(2016top/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">2016全球富豪排行榜生成器</h4>
            <p class="ui-nowrap">其实我一向很低调的！</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='bdjp/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(bdjp/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">波多老师举牌生成器</h4>
            <p class="ui-nowrap">波多老师为微趣网络举牌！</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='mxsh/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(mxsh/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">明星手绘图生成器</h4>
            <p class="ui-nowrap">给我们家的王俊凯画了张图！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='qqfc/'">
        <div class="ui-list-img">
            <span  style="background-image:url(qqfc/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">QQ飞车土豪帐号生成器</h4>
            <p class="ui-nowrap">做个安静的土豪！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='cft/'">
        <div class="ui-list-img">
            <span  style="background-image:url(cft/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">财付通余额生成器</h4>
            <p class="ui-nowrap">有钱任性！</p>
        </div>
    </li>

<!--
<li class="ui-border-t" onClick="javascript:window.location.href='tjl/'">
        <div class="ui-list-img">
            <span  style="background-image:url(tjl/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">通缉令生成器</h4>
            <p class="ui-nowrap">兄弟你被通缉了！</p>
        </div>
    </li>
-->

<li class="ui-border-t" onClick="javascript:window.location.href='iphone/'">
        <div class="ui-list-img">
            <span  style="background-image:url(iphone/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">iphone生成器</h4>
            <p class="ui-nowrap">来来每人一部！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='hyzm/'">
        <div class="ui-list-img">
            <span  style="background-image:url(hyzm/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">怀孕证明生成器</h4>
            <p class="ui-nowrap">老公我怀孕了</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='blzz/'">
        <div class="ui-list-img">
            <span  style="background-image:url(blzz/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">部落战争生成器</h4>
            <p class="ui-nowrap">部落战争！</p>
        </div>
    </li>
	
<!--
<li class="ui-border-t" onClick="javascript:window.location.href='ck/'">
        <div class="ui-list-img">
            <span  style="background-image:url(ck/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">催款通知单生成器</h4>
            <p class="ui-nowrap">欠钱的都成爷， 赶紧去催款吧！</p>
        </div>
    </li>
-->

<li class="ui-border-t" onClick="javascript:window.location.href='918/'">
        <div class="ui-list-img">
            <span  style="background-image:url(918/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">保时捷918选配单生成器</h4>
            <p class="ui-nowrap">保时捷918选配单生成器</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='mh/'">
        <div class="ui-list-img">
            <span  style="background-image:url(mh/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">明星微信消息未读生成器</h4>
            <p class="ui-nowrap">范冰冰约我去她家了！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='zs/'">
        <div class="ui-list-img">
            <span  style="background-image:url(zs/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">银行取款生成器</h4>
            <p class="ui-nowrap">唉存款不多了！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='hzz/'">
        <div class="ui-list-img">
            <span  style="background-image:url(hzz/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">纸条工资单生成器</h4>
            <p class="ui-nowrap">默默的在这说下老板你可以发工资了吗！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='lol/'">
        <div class="ui-list-img">
            <span  style="background-image:url(lol/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">LOL封号提示生成器</h4>
            <p class="ui-nowrap">让你朋友吓一跳！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='wl/'">
        <div class="ui-list-img">
            <span  style="background-image:url(wl/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">武术段位生成器</h4>
            <p class="ui-nowrap">来打我啊，来啊来啊！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='medfly/'">
        <div class="ui-list-img">
            <span  style="background-image:url(medfly/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">马尔代夫旅游生成器</h4>
            <p class="ui-nowrap">亚航假日、海景套房别墅！</p>
        </div>
    </li>	
<li class="ui-border-t" onClick="javascript:window.location.href='hqlxs/'">
        <div class="ui-list-img">
            <span  style="background-image:url(hqlxs/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">环球旅行出团书生成器</h4>
            <p class="ui-nowrap">环球旅行，有事留言！</p>
        </div>
    </li>
    
<li class="ui-border-t" onClick="javascript:window.location.href='srfj/'">
        <div class="ui-list-img">
            <span  style="background-image:url(srfj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">私人飞机与游艇订单生成器</h4>
            <p class="ui-nowrap">您购买的私人飞机和游艇已发货！</p>
        </div>
    </li> 
	
<li class="ui-border-t" onClick="javascript:window.location.href='cqww/'">
        <div class="ui-list-img">
            <span  style="background-image:url(cqww/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">充气娃娃订单生成器</h4>
            <p class="ui-nowrap">您的充气娃娃已发货，请耐心等待！</p>
        </div>
    </li>
    
<li class="ui-border-t" onClick="javascript:window.location.href='xxcfwj/'">
        <div class="ui-list-img">
            <span  style="background-image:url(xxcfwj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">学校处分文件生成器</h4>
            <p class="ui-nowrap">公开搞基，开除学籍！</p>
        </div>
    </li>
 
<li class="ui-border-t" onClick="javascript:window.location.href='bld/'">
        <div class="ui-list-img">
            <span style="background-image:url(bld/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">巴厘岛旅游飞机票生成器</h4>
            <p class="ui-nowrap">拥有唯美的落日和海滩的国度</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='yyfc/yfc.php'">
        <div class="ui-list-img">
            <span style="background-image:url(yyfc/1.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">友谊的小船说翻就翻生成器</h4>
            <p class="ui-nowrap">翻船和不翻船两个版本~</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='wx/'">
        <div class="ui-list-img">
            <span style="background-image:url(wx/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">微信余额生成器</h4>
            <p class="ui-nowrap">迟来的装逼神器！</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='yp/'">
        <div class="ui-list-img">
            <span style="background-image:url(yp/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">约炮装逼生成器</h4>
            <p class="ui-nowrap">约了个炮！</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='dna/'">
        <div class="ui-list-img">
            <span style="background-image:url(dna/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">亲子鉴定报告生成器</h4>
            <p class="ui-nowrap">快快拿去恶搞好友吧！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='db/'">
        <div class="ui-list-img">
            <span style="background-image:url(db/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">去迪拜当乞丐生成器</h4>
            <p class="ui-nowrap">去迪拜当乞丐生成器</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='lhz/'">
        <div class="ui-list-img">
            <span  style="background-image:url(lhz/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">离婚证生成器</h4>
            <p class="ui-nowrap">我又单身了</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='sfz/'">
        <div class="ui-list-img">
            <span  style="background-image:url(sfz/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">丑男丑女身份证生成器</h4>
            <p class="ui-nowrap">我恶心死你</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='gz/'">
        <div class="ui-list-img">
            <span  style="background-image:url(gz/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">土豪工资单生成器</h4>
            <p class="ui-nowrap">工资不高才12万</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='cpzj/'">
        <div class="ui-list-img">
            <span  style="background-image:url(cpzj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">体育彩票中奖生成器</h4>
            <p class="ui-nowrap">买了这么久终于中了</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='th/'">
        <div class="ui-list-img">
            <span  style="background-image:url(th/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">领现金生成器</h4>
            <p class="ui-nowrap">做个安静的土豪</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='pkzs/'">
        <div class="ui-list-img">
            <span  style="background-image:url(pkzs/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">贫困证书生成器生成器</h4>
            <p class="ui-nowrap">老板我是真没钱了</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='ytjz/'">
        <div class="ui-list-img">
            <span  style="background-image:url(ytjz/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">游艇驾照书生成器</h4>
            <p class="ui-nowrap">有豪房豪车怎么能没有豪艇呢</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='bbqs/'">
        <div class="ui-list-img">
            <span  style="background-image:url(bbqs/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">表白情书生成器</h4>
            <p class="ui-nowrap">某某某我喜欢你</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='jj/'">
        <div class="ui-list-img">
            <span  style="background-image:url(jj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">捐精补助领取单生成器</h4>
            <p class="ui-nowrap">买ipone的钱终于有了,不用再卖肾了</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='bwtzs/'">
        <div class="ui-list-img">
            <span  style="background-image:url(bwtzs/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">病危通知书生成器</h4>
            <p class="ui-nowrap">最强神器,让朋友跌破眼镜</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='yjbg/'">
        <div class="ui-list-img">
            <span  style="background-image:url(yjbg/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">孕检报告生成器</h4>
            <p class="ui-nowrap">这么大的事他知道吗？</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='tqd/'">
        <div class="ui-list-img">
            <span  style="background-image:url(tqd/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">跆拳道黑带证书生成器</h4>
            <p class="ui-nowrap">恭喜您，通过了跆拳道黑带认证</p>
        </div>
    </li>
<li class="ui-border-t" onClick="javascript:window.location.href='yrz/'">
        <div class="ui-list-img">
            <span  style="background-image:url(yrz/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">愚人节愚人证生成器</h4>
            <p class="ui-nowrap">愚人节来了，给自己搞个高大上的证明吧！</p>
        </div>
    </li>
	


<li class="ui-border-t" onClick="javascript:window.location.href='hdsl/'">
        <div class="ui-list-img">
            <span  style="background-image:url(hdsl/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">轰动山林装逼神器生成器</h4>
            <p class="ui-nowrap">究竟是什么轰动山林，引发猴子关注！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='gxjz/'">
        <div class="ui-list-img">
            <span  style="background-image:url(gxjz/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">搞笑奖状生成器</h4>
            <p class="ui-nowrap">想要成为装逼大神，分分钟的事！</p>
        </div>
    </li>


<li class="ui-border-t" onClick="javascript:window.location.href='yj/'">
        <div class="ui-list-img">
            <span  style="background-image:url(yj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">孕检报告生成器</h4>
            <p class="ui-nowrap">帮助好基友生成一张恶搞验孕检验报告单吧！</p>
        </div>
    </li>


<li class="ui-border-t" onClick="javascript:window.location.href='xmjj/'">
        <div class="ui-list-img">
            <span  style="background-image:url(xmjj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">项目奖金支票生成器</h4>
            <p class="ui-nowrap">接了一个项目，奖金也不算多吧？</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='ms/'">
        <div class="ui-list-img">
            <span  style="background-image:url(ms/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">玛莎拉蒂天猫订单生成器</h4>
            <p class="ui-nowrap">玛莎拉蒂入驻天猫了，开抢吧！</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='hp/'">
        <div class="ui-list-img">
            <span  style="background-image:url(hp/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">湖畔大学上课图片生成器</h4>
            <p class="ui-nowrap">近距离接触马云，够装逼！</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='ly/'">
        <div class="ui-list-img">
            <span style="background-image:url(ly/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">楼宇表白生成器</h4>
            <p class="ui-nowrap">最有逼格的表白装逼神器</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='szj/'">
        <div class="ui-list-img">
            <span style="background-image:url(szj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">宋仲基自爆恋情生成器</h4>
            <p class="ui-nowrap">宋仲基老公自爆他和你的恋情</p>
        </div>
    </li>
    <li class="ui-border-t" onClick="javascript:window.location.href='bb/'">
        <div class="ui-list-img">
            <span style="background-image:url(bb/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">表白图片生成器</h4>
            <p class="ui-nowrap">追我的人连起来绕地球好几圈</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='zhao/'">
        <div class="ui-list-img">
            <span style="background-image:url(zhao/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">最牛X的信用卡生成器</h4>
            <p class="ui-nowrap">至尊黑卡，额度自己说了算</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='hf/'">
        <div class="ui-list-img">
            <span style="background-image:url(hf/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">横幅表白图片生成器</h4>
            <p class="ui-nowrap">最接地气的表白装逼神器</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='ns/'">
        <div class="ui-list-img">
            <span style="background-image:url(ns/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">男神表白微博生成器</h4>
            <p class="ui-nowrap">春风十里不如睡男神</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='zj/'">
        <div class="ui-list-img">
            <span style="background-image:url(zj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">钻戒表白图片生成器</h4>
            <p class="ui-nowrap">每个女人都有一个钻石的梦想</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='fj/'">
        <div class="ui-list-img">
            <span style="background-image:url(fj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">飞机驾照生成器</h4>
            <p class="ui-nowrap">汽车驾照之类的都弱爆了</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='fc/'">
        <div class="ui-list-img">
            <span style="background-image:url(fc/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">豪宅房产证生成器</h4>
            <p class="ui-nowrap">上海最贵豪宅汤臣一品值得拥有</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='hc/'">
        <div class="ui-list-img">
            <span style="background-image:url(hc/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">豪车订单生成器</h4>
            <p class="ui-nowrap">选一辆喜欢的豪车去刷爆朋友圈</p>
        </div>
    </li>
    <li class="ui-border-t" onClick="javascript:window.location.href='jhz/'">
        <div class="ui-list-img">
            <span style="background-image:url(jhz/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">婚姻证书生成器</h4>
            <p class="ui-nowrap">单身狗必备的逆袭装逼神器</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='cet/'">
        <div class="ui-list-img">
            <span style="background-image:url(cet/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">英语四六级分数单</h4>
            <p class="ui-nowrap">一秒钟学渣轻松变身学霸</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='ym/'">
        <div class="ui-list-img">
            <span style="background-image:url(ym/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">移民申请生成器</h4>
            <p class="ui-nowrap">世界难么大我想去看看</p>
        </div>
    </li>
</ul>
</section>
<footer class="ui-footer ui-footer-btn">
	<ul class="ui-tiled ui-border-t">
		<li class="ui-border-r"><a onClick="show()"><div>关注<?php echo "$gz";?></div></a></li>
	</ul>
</footer>
<div id="follow" class="follow">
	<span class="close" onClick="hide()">×</span>
	<p>长按下方二维码图片</p>
	<p>点选识别图中二维码</p>	<img src="images/ew.jpg">
</div>
<script type="text/javascript">
function show(){
	document.getElementById("follow").style.display = "block"; 
}
function hide(){
	document.getElementById("follow").style.display = "none"; 
}
</div>
</body>
</html>