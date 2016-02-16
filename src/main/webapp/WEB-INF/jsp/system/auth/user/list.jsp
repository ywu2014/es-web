<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理</title>
	<%@include file="../../common/commonHeader.jspf" %>
    <!-- Data Tables -->
	<link href="${ctx }/static/lib/hplus/css/plugins/jqgrid/ui.jqgrid.css" rel="stylesheet">
	<link href="${ctx }/static/lib/hplus/css/plugins/toastr/toastr.min.css" rel="stylesheet">
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
                        <h5>用户授权/用户管理</h5>
                    </div>
                    <div class="ibox-content">
                    	<form action="" method="post" id="userSearchForm">
	                    	<div class="row">
	                            <div class="col-sm-3 m-b-xs">
	                                <div class="input-group m-b">
	                                	<span class="input-group-btn"><button type="button" class="btn btn-default">用户名</button></span>
	                                    <input name="userName" type="text" class="form-control" placeholder="用户名">
	                                </div>
	                            </div>
                                <div class="col-sm-3 m-b-xs">
	                                <div class="input-group m-b">
	                                	<span class="input-group-btn"><button type="button" class="btn btn-default">邮箱</button></span>
	                                    <input name="email" type="text" class="form-control" placeholder="邮箱">
	                                </div>
	                            </div>
	                            <div class="col-sm-6 m-b-xs">
	                                <div class="input-group m-b">
	                                	<span class="input-group-btn"><button type="button" class="btn btn-default">访问时间</button></span>
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
                            <div class="col-sm-4 m-b-xs">
                                <button id="queryUser" class="btn btn-success btn-xs" type="button"><i class="fa fa-eye"></i>&nbsp;查询</button>
                                <button id="addUser" class="btn btn-primary btn-xs"><i class="fa fa-check"></i>&nbsp;添加</button>
                                <button id="updUser" class="btn btn-info btn-xs" type="button"><i class="fa fa-paste"></i>&nbsp;修改</button>
                                <button id="delUser" class="btn btn-warning btn-xs" type="button"><i class="fa fa-warning"></i>&nbsp;删除</button>
                                <button id="authUser" class="btn btn-default btn-xs" type="button"><i class="fa fa-lock"></i>&nbsp;授权</button>
                            </div>
                        </div>
                        <div class="jqGrid_wrapper">
                            <table id="userList"></table>
                            <div id="userListPager"></div>
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
    <script src="${ctx }/static/lib/hplus/js/plugins/my97DatePicker/WdatePicker.js"></script>
    <script>
        $(document).ready(function() {
        	$.jgrid.defaults.styleUI = "Bootstrap";
        	$("#userList").jqGrid({
        		url: ctx + '/system/auth/user/list',
        		datatype: "json",
        		height: 350,
        		autowidth: true,
        		shrinkToFit: true,
        		rowNum: 10,
        		rowList: [10,20,30],
        		colNames: ["序号", "用户名", "电子邮件", "头像", "创建时间", "上次访问时间", "并发登录数", "状态"],
        		colModel: [
        			{name: "id", index: "id", hidden: true, editable: false, width: 60, sorttype: "int", search: false},
        			{name: "userName", index: "userName", editable: true, width: 90},
        			{name: "email", index:" email", editable: true, width: 120},
        			{name: "icon", index: "icon", editable: true, width: 120},
        			{name: "createTime", index: "createTime", editable: true, width: 90, sorttype: "date"},
        			{name: "lastVisitTime", index: "lastVisitTime", editable: true, width: 90, sorttype: "date"},
        			{name: "currentLoginCount", index: "currentLoginCount", editable: true, width: 60, sortable: true},
        			{name: "state", index: "state" ,editable: true, width: 60, sortable: false}
        		],
        		pager: "#userListPager",
        		viewrecords: true,
        		caption: "登录用户列表",
        		add: true,
        		edit: true,
        		addtext: "Add",
        		edittext: "Edit",
        		hidegrid: false
        	});
        	$("#userList").setSelection(4, true);
        	$("#userList").jqGrid("navGrid", "#userListPager", {
        		edit: true,
        		add: true,
        		del: true,
        		search: false
        	}, {
        		height: 200,
        		reloadAfterSubmit: true});
	        $(window).bind("resize", function() {
	        	var width = $(".jqGrid_wrapper").width();
	        	$("#userList").setGridWidth(width)
	        });
	        
	      	//查询
	        $("#queryUser").click(function() { 
	        	var params = $("#userSearchForm").serializeObject();
	        	var pd = $("#userList").jqGrid('getGridParam', 'postData');
	        	pd = $.extend(pd, params);
	        	$("#userList").jqGrid('setGridParam', 'postData', pd);
	        	$("#userList").trigger("reloadGrid");
	        });
	      	
	      	//新增
			$("#addUser").click(function() {
				$("#editDialog").bedialog({
				    url: "${ctx}/system/auth/user/add"
				});
			});
	      	
			//修改
			$("#updUser").click(function() {
				var id = $("#userList").jqGrid('getGridParam', 'selrow');
				if (id) {
					$("#editDialog").bedialog({
					    url: "${ctx}/system/auth/user/update/" + id
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
			$("#delUser").click(function() {
				var id = $("#userList").jqGrid('getGridParam', 'selrow');
				if (id) {
					$.ajax({
	    				type:'get',
	    				dataType: 'json',
	    				url:"${ctx}/system/auth/user/delete/" + id,
	    				success: function(data) {
	    					//var obj = $.parseJSON(data);
	    					responseTips(data);
	    					$("#userList").trigger("reloadGrid");
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
			$("#authUser").click(function() {
				var id = $("#userList").jqGrid('getGridParam', 'selrow');
				if (id) {
					$("#authDialog").bedialog({
					    url: "${ctx}/system/auth/user/role/list/" + id
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