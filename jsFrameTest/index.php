<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<!--[if lt IE 9]>
	<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
<![endif]-->
<?php include './common/header.php'; ?>
<!-- BEGIN BODY -->
<body class="page-header-fixed page-full-width">
	<!-- BEGIN CONTAINER -->   
  <div class="page-container" data-method-url='' data-btnstatus='<?php echo json_encode(array(
				'init' => array('btnAdd'),
				'datacheck' =>array('btnModify','btnDelete','btnView','btnTest'),
				'fieldstatus' => array(
					'btnTest'=> array('name'=>'管理员')
				)
			)); ?>'>
		<!-- BEGIN PAGE -->
		<div class="page-content">
<div class="row">

<!-- form detail start -->
<div id="form-detail" class="tab-pane active">

  <div class="portlet box blue">

    <div class="portlet-title">

      <div class="caption"><i class="icon-reorder"></i>Form Sample</div>

      <div class="tools">

        <a class="collapse" href="javascript:;"></a>

        <a class="config" data-toggle="modal" href="#portlet-config"></a>

        <a class="reload" href="javascript:;"></a>

        <a class="remove" href="javascript:;"></a>

      </div>

    </div>

    <div class="portlet-body form">

      <!-- BEGIN FORM-->

      <form class="horizontal-form" action="#">

        <h3 class="form-section">Person Info</h3>

        <div class="row-fluid">

          <div class="span6 ">

            <div class="control-group">

              <label for="firstName" class="control-label">First Name</label>

              <div class="controls">

                <input type="text" placeholder="Chee Kin" class="m-wrap span12" id="firstName">

                <span class="help-block">This is inline help</span>

              </div>

            </div>

          </div>

          <!--/span-->

          <div class="span6 ">

            <div class="control-group error">

              <label for="lastName" class="control-label">Last Name</label>

              <div class="controls">

                <input type="text" placeholder="Lim" class="m-wrap span12" id="lastName">

                <span class="help-block">This field has error.</span>

              </div>

            </div>

          </div>

          <!--/span-->

        </div>

        <!--/row-->

        <div class="row-fluid">

          <div class="span6 ">

            <div class="control-group">

              <label class="control-label">Gender</label>

              <div class="controls">

                <select class="m-wrap span12">

                  <option value="">Male</option>

                  <option value="">Female</option>

                </select>

                <span class="help-block">Select your gender.</span>

              </div>

            </div>

          </div>

          <!--/span-->

          <div class="span6 ">

            <div class="control-group">

              <label class="control-label">Date of Birth</label>

              <div class="controls">

                <input type="text" placeholder="dd/mm/yyyy" class="m-wrap span12">

              </div>

            </div>

          </div>

          <!--/span-->

        </div>

        <!--/row-->        

        <div class="row-fluid">

          <div class="span6 ">

            <div class="control-group">

              <label class="control-label">Category</label>

              <div class="controls">

                <div class="select2-container span12 select2_category" id="s2id_autogen1"><a tabindex="-1" class="select2-choice select2-default" onclick="return false;" href="javascript:void(0)">   <span>Choose a Category</span><abbr style="display: none;" class="select2-search-choice-close"></abbr>   <div><b></b></div></a><input type="text" class="select2-focusser select2-offscreen" id="s2id_autogen2"><div style="display:none" class="select2-drop select2-with-searchbox">   <div class="select2-search">       <input type="text" class="select2-input" autocomplete="off" tabindex="1">   </div>   <ul class="select2-results">   </ul></div></div><select tabindex="-1" data-placeholder="Choose a Category" class="span12 select2_category select2-offscreen">

                  <option value=""></option>

                  <option value="Category 1">Category 1</option>

                  <option value="Category 2">Category 2</option>

                  <option value="Category 3">Category 5</option>

                  <option value="Category 4">Category 4</option>

                </select>

              </div>

            </div>

          </div>

          <!--/span-->

          <div class="span6 ">

            <div class="control-group">

              <label class="control-label">Membership</label>

              <div class="controls">                                                

                <label class="radio">

                <div class="radio"><span><input type="radio" value="option1" name="optionsRadios2"></span></div>

                Free

                </label>

                <label class="radio">

                <div class="radio"><span class="checked"><input type="radio" checked="" value="option2" name="optionsRadios2"></span></div>

                Professional

                </label>  

              </div>

            </div>

          </div>

          <!--/span-->

        </div>

        <!--/row--> 

        <h3 class="form-section">Address</h3>

        <div class="row-fluid">

          <div class="span12 ">

            <div class="control-group">

              <label class="control-label">Street</label>

              <div class="controls">

                <input type="text" class="m-wrap span12">

              </div>

            </div>

          </div>

        </div>

        <div class="row-fluid">

          <div class="span6 ">

            <div class="control-group">

              <label class="control-label">City</label>

              <div class="controls">

                <input type="text" class="m-wrap span12"> 

              </div>

            </div>

          </div>

          <!--/span-->

          <div class="span6 ">

            <div class="control-group">

              <label class="control-label">State</label>

              <div class="controls">

                <input type="text" class="m-wrap span12"> 

              </div>

            </div>

          </div>

          <!--/span-->

        </div>

        <!--/row-->           

        <div class="row-fluid">

          <div class="span6 ">

            <div class="control-group">

              <label class="control-label">Post Code</label>

              <div class="controls">

                <input type="text" class="m-wrap span12"> 

              </div>

            </div>

          </div>

          <!--/span-->

          <div class="span6 ">

            <div class="control-group">

              <label class="control-label">Country</label>

              <div class="controls">

                <select class="m-wrap span12"></select>

              </div>

            </div>

          </div>

          <!--/span-->

        </div>

        <div class="form-actions">

          <button class="btn blue" type="submit"><i class="icon-ok"></i> Save</button>

          <button class="btn" type="button">Cancel</button>

        </div>

      </form>

      <!-- END FORM--> 

    </div>

  </div>

</div>
<!-- form detail end -->

</div>
			<!-- BEGIN PAGE HEADER-->
			<div class="row">
				<div class="col-md-12">
<!-- MODIFY START -->
导航条
<!-- MODIFY END -->
				</div>
			</div>
			<!-- END PAGE HEADER-->

			 <!-- BEGIN SEARCH AREA-->
			 <div id="searchArea" class="row" data-searchdata=''>
			 <div class="col-md-12">
			 <div class="portlet box light-grey">
Search AREA
			 </div></div></div>
			 <!-- END SEARCH AREA-->
			 <!-- BEGIN DATA AREA-->
			 <div id="dataArea" class="row">
			    <div class="col-md-12">
			       <!-- BEGIN EXAMPLE TABLE PORTLET-->
			       <div class="portlet box light-grey">
                    <!-- datatable start -->
                        <div class="portlet-body">
                          <table class="table table-striped table-bordered table-hover " id="models-data" >
                        <thead>
                           <tr>
                              <th style="width:8px;"> <input class="group-checkable" type="checkbox" data-set="#models-data .checkboxes"></th>
                              <th>Username</th>
                              <th class="hidden-480">Email</th>
                              <th class="hidden-480">Points</th>
                              <th class="hidden-480">Joined</th>
                              <th ></th>
                           </tr>
                        </thead>
                        <tbody>
                           <tr class="odd gradeX">
                              <td><input type="checkbox" class="checkboxes" value="1" /></td>
                              <td>shuxer</td>
                              <td class="hidden-480"><a href="mailto:shuxer@gmail.com">shuxer@gmail.com</a></td>
                              <td class="hidden-480">120</td>
                              <td class="center hidden-480">12 Jan 2012</td>
                              <td ><span class="label label-sm label-success">Approved</span></td>
                           </tr>
                           <tr class="odd gradeX gradeY">
                              <td><input type="checkbox" class="checkboxes" value="1" /></td>
                              <td>shuxer</td>
                              <td class="hidden-480"><a href="mailto:shuxer@gmail.com">shuxer@gmail.com</a></td>
                              <td class="hidden-480">120</td>
                              <td class="center hidden-480">12 Jan 2012</td>
                              <td ><span class="label label-sm label-success">Approved</span></td>
                           </tr>
                        </tbody>
                          </table>
                          </div>
                    <!-- dataTable end -->
			       </div>
			       <!-- END EXAMPLE TABLE PORTLET-->
			    </div>
			 </div>
			 <!-- END DATA AREA-->
        <!-- actions bar START -->
<div class="actions">
    <a class="btn blue" id="btnAdd" data-toggle="modal" href="#portlet-config"><i class="icon-pencil"></i>新增</a>
    <a class="btn green" id="btnModify"  data-toggle="modal" href="#portlet-config"><i class="icon-pencil"></i>修改</a>
    <a class="btn red" id="btnDelete"  data-toggle="modal" href="#portlet-config"><i class="icon-pencil"></i>删除</a>
    <a class="btn yellow" id="btnView"  data-toggle="modal" href="#portlet-config"><i class="icon-pencil"></i>详情</a>
</div>
        <!-- actions bar END -->
		</div>
		<!-- END PAGE -->    
	</div>
	<!-- END CONTAINER -->


<?php include './common/loadjs.php'; ?>

<script type="text/javascript">
!$(document).ready(function(){
	var settings = {
		 //"bServerSide": true,
		 //服务请求地址
		 //"sAjaxSource": "",
		 //须接收的字段，对应各列

	};

	TableManaged('',function(tabObj){}).init(settings);
	//时间控件启动
	FormDatePicker.init(); 
	FormDatetimePicker.init(); 

    btnAdd.prototype.specAct = function(){
        btnAdd.superclass.specAct.call(this);
    }
});

</script>
<?php include './common/footer.php'; ?>
</body>
<!-- END BODY -->
</html>
