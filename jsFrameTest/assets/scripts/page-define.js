"use strict";
Function.prototype.getName =  function(){
    return this.name || this.toString().match(/function\s*([^(]*)\(/)[1]
}

/**
 * 命名空间定义
 * 
 * @access public
 * @return void
 */
var PAGE = PAGE || {};
PAGE.namespace = function(ns_string) {
    var parts = ns_string.split('.'),
    parent = PAGE,
    i;

    if(parts[0] === 'PAGE'){
        parts = parts.slice(1);
    }

    for(i = 0;i < parts.length; i++){
        if(typeof parent[parts[i]] === 'undefined') {
                parent[parts[i]] = {};
        }
        parent = parent[parts[i]];
    }

    console.log("parent-namespace:",parent);
    return parent;
}

/**
 * 按钮工厂类
 *支持创建新对象和新类 
 * @access public
 * @return void
 */
function BtnSuper(options){
    //公共
    this.button = options.button || '';
    this.target = options.target || '';
    this.resource = options.resource || '#models-data';

    //私有
    this._keyId = "";
    this.init();
}

BtnSuper.prototype = {
    init: function() {
        var that = this
        $(this.button).bind('click',function(){
            that.specAct();
        });
    }

    ,eventAction: function() {
        this.specAct(keyId);
    }

    ,getKeyId : function(){
        var that = this;
        var check = $(this.resource).find('tbody tr .checkboxes:checked');

        that._keyId ="";
        if(check.length > 1){
            check.each(function(){
                that._keyId+=','+$(this).val();
            });
            that._keyId = that._keyId.substr(1);
        }else if(check.length == 1){
            that._keyId = check.val();
        }else{
            that._keyId = "";
        }
        return that._keyId;
    }

    ,specAct: function(keyId){
        var keyId = this.getKeyId();
        var dialogId = $(this.button).attr("href").substr(1);

        pagelog(["keyId:"+keyId]);
        if("" == keyId){
            BtnSuper.viewTemplet(dialogId,"请选择一项!",this.target);
            return false;
        }
        BtnSuper.viewTemplet(dialogId,this.title,this.target);
    }

};

//存放按钮的实例
BtnSuper.instance = (function($){
    var btns = {};
    return {
        get:function(key){
            return btns[key];
        }
        ,set:function(key,obj){
            btns[key] = obj;
            return btns[key];
        }
    }
})(window.jQuery) 

BtnSuper.viewTemplet = function(dialogId,title,contentId){
    var dialogId = dialogId || 'portlet-config',
        title = title || '',
        contentId = contentId || '',
        viewHtml ='<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->'               
   +'<div class="modal fade" id="'+dialogId+'" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">'
      +'<div class="modal-dialog">'
         +'<div class="modal-content">'
      +'<div class="modal-header">'
         +'<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>'
         +'<h4 class="modal-title">'+title+'</h4>'
      +'</div>'
      +'<div class="modal-body">'
      +'</div>'
      +'<div class="modal-footer">'
         +'<button type="button" class="btn blue" id="dialogSubmit">确认</button>'
         +'<button type="button" class="btn default" id="dialogClose" data-dismiss="modal">关闭</button>'
      +'</div>'
         +'</div>'
         +'<!-- /.modal-content -->'
      +'</div>'
      +'<!-- /.modal-dialog -->'
   +'</div>'
   +'<!-- /.modal -->'
   +'<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->';

    var dialogObj = $("#"+dialogId);
    if(dialogObj.length <= 0){
        $('body').append(viewHtml);
    }
    if('' != contentId) {
        $("#"+contentId).appendTo(dialogObj.find('.modal-body'));
        pagelog($("#"+contentId));
    }

    dialogObj.find(".modal-title").text(title);

    //弹出层关闭移除dialog
    $('body').on("hide.bs.modal",".modal", function (event) {
        if(event.namespace == 'bs.modal'){
            dialogObj.find(".modal-title").text("");
            dialogObj.find(".modal-body").html("");
            //必须解除绑定,不然会出现绑定累加
            $('body').off("hide.bs.modal",".modal");
        }
    });

    return dialogId;
}



//静态工厂方法
BtnSuper.factory = function(constrFuc,argObj){

    var instance = "";

    //如果传入的是字符串,在instance属性中查找对象
    //找到则返回,否则返回false
    if(typeof constrFuc == "string"){
        instance = BtnSuper.instance.get(constrFuc);
        return instance ? instance:false; 
    }

    if(typeof constrFuc !== "function") {
        throw new TypeError(constrFuc+" doesn't exist");
    }

    extend(constrFuc, BtnSuper);
    if(typeof argObj == "object" && argObj.button != undefined) {
        instance = new constrFuc(argObj);
    }else{
        instance = new constrFuc(argObj);
    }

    BtnSuper.instance.set(constrFuc.getName(),instance);

    return instance;
}

//BUTTON END 


var TableManaged = function (selecter,callback) {
    if(selecter =='' || typeof(selecter) !== 'string'){
        selecter = "#models-data";  
    }

    var tabObj = $(selecter);
    if(typeof callback  == 'function'){
        callback(tabObj);
    }

    return {
        init: function (settings) {
            if (!jQuery().dataTable) {
                return;
            }

            if(settings =="" && typeof(settings) != 'object'){
                var settings = {};
            }

            var defaults = {
                //'sScrollX': '100%'
                //,'sScrollXInner': '98%'
                //,'sScrollY': '410px'
                //'bAutoWidth': false //自动宽度
                //,'bPaginate': false //分页功能
                //,'bInfo': false //总数信息
                //,'bSort': true //排序栏
                //,'bLengthChange': false //是否允许用户通过一个下拉列表来选择分页后每页的行数
                //,'bInfo': false //页脚功能
                //,'bStateSave': true //保存状态到cookie
                //,'aoColumnDefs': [
                //{ "bSortable": false, "aTargets": [ 0 ] } //第一列禁止排序
                //]
                'bFilter': true //搜索栏
                ,'iDisplayLength': 5 //每页的行数，每页默认数量:10，-1表示全部
                ,'aLengthMenu': [[5, 10, 15, 20, 50, 100, -1], [5, 10, 15, 20, 50, 100, '全部']] //定义每页显示数据数量
                ,'sPaginationType': 'bootstrap' //分页，一共两种样式。另一种为two_button(是datatables默认bootstrap)
                ,'oLanguage': { //国际化
                    'sLengthMenu': '每页显示 _MENU_ 条记录'
                    ,'sZeroRecords': '抱歉， 没有数据'
                    ,'sInfo': '从 _START_ 到 _END_ /共 _TOTAL_ 条数据'
                    ,'sInfoEmpty': ''
                    ,'sInfoFiltered': '(从 _MAX_ 条数据中检索)'
                    ,'sSearch': '筛选:'
                    ,'sProcessing': '<img src="assets/img/loading.gif" />'
                    ,'oPaginate': {
                        'sFirst': '首页'
                        ,'sPrevious': ''
                        ,'sNext': ''
                        ,'sLast': '尾页'
                    }
                }
                ,"aoColumnDefs": [
                    { "bSortable": false, "aTargets": [ 0 ] }
                ]
                ,"fnCreatedRow": function( nRow, aData, iDataIndex ) {
                    $('td:first',nRow).html('<input type="checkbox" class="checkboxes" value="'+iDataIndex+'" />');
                }
                ,"fnDrawCallback":function(){
                    _singleCheck();
                    _allCheck();
                }
            };


            var settings = $.extend(defaults,settings);
            // begin datatable 
            tabObj.dataTable(settings);

            $(selecter+"_wrapper .dataTables_filter input").addClass("form-control input-medium"); // modify table search input
            $(selecter+"wrapper .dataTables_length select").addClass("form-control input-small"); // modify table per page dropdown
            $(selecter+"_wrapper .dataTables_length select").select2({
                showSearchInput : false //hide search box with special css class
            }); // initialize select2 dropdown
        }
    };

    function _singleCheck(){
        var checkboxes = tabObj.find('tbody tr .checkboxes');
        //具体某一项前面的checkbox，只能选择某一项，不能全选
        checkboxes.uniform();  //jQuery.uniform更新数据

        checkboxes.click(function(){
            checkboxes.parents('tr').removeClass('active'); //移除所有tr的active class
            checkboxes.not($(this)).attr("checked", false); //将除$(this)之外所有的.checkboxes取消选择
            $(this).attr("checked") ? $(this).parents('tr').addClass('active'): $(this).parents('tr').removeClass('active'); 
            $.uniform.update(checkboxes);  //jQuery.uniform更新数据
            //按钮控制
            if(tabObj.find('tbody tr .checkboxes:checked').length > 0){
                BtnToggleEffect.btnAssignEnable('datacheck');
            }else{
                BtnToggleEffect.btnAssignDisable('datacheck');
            }
        });
    }

    function _allCheck(){
        var allcheck = tabObj.find(".group-checkable");
        allcheck.change(function () {
            var set = $(this).attr("data-set");
            var setObj = $(set);
            var checked = $(this).is(":checked");
            setObj.each(function () {
                if (checked) {
                    $(this).attr("checked", true);
                } else {
                    $(this).attr("checked", false);
                }
            });
            $.uniform.update(setObj);
        }); 
    }


};



/**
 * 工具条亮暗控制 
 */
var BtnToggleEffect = (function($){
    var Tools = function(objBtns,strStatusConf){
        this.objBtns = objBtns;
        this.jsonInitConf = $.parseJSON(strStatusConf);

        this.btnInit.apply(this);
    }

    Tools.prototype ={

        constructor: Tools

        ,btnInit : function(){
            if(typeof this.jsonInitConf != 'object'){
                throw new TypeError("参数strStatusConf无法转换为对象!");
            }
            this.btnAllDisable();
            this.btnAssignEnable('init');
        }

        ,btnAllDisable: function(){
            this.objBtns.attr('disabled','disabled');
        }

        ,btnAllEnable:function(){
            this.objBtns.removeAttr('disabled');
        }

        ,btnEnable:function(btnStr){
            $('#'+btnStr).removeAttr('disabled');
        }

        ,btnDisable:function(btnStr){
            $('#'+btnStr).attr('disabled','disabled');
        }

        ,btnAssignEnable:function(btnKey){
            var that = this;
            $.each(that.jsonInitConf[btnKey],function(k,v){
                that.btnEnable(v);
            });
        }

        ,btnAssignDisable:function(btnKey){
            var that = this;
            $.each(that.jsonInitConf[btnKey],function(k,v){
                that.btnDisable(v);
            });
        }

    }   

    //return Tools;
    var btnStatusConf = $("[data-btnstatus]").attr('data-btnstatus'); 
    var toolsSelector = ".actions";
    var btns = $(toolsSelector).find('.btn[id]');

    return new Tools(btns,btnStatusConf);

})(window.jQuery)


/**
 * 异步提交表单和message整合 
 */
var ajaxSubmitAndMsg = (function($){
  if (!$().ajaxSubmit) {
    pagelog('ajaxSubmitAndMsg:ajaxSubmit不存在！');
    return;
  }

  return {
    init:function(objForm,isjump,url){
      var objForm = $(objForm);
      try{
        objForm.ajaxSubmit({
          success:function(data, status, xhr,objForm){
            var msginfo = $.parseJSON(data),
              rurl = url || objForm.attr('data-method-url'),
            msg = $.globalMessenger().post({
                message:msginfo['msg'] 
               ,type:msginfo['success']?'info':'error' 
               ,showCloseButton: true
               ,hideAfter:3
            });
            if(objForm && msginfo['success']){
              window.location.href = rurl;
            }
          }
        });
        
      }catch(e){
        pagelog(e);
      }
    }
  };

    }
)(window.jQuery)

/**
 * dataPacker
 * 
 * @access public
 * @return void
 */
var FormDatePicker = (function(){
  if (!jQuery().datepicker) {
        return;
    }

  $.extend($.fn.datepicker.dates,{
    cn:{
      days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
      daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
      daysMin: ["日", "一", "二", "三", "四", "五", "六", "日"],
      months: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
      monthsShort: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
      meridiem: ["上午", "下午"],
      suffix: ["st", "nd", "rd", "th"],
      today: "今天"
    }
  });
  return {
    init:function(settings,selecter,callback){
      var settings = settings || {};
      var selecter = selecter || ".date-picker";
      var callback = callback || function(){pagelog(["call","back","success"]);};
      var defaultSet = {
          rtl: App.isRTL(),
          language:"cn",
          autoclose: true,
          format: 'yyyy-mm-dd'
        };
      var settings = $.extend(defaultSet,settings);
      $(selecter).datepicker(settings,callback);
    }
  };
})();


/**
 * datatimePacker
 * 
 * @access public
 * @return void
 */
var FormDatetimePicker = (function(){
  if (!jQuery().datetimepicker) {
        return;
    }

  $.extend($.fn.datetimepicker.dates,{
    cn:{
      days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
      daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
      daysMin: ["日", "一", "二", "三", "四", "五", "六", "日"],
      months: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
      monthsShort: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
      meridiem: ["上午", "下午"],
      suffix: ["st", "nd", "rd", "th"],
      today: "今天"
    }
  });
  return {
    init:function(settings,selecter,callback){
      var settings = settings || {};
      var selecter = selecter || ".datetime-picker";
      var callback = callback || function(){pagelog(["call","back","success"]);};
      var defaultSet = {
            isRTL: App.isRTL(),
            format: "yyyy-mm-dd hh:ii",
            autoclose: true,
            language:"cn",
            todayBtn: true,
            startDate: "2013-02-14 10:00",
            pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left"),
            minuteStep: 10
        };
      var settings = $.extend(defaultSet,settings);
      $(selecter).datetimepicker(settings,callback);
    }
  };
})();


/**
 * Detail
 * 
 * @access public
 * @return void
 */
var Detail = function(selecter){

  var selecter = selecter || ".data_formDetail";
  
  return {

    init:function(callback){

      var objForm = $(selecter),

      editType = objForm.attr("editType"),

      jsonDetail = objForm.attr("jsonDetail"),

      baseUrl = objForm.attr('data-method-url'),

      keyid = objForm.attr('data-keyid'),

      callback = callback || function(){pagelog(["call","back:objForm","success"]);};


      switch (editType) {

        case 'add':
          //disabled输入框
          objForm.find('[data-disable]').attr('disabled','disabled');
          //修改form的action属性
          objForm.attr('action', baseUrl+"/create");

          break;

        case 'modify':

          //disabled输入框
          objForm.find('[data-disable]').attr('disabled','disabled');

          //修改form的action属性
          objForm.attr('action', baseUrl+"/edit/"+keyid);

          break;
        case 'detail':
          //移除提交按钮
          objForm.find('.form-control').attr('disabled','disabled');

          objForm.find(".submitBtn").remove();

          break;
      };
      //设置标签默认值
      if (jsonDetail && editType !="add") {

        Detail.setData(objForm,jsonDetail);

      } else {
        // !---------- BEGIN: CUSTOM ---------- //
        pagelog("未获取到jsonDetail");
        // !---------- END  : CUSTOM ---------- //
      };

      if(typeof(callback) == 'function'){
        callback(objForm);
      }   
    }
  };
};

Detail.setData = function(objForm,jsonStr){
  
  try{

    var jsonDataInfo = $.parseJSON(jsonStr);
    
    // !---------- BEGIN: MODIFY ---------- //
    for(var k in jsonDataInfo){
      var axObj = objForm.find("[name="+k+"]"),   
      type = axObj.attr('type');

      if(axObj.length ===1){
        var tag = axObj[0].tagName;
        if(tag =="SELECT"){
          objForm.find("select[name="+k+"] option[value='"+jsonDataInfo[k]+"']").attr("selected",true);
          
        }else{
          objForm.find('[name='+k+']').val(jsonDataInfo[k]);
        };
      }else if(axObj.length >1){
        switch(type){
          case 'radio':
            objForm.find('input:radio[name="'+k+'"][value='+jsonDataInfo[k]+']').attr("checked",true);
            break;
          default:
            //TODO 增加控件类型
            pagelog("未实现的控件！可能是多选框");
        }
      } 
    }
  }catch(e){
    pagelog(e);
  }
  // !---------- END  : MODIFY ---------- //
}


//表单验证
var formValidate = function(selecter){

  var formObj = $(".data_formDetail");

    if(selecter !="" && typeof(selecter) == 'string'){

      formObj = $(selecter);

    }else{

      throw new TypeError("必须传入选择器字符串！");

    }
    
    //绑定键盘enter键提交
    formObj.find('input').keypress(function (e) {

        if (e.which == 13) {

            if (formObj.validate().form()) {

              formObj.submit();

            }

            return false;

        }

    });

  $.extend($.validator.messages, {
    required: "必选字段",
    remote: "请修正该字段",
    email: "请输入正确格式的电子邮件",
    url: "请输入合法的网址",
    date: "请输入合法的日期",
    dateISO: "请输入合法的日期 (ISO).",
    number: "请输入合法的数字",
    digits: "只能输入整数",
    creditcard: "请输入合法的信用卡号",
    equalTo: "请再次输入相同的值",
    accept: "请输入拥有合法后缀名的字符串",
    maxlength: jQuery.validator.format("请输入一个长度最多是 {0} 的字符串"),
    minlength: jQuery.validator.format("请输入一个长度最少是 {0} 的字符串"),
    rangelength: jQuery.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"),
    range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
    max: jQuery.validator.format("请输入一个最大为 {0} 的值"),
    min: jQuery.validator.format("请输入一个最小为 {0} 的值")
  });

  return {
    init:function(settings){

      var defaults = {

            errorElement: 'span', //default input error message container

            errorClass: 'help-block', // default input error message class

            focusInvalid: false, // do not focus the last invalid input

            ignore: "",

            invalidHandler: function (event, validator) { //display error alert on form submit 

              return false;

            },

            highlight: function (element) { // hightlight error inputs

                $(element).addClass('has-error').css('border','1px solid red'); // set error class to the control group

            },

            unhighlight: function (element) { // revert the change done by hightlight

                $(element).removeClass('has-error').css('border','none'); // set error class to the control group

            },

            success: function (label) {

            },

            errorPlacement: function (error, element) {
              //error.insertAfter(element);
            },

            submitHandler: function (formObj) {

          ajaxSubmitAndMsg.init(formObj,true);

            }
      };

      var rules = {},
        msg = {},
        attrSet = {};
      $(formObj).find('[data-validate]').each(function(){
        var name = $(this).attr('name'),
          validate = $(this).attr('data-validate'),
          message = $(this).attr('data-message'),
          validate = '{'+name+':'+validate+'}';

        validate = eval('('+validate+')');

        $.extend(rules,validate); 

        if(message){

          message = '{'+name+':'+message+'}';

          message = eval('('+message+')');

          $.extend(msg,message);

        }
      });

      attrSet = {
        "rules":rules
        ,"massage":msg
      }

      var settings = $.extend(defaults,attrSet,settings);
      
      formObj.validate(settings);
    }
  };  
};


/**
 * pagelog 
 *helper 日志输出 
 * @access public
 * @return void
 */
function pagelog() {

  var msg = '[page.define] ' + Array.prototype.join.call(arguments,'');

  if (window.console && window.console.log) {

    window.console.log(msg);

  }

  else if (window.opera && window.opera.postError) {

    window.opera.postError(msg);

  }

};


/**
 * loadjscssfile 
 *helper 动态加载js或css 
 * @param filename $filename 
 * @param filetype $filetype 
 * @access public
 * @return void
 */
function loadjscssfile(filename,filetype){
    if(filetype == "js"){
        var fileref = document.createElement('script');
        fileref.setAttribute("type","text/javascript");
        fileref.setAttribute("src",filename);
    }else if(filetype == "css"){
        var fileref = document.createElement('link');
        fileref.setAttribute("rel","stylesheet");
        fileref.setAttribute("type","text/css");
        fileref.setAttribute("href",filename);
    }

    if(typeof fileref != "undefined"){
        document.getElementsByTagName("head")[0].appendChild(fileref);
    }
    
}


/**
 * extend 
 *类式继承,支持调用父类方法 
 * @param subClass $subClass 
 * @param superClass $superClass 
 * @access public
 * @return void
 */
function extend(subClass, superClass) {
    var F = function() {};
    F.prototype = superClass.prototype;
    subClass.prototype = new F();
    subClass.prototype.constructor = subClass;

    subClass.superclass = superClass.prototype;
    if(superClass.prototype.constructor == Object.prototype.constructor) {
        superClass.prototype.constructor = superClass;
    }
}

/**
 * 自动实例化工具条中的按钮==搜索参数赋值 
 *TODO 搜索功能重构
 */
    function btnAdd(options){
        btnAdd.superclass.constructor.call(this,options);
    }
    

    function btnModify(options){
        btnModify.superclass.constructor.call(this,options);
    }


    function btnDelete(options){
        btnDelete.superclass.constructor.call(this,options);
    }


    function btnView(options){
        btnView.superclass.constructor.call(this,options);
    }
!(function($){

    function initBtn(){
        var toolsSelector = ".actions";
        var btns = $(toolsSelector).find('.btn[id]');

        //var options = {};
        //options.button = "#btnView";
        //BtnSuper.factory(btnView,options.button);
        btns.each(function(){
            var options = {};
            var strId = $(this).attr('id');
            options.button = "#"+strId;
            var fncCustr = eval(strId);
            BtnSuper.factory(fncCustr,options);
        });
    }

    //INIT APP
    App.init();
    initBtn();

})(window.jQuery)

