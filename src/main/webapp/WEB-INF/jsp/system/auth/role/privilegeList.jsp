<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal-dialog">
	<div class="modal-content animated bounceInRight">
    	<div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal">
            	<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
            </button>
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
            <span class="modal-title">角色授权</span>
        </div>
        <div class="modal-body">
        	<div class="jqGrid_wrapper">
                <table id="privilegeList"></table>
                <div id="privilegeListPager"></div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
        </div>
	</div>
</div>

<script type="text/javascript">
	var refresh;
	$.jgrid.defaults.styleUI = "Bootstrap";
	$("#privilegeList").jqGrid({
		url: ctx + '/system/auth/privilege/list',
		datatype: "json",
		height: 250,
		autowidth: true,
		shrinkToFit: true,
		rowNum: 10,
		rowList: [10,20,30],
		colNames: ["序号", "资源名称", "操作名称", "描述"],
		colModel: [
			{name: "id", index: "id", hidden: true, editable: false, width: 60, sorttype: "int", search: false},
			{name: "resourceName", index: "resourceName", editable: true, width: 90},
			{name: "operation", index:" operation", editable: true, width: 120},
			{name: "description", index: "description", editable: true, width: 120}
		],
		pager: "#privilegeListPager",
		viewrecords: true,
		caption: "权限列表",
		add: true,
		edit: true,
		addtext: "Add",
		edittext: "Edit",
		mtype: "POST",
		multiselect : true,
		hidegrid: false,
		beforeRequest: function() {
			refresh = true;
		},
		gridComplete: function() {
			//获取当前用户权限列表
        	$.ajax({
				type:'get',
				dataType: 'json',
				url:"${ctx}/system/auth/role/${rid}/privileges",
				success: function(data) {
					if (data) {
						for (var i = 0; i < data.length; i++) {
							$("#privilegeList").jqGrid('setSelection', data[i]);
						}
					}
					refresh = false;
				}
			});
		},
		onSelectRow: function(rowid, status) {
			if (!refresh) {
				var selectedRow = $("#privilegeList").jqGrid('getRowData', rowid);
				var type = status? "add" : "del";
				$.ajax({
					type: 'post',
					dataType: 'json',
					url: "${ctx}/system/auth/role/${rid}/privileges/update",
					data: {privilegeIds: selectedRow.id, type : type},
					success: function(data) {
						responseTips(data);
					}
				});
			}
		}
	});
	$("#privilegeList").setSelection(4, true);
	$("#privilegeList").jqGrid("navGrid", "#privilegeListPager", {
		edit: true,
		add: true,
		del: true,
		search: false
	}, {
		height: 200,
		reloadAfterSubmit: true
	});
</script>