/*
 * js�����ڸ�ʽ����
 * 
 * Copyright (c) Weili Zhu
 *
 * Autor: ������
 * Date: 2011-12-14
 *
 * �÷���ֱ�ӵ����ڲ�����
 *
 * ��ע��
 *
 */

//---------------------------------------------------------------------------
/*
 * string����תdate���ͣ�'g'��ʾȫ��ƥ�䣬����ֻƥ���һ��
 */
function StringToDate(str)
{
	var myDate = new Date(Date.parse(str.replace(/-/g,"/")));
	return myDate;
}

/*
 * ��ȡ��ǰʱ�䣬���ظ�ʽ'YYYY-MM-DD'
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
 * ��ȡ�������ڵ��������������string���� "2010-01-01"
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
 * ����λ����ǰ���'0'
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
 * ʱ�����ĸ�ʽ��;
 * �������strformat  eg: strformat="YYYY-MM-dd hh:mm:ss";
 * @return string strformat
 */
Date.prototype.format = function(strformat)
{
	var o =
	{
		"M+" : this.getMonth() + 1, //�·�
		"d+" : this.getDate(), //��
		"h+" : this.getHours(), //Сʱ
		"m+" : this.getMinutes(), //��
		"s+" : this.getSeconds(), //��
		"q+" : Math.floor((this.getMonth() + 3) / 3), //����
		"S" : this.getMilliseconds() //����
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
 * ��������
 */
Date.prototype.addDays = function(d)
{
	this.setDate(this.getDate() + d);
	return this;
};

/**
 * ��ȥ����
 */
Date.prototype.minusDays = function(d)
{
	this.setDate(this.getDate() - d);
	return this;
};

/**
 * ��������
 */
Date.prototype.addWeeks = function(w)
{
	this.addDays(w * 7);
	return this;
};

/**
 * ��ȥ����
 */
Date.prototype.addWeeks = function(w)
{
	this.minusDays(w * 7);
	return this;
};

/**
 * �����·�
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
 * ��ȥ�·�
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
 * �������
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
 * ��ȥ���
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