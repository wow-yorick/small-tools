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
$z[4]=Array("include","",1912,1952);
$z[4][4]['filename']="head_news.htm";
$z[5]=Array("list","\r\n                            <li>\r\n                                <div class=\"newsListBox\">\r\n                                    <h4><a href=\"[field:arcurl/]\" target=\"_blank\">[field:title/]</a></h4>\r\n                                    <p class=\"newsViewText\">[field:description function=\"cn_substr(@me,100)\"/]...</p>\r\n                                    <p class=\"newsViewFoot\"><a href=\"[field:arcurl/]\" target=\"_blank\" class=\"newsListView\">查看详情</a>\r\n                                    </p>\r\n                                </div>\r\n                            </li>\r\n                         ",2623,3277);
$z[5][4]['pagesize']="9";
$z[5][4]['titlelen']="36";
$z[6]=Array("pagelist","",3383,3414);
$z[6][4]['listitem']="pre";
$z[7]=Array("pagelist","",3415,3447);
$z[7][4]['listitem']="next";
$z[8]=Array("include","",3575,3612);
$z[8][4]['filename']="footer.htm";

?>