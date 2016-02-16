<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>调度管理</title>
	<%@include file="../../common/commonHeader.jspf" %>
    <!-- Data Tables -->
	<link href="${ctx }/static/lib/hplus/css/plugins/jqgrid/ui.jqgrid.css" rel="stylesheet">
	<link href="${ctx }/static/lib/hplus/css/plugins/toastr/toastr.min.css" rel="stylesheet">
	<link href="${ctx }/static/lib/hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
	<style>
        /* Additional style to fix warning dialog position */
        #alertmod_table_list_2 {
            top: 900px !important;
        }
    </style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-title">
                        <h5>系统管理/调度管理</h5>
                    </div>
                    <div class="ibox-content">
                    	<form action="" method="post" id="jobSearchForm">
	                    	<div class="row">
	                            <div class="col-sm-3 m-b-xs">
	                                <div class="input-group m-b">
	                                	<span class="input-group-btn"><button type="button" class="btn btn-default">方法名称</button></span>
	                                    <input name="methodName" type="text" class="form-control" placeholder="方法名称">
	                                </div>
	                            </div>
                                <div class="col-sm-3 m-b-xs">
	                                <div class="input-group m-b">
	                                	<span class="input-group-btn"><button type="button" class="btn btn-default">组名称</button></span>
	                                    <input name="group" type="text" class="form-control" placeholder="组名称">
	                                </div>
	                            </div>
	                            <div class="col-sm-6 m-b-xs">
	                                <div class="input-group m-b">
	                                	<span class="input-group-btn"><button type="button" class="btn btn-default">运行时间</button></span>
	                                    <div class="input-daterange input-group" id="datepicker">
			                                <input id="startTime" type="text" class="form-control" name="startVisitTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss', maxDate:'#F{$dp.$D(\'endTime\')}', readOnly:true})"/>
			                                <span class="input-group-addon">到</span>
			                                <input id="endTime" type="text" class="form-control" name="endVisitTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss', maxDate:'%y-%M-%d %H:%m:%s', minDate:'#F{$dp.$D(\'startTime\')}', readOnly:true})"/>
			                            </div>
	                                </div>
	                            </div>
	                        </div>
                        </form>
                        <div class="row">
                            <div class="col-sm-8 m-b-xs">
                                <button id="queryJob" class="btn btn-success btn-xs" type="button"><i class="fa fa-eye"></i>&nbsp;查询</button>
                                <button id="addJob" class="btn btn-primary btn-xs"><i class="fa fa-check"></i>&nbsp;添加</button>
                                <button id="updJob" class="btn btn-info btn-xs" type="button"><i class="fa fa-paste"></i>&nbsp;修改</button>
                                <button id="delJob" class="btn btn-warning btn-xs" type="button"><i class="fa fa-warning"></i>&nbsp;删除</button>
                                <button id="pauseJob" class="btn btn-default btn-xs" type="button"><i class="fa fa-ban"></i>&nbsp;暂停</button>
                                <button id="recoverJob" class="btn btn-danger btn-xs" type="button"><i class="fa fa-circle-o"></i>&nbsp;恢复</button>
                                <button id="runJob" class="btn btn-primary btn-xs" type="button"><i class="fa fa-registered"></i>&nbsp;立即运行一次</button>
                                <button id="runRecords" class="btn btn-info btn-xs" type="button"><i class="fa fa-file-archive-o"></i>&nbsp;运行记录</button>
                            </div>
                        </div>
                        <div class="jqGrid_wrapper">
                            <table id="jobList"></table>
                            <div id="jobListPager"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal inmodal" id="editDialog" tabindex="-1" role="dialog" aria-hidden="true"></div>
    <div class="modal inmodal" id="recordDialog" tabindex="-1" role="dialog" aria-hidden="true"></div>

    <%@include file="../../common/globalScript.jspf" %>
    <script src="${ctx }/static/lib/hplus/js/plugins/peity/jquery.peity.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/jqgrid/i18n/grid.locale-cn.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/jqgrid/jquery.jqGrid.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/content.min.js?v=1.0.0"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/serialize/jquery.serialize-object.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/bedialog/jquery.bedialog.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/form/jquery.form.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/toastr/toastr.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/my97DatePicker/WdatePicker.js"></script>
    <script>
        $(document).ready(function() {
        	$.jgrid.defaults.styleUI = "Bootstrap";
        	$("#jobList").jqGrid({
        		url: ctx + '/system/manage/schedule/list',
        		datatype: "json",
        		height: 350,
        		autowidth: true,
        		shrinkToFit: false,
        		autoScroll: true,
        		rowNum: 10,
        		rowList: [10,20,30],
        		colNames: ["序号", "beanId", "方法名称", "组名称", "cron", "描述", "创建时间", "上次运行时间", "下次运行时间", "状态"],
        		colModel: [
        			{name: "id", index: "id", hidden: true, editable: false, width: 60, sorttype: "int", search: false},
        			{name: "beanId", index: "beanId", editable: true, width: 90},
        			{name: "methodName", index:" methodName", editable: true, width: 120},
        			{name: "group", index: "group", editable: true, width: 110},
        			{name: "expression", index: "expression", editable: true, width: 110},
        			{name: "description", index: "description", editable: true, width: 140},
        			{name: "createTime", index: "createTime", editable: true, width: 140},
        			{name: "previoustExecuteTime", index: "previoustExecuteTime", editable: true, width: 140},
        			{name: "nextExecuteTime", index: "nextExecuteTime", editable: true, width: 140, sortable: false},
        			{name: "status", index: "status", editable: true, width: 90, sortable: false}
        		],
        		pager: "#jobListPager",
        		viewrecords: true,
        		caption: "角色列表",
        		add: true,
        		edit: true,
        		addtext: "Add",
        		edittext: "Edit",
        		mtype: "POST",
        		hidegrid: false
        	});
        	$("#jobList").setSelection(4, true);
        	$("#jobList").jqGrid("navGrid", "#jobListPager", {
        		edit: true,
        		add: true,
        		del: true,
        		search: false
        	}, {
        		height: 200,
        		reloadAfterSubmit: true
        	});
	        $(window).bind("resize", function() {
	        	var width = $(".jqGrid_wrapper").width();
	        	$("#jobList").setGridWidth(width)
	        });
	        
	      	//查询
	        $("#queryJob").click(function() { 
	        	var params = $("#jobSearchForm").serializeObject();
	        	var pd = $("#jobList").jqGrid('getGridParam', 'postData');
	        	pd = $.extend(pd, params);
	        	$("#jobList").jqGrid('setGridParam', 'postData', pd);
	        	$("#jobList").trigger("reloadGrid");
	        });
	      	
	      	//新增
			$("#addJob").click(function() {
				$("#editDialog").bedialog({
				    url: "${ctx}/system/manage/schedule/add"
				});
			});
	      	
			//修改
			$("#updJob").click(function() {
				var id = $("#jobList").jqGrid('getGridParam', 'selrow');
				if (id) {
					$("#editDialog").bedialog({
					    url: "${ctx}/system/manage/schedule/update/" + id
					});
				} else {
					var data = {
						status: 1,
						msg: "请先选择一行"
					};
					responseTips(data);
				}
			});
	      	
			//删除
			$("#delJob").click(function() {
				var id = $("#jobList").jqGrid('getGridParam', 'selrow');
				if (id) {
					swal({
		                title: "确定删除?",
		                text: "删除后将无法恢复,请谨慎操作!",
		                type: "warning",
		                showCancelButton: true,
		                confirmButtonColor: "#DD6B55",
		                confirmButtonText: "删除",
		                closeOnConfirm: false
		            }, function (isConfirm) {
		            	if (isConfirm) {
		            		$.ajax({
		        				type:'get',
		        				dataType: 'json',
		        				url: "${ctx}/system/manage/schedule/delete/" + id,
		        				success: function(data) {
		        					//var obj = $.parseJSON(data);
		        					responseTips(data);
		        					$("#jobList").trigger("reloadGrid");
		        					swal.close();
		        				}
		        			});
		            	}
		            });
				} else {
					var data = {
						status: 1,
						msg: "请先选择一行"
					};
					responseTips(data);
				}
			});
			
			//暂停
			$("#pauseJob").click(function() {
				var id = $("#jobList").jqGrid('getGridParam', 'selrow');
				if (id) {
					swal({
		                title: "确定暂停?",
		                text: "请谨慎操作!",
		                type: "warning",
		                showCancelButton: true,
		                confirmButtonColor: "#DD6B55",
		                confirmButtonText: "暂停",
		                closeOnConfirm: false
		            }, function (isConfirm) {
		            	if (isConfirm) {
		            		$.ajax({
		        				type:'get',
		        				dataType: 'json',
		        				url: "${ctx}/system/manage/schedule/" + id + "/pause",
		        				success: function(data) {
		        					//var obj = $.parseJSON(data);
		        					responseTips(data);
		        					$("#jobList").trigger("reloadGrid");
		        					swal.close();
		        				}
		        			});
		            	}
		            });
				} else {
					var data = {
						status: 1,
						msg: "请先选择一行"
					};
					responseTips(data);
				}
			});
			
			//恢复
			$("#recoverJob").click(function() {
				var id = $("#jobList").jqGrid('getGridParam', 'selrow');
				if (id) {
					swal({
		                title: "确定恢复?",
		                text: "请谨慎操作!",
		                type: "warning",
		                showCancelButton: true,
		                confirmButtonColor: "#DD6B55",
		                confirmButtonText: "恢复",
		                closeOnConfirm: false
		            }, function (isConfirm) {
		            	if (isConfirm) {
		            		$.ajax({
		        				type:'get',
		        				dataType: 'json',
		        				url: "${ctx}/system/manage/schedule/" + id + "/recover",
		        				success: function(data) {
		        					//var obj = $.parseJSON(data);
		        					responseTips(data);
		        					$("#jobList").trigger("reloadGrid");
		        					swal.close();
		        				}
		        			});
		            	}
		            });
				} else {
					var data = {
						status: 1,
						msg: "请先选择一行"
					};
					responseTips(data);
				}
			});
			
			//立即运行一次
			$("#runJob").click(function() {
				var id = $("#jobList").jqGrid('getGridParam', 'selrow');
				if (id) {
					swal({
		                title: "确定运行?",
		                text: "请谨慎操作!",
		                type: "warning",
		                showCancelButton: true,
		                confirmButtonColor: "#DD6B55",
		                confirmButtonText: "运行",
		                closeOnConfirm: false
		            }, function (isConfirm) {
		            	if (isConfirm) {
		            		$.ajax({
		        				type:'get',
		        				dataType: 'json',
		        				url: "${ctx}/system/manage/schedule/" + id + "/run",
		        				success: function(data) {
		        					//var obj = $.parseJSON(data);
		        					responseTips(data);
		        					$("#jobList").trigger("reloadGrid");
		        					swal.close();
		        				}
		        			});
		            	}
		            });
				} else {
					var data = {
						status: 1,
						msg: "请先选择一行"
					};
					responseTips(data);
				}
			});
			
			//查看运行记录
			$("#runRecords").click(function() {
				var id = $("#jobList").jqGrid('getGridParam', 'selrow');
				if (id) {
					$("#recordDialog").bedialog({
					    url: "${ctx}/system/manage/schedule/record/list/" + id
					});
				} else {
					var data = {
						status: 1,
						msg: "请先选择一行"
					};
					responseTips(data);
				}
			});
        });
    </script>
</body>
</html>