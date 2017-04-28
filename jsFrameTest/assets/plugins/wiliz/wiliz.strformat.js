

/*
 * 将字符串前后空格，用空字符串代替
 */
String.prototype.trim = function() {
    return this.replace(/^\\s+|\\s+$/g,"");   
};

/*
 * 去除字符串的左侧的空格
 */
String.prototype.ltrim = function() {
	return this.replace(/(^\\s*)/g,"");
};

/*
 * 去除字符串的右侧的空格
 */
String.prototype.rtrim = function() {
	return this.replace(/(\\s*$)/g,"");
};

/*
 * 去除字符串中的所有非数字，返回数字
 */
String.prototype.getNumber = function() {
	return this.replace(/[\\D]/g,'');
};

/*
 * 将字符串转换成指定的进制数，默认为10进制
 * @param {Object} base
 */
String.prototype.toInt = function(base) {
	return parseInt(this,base||10);
};

/*
 * 去除字符串两端的空白字符，并且把其他地方的两个以上相连的空白字符变为一个空白字符
 */
String.prototype.clean = function() {
	return this.replace(/\\s+/g,' ').trim();
};

/*
 * 检查指定的字符串是否在本字符串中存在(即是否是子串)
 * @param {Object} string
 * @param {Object} separator
 */
String.prototype.contains = function(string,separator) {
	return (separator)?(separator+this+separator).indexOf(separator+string+separator)>-1:this.indexOf(string)>-1;
};

/*
 * 将当前字符串用一个正则表达式做匹配测试
 * @param {Object} regex
 * @param {Object} params
 */
String.prototype.test = function(regex,params) {
	return ((typeof regex == "string")?new RegExp(regex,params):regex).test(this);
};

/*
 * 返回字字符串的Unicode编码的长度
 */
String.prototype.uniLength = function() {
	return this.replace(/[^\\x00-\\xff]/g, '**').length;
};

/*
 * 按Unicode编码取子字符串，原function uniSubstr (astr, s, len)
 */
String.prototype.uniSubstr = function(start, len) {
	var i = 0, ss = start, tempStr, returnStr = "", a;
	while (i < len) {
		tempStr = this.substr(ss, 1);
		if (tempStr == "") {
			break;
		}
		returnStr += tempStr;
		a = tempStr.uniLength();
		i = i + a;
		ss += 1;
	}
	return returnStr;
};

/*
 * 获取最大长度+".."格式的字符
 * @param {Object} str
 * @param {Object} len
 */
String.prototype.uniLeft = function(len, suffix) {
	if (!suffix) {
		suffix = "";
	}
	return this.uniLength()>len?this.uniSubstr(0, len-suffix.uniLength())+suffix:String(this); //this.len 要> sufix.len
};

/*
 * 编码html
 */
String.prototype.htmlEncode=function(){
	return this.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/\\"/g,"&#34;").replace(/\\'/g,"&#39;");
};

/*
 * 解码html
 */
String.prototype.htmlDecode=function(){
	return this.replace(/\\&amp\\;/g, '\\&').replace(/\\&gt\\;/g, '\\>').replace(/\\&lt\\;/g, '\\<').replace(/\\&quot\\;/g, '\\\'').replace(/\\&\\#39\\;/g, '\\\'');
};

/*
 * 补充左空字符，支持中文
 * @param {Object} totalWidth 总宽度
 * @param {Object} paddingChar 补全字符
 */
String.prototype.padLeft = function(totalWidth, paddingChar){
	if (!paddingChar) {
		paddingChar = " ";
	}
	return this._PadHelper(totalWidth, paddingChar, false);
};

/*
 * 补充右空字符，支持中文
 * @param {Object} totalWidth 总宽度
 * @param {Object} paddingChar 补全字符
 */
String.prototype.padRight = function(totalWidth, paddingChar){
	if (!paddingChar) {
		paddingChar = " ";
	}
	return this._PadHelper(totalWidth, paddingChar, true);
};

/*
 * 补全字符方法中转
 */
String.prototype._PadHelper = function(totalWidth, paddingChar, isRightPadded){
	var size = this.replace(/[^\x00-\xff]/g,"**").length; //将匹配中文字符，替换成**，表示两个字符
	if (size < totalWidth) {
		var paddingString = new String();
		for (i = 1; i <= (totalWidth - size); i++) {
			paddingString += paddingChar;
		}
		if (isRightPadded) {
			return (this + paddingString);
		} else {
			return (paddingString + this);
		}
	} else {
		// BUG，直接return this 有时候会有问题
		return this.toString();
		//return this;
	}
};

/*
 * 把小数点后面的全部都为0的去掉
 */
String.prototype.decimal = function(num){
	num = num || 0;
	var lin = "";
	for(var i=0;i<num;i+=1){
		lin = lin + "0";
	}
	var str = this.replace(/^(\\d+).[0]?$/g,"$1");
	if(str.indexOf(".")>-1){
		if(num){
			var n = str.split(".");
			str = n[0] + "." + (n[1] + lin).slice(0,num);
		}
		else{
			return str;
		}
	}
	else{
		str = str + (num?"." + lin:"");
	}
	return str;
};