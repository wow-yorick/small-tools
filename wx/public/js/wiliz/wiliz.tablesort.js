/*
 * jQuery TableSort Plus @requires jQuery
 * 
 * Copyright (c) Weili Zhu
 *
 * Autor: 朱威力
 * Date: 2011-07-20
 *
 */

//---------------------------------------------------------------------------

/*
 * 排序功能初始化
 * @parameter string tableId
 */
function Sort_Initialize(tableId){
	//给table添加列号属性
	var col_num = 1;
	$('#'+ tableId).find('th').each(function(){
		$(this).attr('col_num', col_num);
		col_num++;
	});

	//给table添加行号属性
	var row_num = 1;
	$('#'+ tableId).find('tbody').find('tr').each(function(){
		$(this).attr('row_num', row_num);
		row_num++;
	});

	//给table的每个td添加行号和列号属性
	var row_num = 1;
	$('#'+ tableId).find('tbody').find('tr').each(function(){
		var col_num = 1;
		$(this).find('td').each(function(){
			$(this).attr('row_num', row_num);
			$(this).attr('col_num', col_num);
			col_num++;
		});
		row_num++;
	});
	
	//给每个标题添加排序图标
	$('#'+ tableId).find('th').each(function(){
		//'value=-1'表示升序,'1'表示降序
		var htmlStr = '<label id="ColNumAsc_' + col_num + '" class="jSort" value="-1" style="display:none";>▼</label>' + '<label id="ColNumDesc_' + col_num + '" class="jSort" value="1" style="display:none";>▲</label>';
		$(this).append(htmlStr);
	});
}

/*
 * 升降序切换,返回排序类型  
 * @parameter object obj  'this'当前对象
 * return int $sort_type  '-1':升序  ;  '1'：降序
 */
function Sort_How(obj){
	var sort_type = null;
	if($(obj).find('.jSort:visible').length > 0){ //点击自身列时,则升降序切换
		var v = $(obj).find('.jSort:visible').val();
		sort_type = -v;
		$(obj).find('.jSort:visible').hide();
		$(obj).find('.jSort[value=' + sort_type + ']').show();
	}
	else{ //点击其它列时,则将点击的列降序排列
		sort_type = -1;
		$(obj).closest('tr').find('.jSort:visible').hide();
		$(obj).find('.jSort[value='+ sort_type + ']').show();
	}
	return sort_type;
}

/*
 * 冒泡排序
 * @parameter array myArr DOM选择列中,取出每行里内容所组成的数组
 * @parameter array indexArr 'myArr'数组里每个元素对应的行号Row_Num所组成的数组
 * @parameter int sort_type  '-1':升序  ;  '1'：降序
 */
function Sort_Bubble(myArr, indexArr, sort_type){
	var size = myArr.length;
	for(i=0; i<size-1; i++){
		for(j=i+1; j<size; j++){
			if(sort_type == -1){ //升序
				if(myArr[j] < myArr[i]){
					var temp = myArr[i];
					myArr[i] = myArr[j];
					myArr[j] = temp;

					var temp = indexArr[i];
					indexArr[i] = indexArr[j];
					indexArr[j] = temp;
				}
			}
			else if(sort_type == 1){ //降序
				if(myArr[j] > myArr[i]){
					var temp = myArr[i];
					myArr[i] = myArr[j];
					myArr[j] = temp;

					var temp = indexArr[i];
					indexArr[i] = indexArr[j];
					indexArr[j] = temp;
				}
			}
		}
	}
}

/*
 * 冒泡排序,仅用于包含中文时调用
 */
function Sort_Bubble_Chinese(myArr, indexArr, sort_type){
	var size = myArr.length;
	for(i=0; i<size-1; i++){
		for(j=i+1; j<size; j++){
			if(sort_type == -1){ //升序
				if(myArr[j].localeCompare(myArr[i]) < 0){
					var temp = myArr[i];
					myArr[i] = myArr[j];
					myArr[j] = temp;

					var temp = indexArr[i];
					indexArr[i] = indexArr[j];
					indexArr[j] = temp;
				}
			}
			else if(sort_type == 1){ //降序
				if(myArr[j].localeCompare(myArr[i]) > 0){
					var temp = myArr[i];
					myArr[i] = myArr[j];
					myArr[j] = temp;

					var temp = indexArr[i];
					indexArr[i] = indexArr[j];
					indexArr[j] = temp;
				}
			}
		}
	}
}

/*
 * 'th'标签的onclick事件,执行排序功能
 * @parameter object obj 点击的'th'标签当前对象
 * @parameter int content_type  'number/string/chinese/date'
 */
function Sort_Run(obj, content_type){
	var table_Id = $(obj).closest('table').attr('id'); //排序table的Id
	var col_num = $(obj).attr('col_num'); //点击的列号
	var sort_type = Sort_How(obj); //返回排序类型
	var contentArr = new Array();
	var indexArr = new Array();
	//将选择列的每个'td'标签里内容放入contentArr数组,行号放入indexArr数组
	$('#' + table_Id).find('tbody').find('tr').each(function(){
		var text = $(this).find('td[col_num=' + col_num + ']').text();
		var row_num = $(this).find('td[col_num=' + col_num + ']').attr('row_num');
		contentArr.push(text);
		indexArr.push(row_num);
	});
	//不同类型排序执行
	switch(content_type){
		case 'number':  //int、float都支持
			var tempNumber = -Number.MAX_VALUE; //处理空值问题
			var size = contentArr.length;
			for(i=0; i<size; i++){
				if(contentArr[i] == ''){
					contentArr[i] = tempNumber;
				}
				contentArr[i] = parseFloat(contentArr[i]); //将string转换成float类型
			}
			Sort_Bubble(contentArr, indexArr, sort_type);
			Sort_Show(table_Id, indexArr);
			break;
		case 'string': 
			Sort_Bubble(contentArr, indexArr, sort_type);
			Sort_Show(table_Id, indexArr);
			break;
		case 'datetime': //时间类型：'0000-00-00 00:00:00',不一样可以自己转换下
			var tempTime = '0000-00-00 00:00:00'; //处理空值问题
			var size = contentArr.length;
			for(i=0; i<size; i++){
				if(contentArr[i] == ''){
					contentArr[i] = tempTime;
				}
				contentArr[i] = StringToDate(contentArr[i]); //将string转换成date类型
			}
			Sort_Bubble(contentArr, indexArr, sort_type);
			Sort_Show(table_Id, indexArr);
			break;
		case 'datetime_custom1': //传入的格式为'09:00',只有小时和分钟
			var tempTime = '0000-00-00 00:00:00'; //处理空值问题
			var size = contentArr.length;
			for(i=0; i<size; i++){
				if(contentArr[i] == ''){
					contentArr[i] = tempTime;
				}
				else{
					contentArr[i] = '2011-07-20 ' + contentArr[i] + ':00';
				}
				contentArr[i] = StringToDate(contentArr[i]); //将string转换成date类型
			}
			Sort_Bubble(contentArr, indexArr, sort_type);
			Sort_Show(table_Id, indexArr);
			break;
		case 'datetime_custom2': //传入的格式为'09:00',只有小时和分钟
			var tempTime = '0000-00-00 00:00:00'; //处理空值问题
			var size = contentArr.length;
			for(i=0; i<size; i++){
				if(contentArr[i] == ''){
					contentArr[i] = tempTime;
				}
				else{
					contentArr[i] = contentArr[i] + ' 00:00:00';
				}
				contentArr[i] = StringToDate(contentArr[i]); //将string转换成date类型
			}
			Sort_Bubble(contentArr, indexArr, sort_type);
			Sort_Show(table_Id, indexArr);
			break;
		case 'chinese':
			Sort_Bubble_Chinese(contentArr, indexArr, sort_type);
			Sort_Show(table_Id, indexArr);
			break;
		default :
			var size = contentArr.length;
			for(i=0; i<size; i++){
				contentArr[i] = contentArr[i].toString(); //默认都转换成string类型
			}
			Sort_Bubble(contentArr, indexArr, sort_type);
			Sort_Show(table_Id, indexArr);
	}
}

/*
 * 对应排序好的新的Row_Num数组'indexArr',修改页面DOM
 * @parameter string table_Id
 * @parameter array indexArr
 */
function Sort_Show(table_Id, indexArr){
	var size = indexArr.length;
	for(i=0; i<size; i++){
		var tempRowNum = indexArr.pop(); //删除并返回数组的第一个元素
		var jTrElement = $('#'+ table_Id).find('tbody').find('tr[row_num=' + tempRowNum + ']').detach();
		$('#'+ table_Id).find('tbody').prepend(jTrElement);
	}
}

/*
 * string类型转date类型,string格式(2011-07-20 12:00:00)
 * return datetime myDate
 */
function StringToDate(str){
	var myDate = new Date(Date.parse(str.replace(/-/g,"/")));
	return myDate;
}