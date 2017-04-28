<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<?php include './common/header.php'; ?>
<!-- BEGIN BODY -->
<body class="page-header-fixed page-full-width">
	<!-- BEGIN CONTAINER -->   
	<div class="page-container" >
		<!-- BEGIN PAGE -->
		<div class="page-content">
		<div class="portlet box blue">
		<div class="portlet-title">
		     <div class="caption"><i class="icon-reorder"></i>数据详情</div>
		</div>
		<div class="portlet-body form">
			<form action="" data-method-url='' method="POST" 
			class="data_formDetail form-horizontal" novalidate="novalidate" data-keyid=""
			editType="" jsonDetail='' >
			<!-- 表单主体 开始  -->
			<div class="form-body">
	
			<!-- 表格样式表单 开始 -->
				<div class="tableForm">
				<table class="table table-bordered ">
<!-- MODIFY START -->
	 			<caption><span class="left">&nbsp;</span>数据字典<span class="right">&nbsp;</span></caption>
<!-- MODIFY END -->
				<tbody>
<!-- MODIFY START -->
				   <tr class="gradeX gradeY">
						<td class="lightgrey"><label class="control-label">类型:</label></td>
						<td >
							<select class="form-control input-sm" data-validate="{required:'true'}"  name="type">
                        <option value="">--请选择--</option>
							</select>
						</td>
						<td class="lightgrey"></td>
						<td class="lightgrey"></td>
				   </tr>
				   <tr class="gradeX gradeY">
						<td><label class="control-label">序列编码:</label></td>
						<td>
						     <input class="form-control" name="seqno" data-validate="{required:true}" data-message="{required:'序列编码不能为空！'}"  type="text" />
						</td>
		
						<td ><label class="control-label">排序:</label></td>
						<td>
						     <input class="form-control" name="seq" data-validate="{required:true}"   type="text" />
						</td>
				   </tr>
				   <tr class="gradeX gradeY">
						<td><label class="control-label">名称:</label></td>
						<td>
						     <input class="form-control" name="name"   data-validate="{required:true}"   type="text" />
						</td>
		
						<td><label class="control-label">值:</label></td>
						<td>
						     <input class="form-control" name="value"  type="text" />
						</td>
				   </tr>
<!-- MODIFY END -->
				</tbody>
				</table>
	
				</div>
			<!-- 表格样式表单 结束 -->
				</div>
			<!-- 表单主体 结束  -->
	
			<!-- 表单操作 开始  -->
			 <div class="modal-footer">
			 <a type="button" class="btn default" href="">返回</a>
			    <button type="submit" class="btn blue submitBtn">确认</button>
			 </div>
			<!-- 表单操作 开始  -->
			</form>
		</div>
		</div>
		</div>
		<!-- END PAGE -->    
	</div>
	<!-- END CONTAINER -->
	
<?php include './common/loadjs.php'; ?>

<script type="text/javascript">

Detail().init();

var cusVali = {};

formValidate(".data_formDetail").init(cusVali);

//FormDatePicker.init(); 

</script>

<?php include './common/footer.php'; ?>

</body>
<!-- END BODY -->
</html>

