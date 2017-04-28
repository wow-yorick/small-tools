
/*
 * 非空验证
 */
function wlz_authIsEmpty(str) {
	if (str == null || $.trim(str) == '') {
		return true;
	}
	return false;
}

/*
 * 手机号码
 */
function wlz_authIsPhone(str) {
	//验证电话号码手机号码，包含至今所有号段
	var reg = /^(1[3|5|8][0-9])\d{8}$/;

	var flag = reg.test(str);
	return flag;
}
/********************************************************************/

/*
 * 非空验证，根据标签的value值
 */
function wiliz_checkEmptyByVal(obj) {
	$(obj).val($.trim($(obj).val())); //去除空格

	var str = $(obj).val();
	var flag = wlz_authIsEmpty(str);
	if(flag){
		$(obj).addClass('ui-state-error');
	} else {
		$(obj).removeClass('ui-state-error');
	}

	$(obj).bind('focus', function() {
		$(this).removeClass('ui-state-error');
	});
}

/*
 * 非空验证，根据标签里的文本值
 */
function wiliz_checkEmptyByTxt(obj) {
	var str = $(obj).text();
	var flag = wlz_authIsEmpty(str);
	if(flag){
		$(obj).addClass('ui-state-error');
	} else {
		$(obj).removeClass('ui-state-error');
	}

	$(obj).bind('focus', function() {
		$(this).removeClass('ui-state-error');
	});
}

/*
 * 手机号码验证
 * 默认验证非空，可以传入'1'允许空值
 */
function wiliz_checkPhone(obj, allowNull) {
	$(obj).val($.trim($(obj).val())); //去除空格

	var str = $(obj).val();
	if(allowNull == 1){
		if(str == null || $.trim(str) == ''){
			$(obj).removeClass('ui-state-error');
			return;
		}
	}
	var flag = wlz_authIsPhone(str);
	if(!flag){
		$(obj).addClass('ui-state-error');
	} else {
		$(obj).removeClass('ui-state-error');
	}
}

/*
 * select下拉列表验证
 */
function wiliz_checkSlt(obj){
	if($(obj).find('option:first').val() == $(obj).find('option:selected').val()){
		$(obj).addClass('ui-state-error');
	}
	else{
		$(obj).removeClass('ui-state-error');
	}
}

/*
 * 确认密码验证，绑定给新密码
 */
function wiliz_checkPwdSame1(obj, confirmPwdId){
	if(wiliz_checkEmptyByVal(obj)){
		if($(obj).val() != $('#' + confirmPwdId).val()){
			$('#' + confirmPwdId).addClass('ui-state-error');
		}
		else{
			$('#' + confirmPwdId).removeClass('ui-state-error');
		}
	}
}

/*
 * 确认密码验证，绑定给确认密码
 */
function wiliz_checkPwdSame2(newPwdId){
	$('#' + newPwdId).blur();
}

/********************************************************************/

/*
 * 绑定'focus'事件，移除'ui-state-error'
 */
$('[wlzAuth]').live('focus', function() {
	$(this).removeClass('ui-state-error');
});

/*
 * 正则验证
 * 属性值必须以'preg:'开头，后接正则表达式
 */
$('[wlzAuth^=preg]').live('blur', function() {
	$(this).val($.trim($(this).val())); //去除空格

	var reg = new RegExp($(this).attr('wlzAuth').substr(5));
	var str = $(this).val();
	var flag = reg.test(str);
	if(!flag){
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}
});

/*
 * text 验证手机号（允许空）
 */
$('[wlzAuth=txtPhone]').live('blur', function() {
	$(this).val($.trim($(this).val())); //去除空格

	var str = $(this).val();
	if($.trim(str) == ''){
		$(this).removeClass('ui-state-error');
		return;
	}

	var flag = wlz_authIsPhone(str);
	if(!flag){
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}
});

/*
 * text 验证手机号（不允许空）
 */
$('[wlzAuth=txtPhoneNull]').live('blur', function() {
	$(this).val($.trim($(this).val())); //去除空格

	var str = $(this).val();
	var flag = wlz_authIsPhone(str);
	if(!flag){
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}
});

/*
 * text 验证value非空（不移除两端空格）
 */
$('[wlzAuth=txtValNone]').live('blur', function() {
	if ($(this).val() == null || $(this).val() == '') {
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}
});

/*
 * text 验证value非空（移除两端空格）
 */
$('[wlzAuth=txtValEmpty]').live('blur', function() {
	$(this).val($.trim($(this).val())); //去除空格

	var str = $(this).val();
	var flag = wlz_authIsEmpty(str);
	if (flag) {
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}
});

/*
 * text 验证两个text框值相同
 * 注：1、要放在一个table里
 *     2、可支持1个table多对textbox，只要wlzAuth属性值能够对应上
 */
$('[wlzAuth^=txtValSame]').live('blur', function() {
	$(this).val($.trim($(this).val())); //去除空格

	var value1 = $(this).val();
	var flag = wlz_authIsEmpty(value1);
	if (flag) {
		$(this).addClass('ui-state-error');
	} else {
		var groupVal = $(this).attr('wlzAuth');
		var value2 = $(this).closest('table').find('[wlzAuth=' + groupVal + ']').not(this).val();
		if (value1 == value2) {
			$(this).closest('table').find('[wlzAuth=' + groupVal + ']').removeClass('ui-state-error');
		} else {
			var value2 = $(this).closest('table').find('[wlzAuth=' + groupVal + ']:last').addClass('ui-state-error');
		}
	}
});

/*
 * select 验证选中option值不为空
 */
$('[wlzAuth=sltTxtEmpty]').live('blur', function() {
	if ($.trim($(this).find('option:selected').text()) == '' || $(this).find('option:selected').text() == null) {
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}
});

/*
 * select 验证选中option不为第一个option
 */
$('[wlzAuth=sltNotFirst]').live('blur', function() {
	if ($(this).find('option:first').val() == $(this).find('option:selected').val()) {
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}
});

/*
 * select 验证option的个数不为0
 */
$('[wlzAuth=sltSize]').live('blur', function() {
	if ($(this).find('option').length == 0) {
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}
});

/*
 * select 验证option的selected个数不为0
 */
$('[wlzAuth=sltHasSelected]').live('blur', function() {
	if ($(this).find('option:selected').length == 0) {
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}
});

/*
 * radio 验证必须有选中项
 */
$('[wlzAuth=radHasChecked]').live('blur', function() {
	var name = $(this).attr('name');
	if($(this).parent().parent().find('[name=' + name + ']:checked').length == 0){
		$(this).addClass('ui-state-error');
	} else {
		$(this).removeClass('ui-state-error');
	}

	$(this).bind('focus', function() {
		$(this).parent().parent().find('[name=' + name + ']').removeClass('ui-state-error');
	});
});

/*
 * checkbox 验证必须有选中项
 * 注：要放在一个table里面
 */
$('[wlzAuth=chkHasChecked]').live('blur', function() {
	if($(this).closest('table').find(':checkbox:checked').length == 0){
		$(this).closest('table').find(':checkbox[wlzAuth]').addClass('ui-state-error');
	} else {
		$(this).closest('table').find(':checkbox[wlzAuth]').removeClass('ui-state-error');
	}

	$(this).bind('focus', function() {
		$(this).closest('table').find(':checkbox[wlzAuth]').removeClass('ui-state-error');
	});
});

/**
 * 验证身份
 * @param idcard
 * @returns
 */
$('[wlzAuth=chkIdcard]').live('blur', function() {
	var val = $(this).val();
	$(this).removeClass('ui-state-error');
	if(!val){
		$(this).addClass('ui-state-error');
	}
	if(!chkIdcard(val)){
		$(this).addClass('ui-state-error');
		alert('身份证号码错误！');
	}
});

/*
 * 身份证验证
 * @param String gets 身份证号码
 * @return boole 通过返回true 失败返回false 
 */
function chkIdcard(gets){
	//该方法由佚名网友提供;

	var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];// 加权因子;
	var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];// 身份证验证位值，10代表X;

	if (gets.length == 15) {   
		return isValidityBrithBy15IdCard(gets);   
	}else if (gets.length == 18){   
		var a_idCard = gets.split("");// 得到身份证数组   
		if (isValidityBrithBy18IdCard(gets)&&isTrueValidateCodeBy18IdCard(a_idCard)) {   
			return true;   
		}   
		return false;
	}
	return false;
	
	function isTrueValidateCodeBy18IdCard(a_idCard) {   
		var sum = 0; // 声明加权求和变量   
		if (a_idCard[17].toLowerCase() == 'x') {   
			a_idCard[17] = 10;// 将最后位为x的验证码替换为10方便后续操作   
		}   
		for ( var i = 0; i < 17; i++) {   
			sum += Wi[i] * a_idCard[i];// 加权求和   
		}   
		valCodePosition = sum % 11;// 得到验证码所位置   
		if (a_idCard[17] == ValideCode[valCodePosition]) {   
			return true;   
		}
		return false;   
	}
	
	function isValidityBrithBy18IdCard(idCard18){   
		var year = idCard18.substring(6,10);   
		var month = idCard18.substring(10,12);   
		var day = idCard18.substring(12,14);   
		var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
		// 这里用getFullYear()获取年份，避免千年虫问题   
		if(temp_date.getFullYear()!=parseFloat(year) || temp_date.getMonth()!=parseFloat(month)-1 || temp_date.getDate()!=parseFloat(day)){   
			return false;   
		}
		return true;   
	}
	
	function isValidityBrithBy15IdCard(idCard15){   
		var year =  idCard15.substring(6,8);   
		var month = idCard15.substring(8,10);   
		var day = idCard15.substring(10,12);
		var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
		// 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法   
		if(temp_date.getYear()!=parseFloat(year) || temp_date.getMonth()!=parseFloat(month)-1 || temp_date.getDate()!=parseFloat(day)){   
			return false;   
		}
		return true;
	}
	
}