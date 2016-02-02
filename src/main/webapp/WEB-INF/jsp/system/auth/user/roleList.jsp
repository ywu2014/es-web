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
            <span class="modal-title">用户授权</span>
        </div>
        <div class="modal-body">
        	<div class="jqGrid_wrapper">
                <table id="roleList"></table>
                <div id="roleListPager"></div>
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
	$("#roleList").jqGrid({
		url: ctx + '/system/auth/role/list',
		datatype: "json",
		height: 250,
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
				url:"${ctx}/system/auth/user/${uid}/roles",
				success: function(data) {
					if (data) {
						for (var i = 0; i < data.length; i++) {
							$("#roleList").jqGrid('setSelection', data[i]);
						}
					}
					refresh = false;
				}
			});
		},
		onSelectRow: function(rowid, status) {
			if (!refresh) {
				var selectedRow = $("#roleList").jqGrid('getRowData', rowid);
				var type = status? "add" : "del";
				$.ajax({
					type:'post',
					dataType: 'json',
					url:"${ctx}/system/auth/user/${uid}/roles/update",
					data: {roles: selectedRow.id, type : type},
					success: function(data) {
						responseTips(data);
					}
				});
			}
		}
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
</script>