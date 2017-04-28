<?php
namespace Admin\Widget;

use Think\Controller;

class MenuWidget extends Controller {

    public function output()
    {
        $retData = $this->dataFormat();
        $retHtml = '<dl>';
        foreach($retData as $gName => $subList) {
            $retHtml .= '<dt><i class="Hui-iconfont"></i>'.$gName.'<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>';
            $retHtml .= '<dd><ul>';
            foreach($subList as $arr) {

                $retHtml .= "<li><a _href='{$arr['url']}' data-title='{$arr['title']}' href='javascript:void(0)'>{$arr['title']}</a></li>";
            }
            $retHtml .= '</ul></dd>';
        }
        $retHtml .='</dl>';
        return $retHtml;
    }

    public function breadcrumb()
    {
        $bcb = array();
        $menuArr = $this->dataFormat();
        $controllerName = strtolower(CONTROLLER_NAME);
        foreach($menuArr as $group => $menu) {
            foreach($menu as $sub) {
                if($controllerName == strtolower($sub['controller_name'])) {
                    $bcb[0] = $group;
                    $bcb[1] = $sub['title'];
                    break;
                }
            }

        }
        return $retHtml = <<<HTML
<nav class="breadcrumb">
	<i class="Hui-iconfont">&#xe67f;</i>
	首页 <span class="c-gray en">&gt;</span>
                {$bcb[0]}
	<span class="c-gray en">&gt;</span>
                {$bcb[1]}
	<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新">
		<i class="Hui-iconfont">&#xe68f;</i>
	</a>
</nav>
HTML;
    }

    private function dataFormat()
    {
        $retMap = array();
        $ruleList = M('auth_rule')->where('is_menu = 1')->order('group_id')->select();
        $ruleGroup = C('ruleGroup');
        foreach($ruleGroup as $gId => $gName) {
            $retMap[$gName] = array();

            $groupTmp = array();
            foreach($ruleList as $key => $rule) {
                if($gId == $rule['group_id']) {
                    $rule['conUrl'] = $rule['controller_name'].'/'.$rule['action_name'];
                    $rule['url'] =U($rule['conUrl']); 
                    array_push($groupTmp, $rule);
                    unset($ruleList[$key]);
                }
            }
            $retMap[$gName] = $groupTmp;
        }

        foreach($retMap as $key => $ruleArr) {
            if(empty($ruleArr)) {
                 unset($retMap[$key]);
                 continue;
            }
            foreach($ruleArr as $sbK => $subR) {
                if(!checkAuth($subR['conUrl'])) {
                    unset($ruleArr[$sbK]);
                }
            }
            if(empty($ruleArr)) {
                 unset($retMap[$key]);
            }
        }

        return $retMap;

    }
}
