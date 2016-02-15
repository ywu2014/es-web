<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>角色管理</title>
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
                        <h5>用户授权/角色管理</h5>
                    </div>
                    <div class="ibox-content">
                    	<form action="" method="post" id="roleSearchForm">
	                    	<div class="row">
	                            <div class="col-sm-3 m-b-xs">
	                                <div class="input-group m-b">
	                                	<span class="input-group-btn"><button type="button" class="btn btn-default">角色名称</button></span>
	                                    <input id="roleName" name="name" type="text" class="form-control" placeholder="角色名称">
	                                </div>
	                            </div>
                                <div class="col-sm-3 m-b-xs">
	                                <div class="input-group m-b">
	                                	<span class="input-group-btn"><button type="button" class="btn btn-default">角色代号</button></span>
	                                    <input id="roleCode" name="code" type="text" class="form-control" placeholder="角色代号">
	                                </div>
	                            </div>
	                        </div>
                        </form>
                        <div class="row">
                            <div class="col-sm-4 m-b-xs">
                                <button id="queryRole" class="btn btn-success btn-xs" type="button"><i class="fa fa-eye"></i>&nbsp;查询</button>
                                <button id="addRole" class="btn btn-primary btn-xs"><i class="fa fa-check"></i>&nbsp;添加</button>
                                <button id="updRole" class="btn btn-info btn-xs" type="button"><i class="fa fa-paste"></i>&nbsp;修改</button>
                                <button id="delRole" class="btn btn-warning btn-xs" type="button"><i class="fa fa-warning"></i>&nbsp;删除</button>
                                <button id="authRole" class="btn btn-default btn-xs" type="button"><i class="fa fa-lock"></i>&nbsp;授权</button>
                            </div>
                        </div>
                        <div class="jqGrid_wrapper">
                            <table id="roleList"></table>
                            <div id="roleListPager"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal inmodal" id="editDialog" tabindex="-1" role="dialog" aria-hidden="true"></div>
    <div class="modal inmodal" id="authDialog" tabindex="-1" role="dialog" aria-hidden="true"></div>

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
    <script>
        $(document).ready(function() {
        	$.jgrid.defaults.styleUI = "Bootstrap";
        	$("#roleList").jqGrid({
        		url: ctx + '/system/auth/role/list',
        		datatype: "json",
        		height: 350,
        		autowidth: true,
        		shrinkToFit: true,
        		rowNum: 10,
        		rowList: [10,20,30],
        		colNames: ["序号", "角色名称", "角色代号", "描述", "排序号"],
        		colModel: [
        			{name: "id", index: "id", hidden: true, editable: false, width: 60, sorttype: "int", search: false},
        			{name: "name", index: "name", editable: true, width: 90},
        			{name: "code", index:" code", editable: true, width: 120},
        			{name: "description", index: "description", editable: true, width: 120},
        			{name: "sort", index: "sort" ,editable: true, width: 60, sortable: false}
        		],
        		pager: "#roleListPager",
        		viewrecords: true,
        		caption: "角色列表",
        		add: true,
        		edit: true,
        		addtext: "Add",
        		edittext: "Edit",
        		mtype: "POST",
        		hidegrid: false
        	});
        	$("#roleList").setSelection(4, true);
        	$("#roleList").jqGrid("navGrid", "#roleListPager", {
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
	        	$("#roleList").setGridWidth(width)
	        });
	        
	      	//查询
	        $("#queryRole").click(function() { 
	        	var params = $("#roleSearchForm").serializeObject();
	        	var pd = $("#roleList").jqGrid('getGridParam', 'postData');
	        	pd = $.extend(pd, params);
	        	$("#roleList").jqGrid('setGridParam', 'postData', pd);
	        	$("#roleList").trigger("reloadGrid");
	        });
	      	
	      	//新增
			$("#addRole").click(function() {
				$("#editDialog").bedialog({
				    url: "${ctx}/system/auth/role/add"
				});
			});
	      	
			//修改
			$("#updRole").click(function() {
				var id = $("#roleList").jqGrid('getGridParam', 'selrow');
				if (id) {
					$("#editDialog").bedialog({
					    url: "${ctx}/system/auth/role/update/" + id
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
			$("#delRole").click(function() {
				var id = $("#roleList").jqGrid('getGridParam', 'selrow');
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
		        				url: "${ctx}/system/auth/role/delete/" + id,
		        				success: function(data) {
		        					//var obj = $.parseJSON(data);
		        					responseTips(data);
		        					$("#roleList").trigger("reloadGrid");
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
			
			//授权
			$("#authRole").click(function() {
				var id = $("#roleList").jqGrid('getGridParam', 'selrow');
				if (id) {
					$("#authDialog").bedialog({
					    url: "${ctx}/system/auth/role/privilege/list/" + id
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