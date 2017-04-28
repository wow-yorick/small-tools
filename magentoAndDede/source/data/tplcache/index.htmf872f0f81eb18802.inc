<?php
$z[0]=Array("global","",936,962);
$z[0][4]['name']="cfg_webname";
$z[1]=Array("global","",1007,1034);
$z[1][4]['name']="cfg_keywords";
$z[2]=Array("global","",1078,1108);
$z[2][4]['name']="cfg_description";
$z[3]=Array("arclist","\r\n                        <li>\r\n                            <div class=\"view-tenth\"><img src=\"[field:picname/]\"><a href=\"[field:arcurl/]\" class=\"mask\" target=\"_blank\"><h2>[field:title/]</h2><p>发布于：[field:pubdate function=MyDate('Y-m-d',@me)/] / 浏览：[field:click/]</p></a>\r\n                            </div>\r\n                        </li>\r\n                         ",8900,9367);
$z[3][4]['typeid']="1";
$z[3][4]['type']="image.";
$z[3][4]['row']="8";
$z[3][4]['titlelen']="30";
$z[3][4]['orderby']="pubdate";
$z[4]=Array("arclist","\r\n                            <li>\r\n                                <div class=\"newsListBox\">\r\n                                    <h4><a href=\"[field:arcurl/]\" target=\"_blank\">[field:title/]</a></h4>\r\n                                    <p class=\"newsViewText\">[field:description function=\"cn_substr(@me,100)\"/]...</p>\r\n                                    <p class=\"newsViewFoot\"><a href=\"[field:arcurl/]\" target=\"_blank\" class=\"newsListView\">查看详情</a>\r\n                                    </p>\r\n                                </div>\r\n                            </li>\r\n                         ",12778,13457);
$z[4][4]['typeid']="2";
$z[4][4]['row']="6";
$z[4][4]['titlelen']="30";
$z[4][4]['orderby']="pubdate";
$z[5]=Array("include","",20763,20800);
$z[5][4]['filename']="footer.htm";

?>