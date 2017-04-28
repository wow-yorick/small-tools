/*
 * js的日期格式处理
 * 
 * Copyright (c) Weili Zhu
 *
 * Autor: 朱威力
 * Date: 2011-12-14
 *
 * 用法：直接调用内部函数
 *
 * 备注：
 *
 */

//---------------------------------------------------------------------------
/*
 * string类型转date类型，'g'表示全局匹配，否则只匹配第一个
 */
function StringToDate(str)
{
	var myDate = new Date(Date.parse(str.replace(/-/g,"/")));
	return myDate;
}

/*
 * 获取当前时间，返回格式'YYYY-MM-DD'
 */
function formatDate(myDate)
{
	var year = myDate.getFullYear();
	var month = formatNumber(myDate.getMonth() + 1);
	var day = formatNumber(myDate.getDate());
	myDate = year + '-' + month + '-' + day;
	return myDate;
}

/*
 * 获取两个日期的相差天数，传入string类型 "2010-01-01"
 */
function getDateMinusDay(sDate, eDate)
{
	var sArr = sDate.split("-");
	var eArr = eDate.split("-");
	var sRDate = new Date(sArr[0], sArr[1], sArr[2]);
	var eRDate = new Date(eArr[0], eArr[1], eArr[2]);
	var result = (eRDate-sRDate)/(24*60*60*1000);
	return result;
}

/*
 * 将个位数字前面加'0'
 */
function formatNumber(number)
{
	if(number < 10)
	{
		number = '0' + number;
	}
	return number;
}

//-----------------------------------------------------------

/**
 * 时间对象的格式化;
 * 传入参数strformat  eg: strformat="YYYY-MM-dd hh:mm:ss";
 * @return string strformat
 */
Date.prototype.format = function(strformat)
{
	var o =
	{
		"M+" : this.getMonth() + 1, //月份
		"d+" : this.getDate(), //日
		"h+" : this.getHours(), //小时
		"m+" : this.getMinutes(), //分
		"s+" : this.getSeconds(), //秒
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度
		"S" : this.getMilliseconds() //毫秒
	};
	if (/(y+)/.test(strformat))
	{
		strformat = strformat.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	}
	for (var k in o)
	{
		if (new RegExp("(" + k + ")").test(strformat))
		{
			strformat = strformat.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return strformat;
}

/**
 * 增加天数
 */
Date.prototype.addDays = function(d)
{
	this.setDate(this.getDate() + d);
	return this;
};

/**
 * 减去天数
 */
Date.prototype.minusDays = function(d)
{
	this.setDate(this.getDate() - d);
	return this;
};

/**
 * 增加星期
 */
Date.prototype.addWeeks = function(w)
{
	this.addDays(w * 7);
	return this;
};

/**
 * 减去星期
 */
Date.prototype.addWeeks = function(w)
{
	this.minusDays(w * 7);
	return this;
};

/**
 * 增加月份
 */
Date.prototype.addMonths= function(m)
{
	var d = this.getDate();
	this.setMonth(this.getMonth() + m);
	if (this.getDate() < d)
	{
		this.setDate(0);
	}
	return this;
};

/**
 * 减去月份
 */
Date.prototype.minusMonths = function(m)
{
	var d = this.getDate();
	this.setMonth(this.getMonth() - m);
	if (this.getDate() < d)
	{
		this.setDate(0);
	}
	return this;
};

/**
 * 增加年份
 */
Date.prototype.addYears = function(y)
{
	var m = this.getMonth();
	this.setFullYear(this.getFullYear() + y);
	if (m < this.getMonth()) 
	{
		this.setDate(0);
	}
	return this;
};

/**
 * 减去年份
 */
Date.prototype.addYears = function(y)
{
	var m = this.getMonth();
	this.setFullYear(this.getFullYear() - y);
	if (m < this.getMonth()) 
	{
		this.setDate(0);
	}
	return this;
};