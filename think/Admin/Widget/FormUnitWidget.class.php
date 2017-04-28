<?php
namespace Admin\Widget;

use Think\Controller;

class FormUnitWidget extends Controller {

    public function input($displayName, $name, $value = '')
    {
			return $displayName.'： <input type="text" name="'.$name.'" value="'.$value.'" class="input-text" placeholder="'.$displayName.'"/>';
    }

    public function select($displayName, $name, $dataArr, $selectVal ='', $model = 'name|name')
    {
        $model = explode('|',$model);
        $opt = '<option value="">--请选择--</option>';
        foreach($dataArr as $key =>$val) {
            if($selectVal == $val[$model[0]]) {
                $opt .= "<option value='{$val[$model[0]]}' selected>{$val[$model[1]]}</option>";
            } else {
                $opt .= "<option value='{$val[$model[0]]}'>{$val[$model[1]]}</option>";
            }
        }
        $selHtml = <<<SELECT
 {$displayName}：<span class="select-box inline">
				<select class="select" name="{$name}">
            {$opt}
				</select>
			</span>
SELECT;
        return $selHtml;
    }

    public function btnMenu($btnName, $contrName, $actName) 
    {
        $contrAndActName = $contrName.'/'.$actName;
        if(!checkAuth($contrAndActName)) return false;

        $actUrl = U($contrAndActName);
$btnHtm = <<<TMP
        <div class="cl pd-5 bg-1 bk-gray">
        <span class="l">
        <a class="btn btn-primary radius" href="javascript:void(0);" onclick="{$actName}('{$btnName}','{$actUrl}')"><i class="Hui-iconfont">
            &#xe600;</i> {$btnName}</a>
        </span>
        </div>
TMP;
        return $btnHtm;
    }

    public function btnSmall($btnName, $contrName, $actName, $urlParams = array(), $icoFlag ='')
    {
        $contrAndActName = $contrName.'/'.$actName;
        if(!checkAuth($contrAndActName)) return false;
        $ico = '';
        switch($actName) {
            case 'edit':
                $ico = '&#xe6df;';
            break;
            case 'del':
                $ico = '&#xe6e2;';
            break;
            default:
                $ico = '&#xe6df;';
        }
        if($icoFlag) {
            $ico = $icoFlag;
        }

        $actUrl = U($contrAndActName, $urlParams);
        $btnHtm = <<<TMP
           <a data-id="{$urlParams['id']}" class="ml-5" style="text-decoration:none" onclick="{$actName}('{$btnName}','{$actUrl}',800,380, this)" href="javascript:void(0);" title="{$btnName}">
                <i class="Hui-iconfont">_{$ico}</i>
            </a>
TMP;
        return $btnHtm;
    }
}
