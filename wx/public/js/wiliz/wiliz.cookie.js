/*
 * JS cookie处理
 *
 * Copyright (c) Weili Zhu
 *
 * Autor: 朱威力
 * Date: 2011-12-14
 *
 * 用法：
 *
 * 备注：
 *
 */

//---------------------------------------------------------------------------
/**
 * 检查cookie是否存在
 * @param c_name cookie名
 * @return bool
 */
function checkCookie(c_name) {
	var tempVal = getCookie(c_name);
	if(tempVal != null && tempVal != ''){
		return true;
	}
	else{
		return false;
	}
}

/**
 * 获取所有cookie 没有，返回null
 */
function getAllCookie() {
	var str = document.cookie;
	if (str == '') {
		return null;
	} else {
		return str;
	}
}

/*
 * 获取cookie
 * @param c_name cookie名
 * @return cookie值
 */
function getCookie(c_name) {
	if (document.cookie.length > 0){
		c_start = document.cookie.indexOf(c_name + '=');
		if(c_start != -1){
			c_start = c_start + c_name.length + 1;
			c_end = document.cookie.indexOf(';', c_start);
			if(c_end == -1){
				c_end = document.cookie.length;
			}
			return unescape(document.cookie.substring(c_start, c_end));
		}
	}
	return '';
}

/**
 * 设置cookie
 * @param c_name cookie名
 * @param value cookie值
 * @param expiredays cookie过期时间
 * @return
 */
function setCookie(c_name, value, expiredays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + expiredays);
	document.cookie = c_name+ '=' +escape(value) + ((expiredays == null) ? '' : '; expires='+exdate.toGMTString());
}

/*
 * 删除cookie
 * @param c_name cookie名
 */
function deleteCookie(c_name) {
	if (checkCookie(c_name)) {
		setCookie(c_name, '', -1);
	}
}