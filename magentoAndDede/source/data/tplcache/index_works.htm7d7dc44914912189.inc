<?php
$z[0]=Array("field","",846,865);
$z[0][4]['name']="title";
$z[1]=Array("global","",866,892);
$z[1][4]['name']="cfg_webname";
$z[2]=Array("field","",937,966);
$z[2][4]['name']="keywords";
$z[3]=Array("field","",1010,1069);
$z[3][4]['name']="description";
$z[3][4]['function']="html2text(@me)";
$z[4]=Array("field","if(@me=='1')@me='<li class=\"active\"><a href=\"/works/\" >';else@me='<li><a href=\"/works/\">';",3856,4023);
$z[4][4]['name']="typeid";
$z[4][4]['runphp']="yes";
$z[4][4]['function']="GetTopid(@me)";
$z[5]=Array("channel","\r\n                        <li><a href=\"[field:typelink/]\">[field:typename/]</a></li>\r\n                        ",4064,4290);
$z[5][4]['type']="sun";
$z[5][4]['currentstyle']="<li class='active'><a href='~typelink~' >~typename~</a></li>";
$z[6]=Array("list","\r\n                        <li>\r\n                            <div class=\"view-tenth\"><img src=\"[field:picname/]\"><a href=\"[field:arcurl/]\" class=\"mask\" target=\"_blank\"><h2>[field:title/]</h2><p>发布于：[field:pubdate function=MyDate('Y-m-d',@me)/] / 浏览：[field:click/]</p></a>\r\n                            </div>\r\n                        </li>\r\n                      ",4450,4876);
$z[6][4]['pagesize']="20";
$z[6][4]['titlelen']="30";
$z[7]=Array("pagelist","",4982,5014);
$z[7][4]['listitem']="next";
$z[8]=Array("pagelist","",5056,5088);
$z[8][4]['listitem']="pre";

?>