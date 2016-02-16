<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal-dialog" style="width: 1000px;">
	<div class="modal-content animated bounceInRight">
    	<div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal">
            	<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
            </button>
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
            <span class="modal-title">调度运行记录</span>
        </div>
        <div class="modal-body">
        	<div class="jqGrid_wrapper">
                <table id="recordList"></table>
                <div id="recordListPager"></div>
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
	$("#recordList").jqGrid({
		url: ctx + '/system/manage/schedule/${jobId}/records',
		datatype: "json",
		height: 250,
		autowidth: true,
		shrinkToFit: true,
		rowNum: 10,
		rowList: [10,20,30],
		colNames: ["序号", "beanId", "方法名称", "组名称", "描述", "开始时间", "结束时间", "状态"],
		colModel: [
			{name: "id", index: "id", hidden: true, editable: false, width: 30, sorttype: "int", search: false},
			{name: "beanId", index: "beanId", editable: true, width: 60},
			{name: "methodName", index:" methodName", editable: true, width: 90},
			{name: "group", index:" group", editable: true, width: 90},
			{name: "description", index: "description", editable: true, width: 120},
			{name: "startTime", index: "startTime" ,editable: true, width: 120, sortable: false},
			{name: "finishedTime", index: "finishedTime" ,editable: true, width: 120, sortable: false},
			{name: "status", index: "status" ,editable: true, width: 90, sortable: false}
		],
		pager: "#recordListPager",
		viewrecords: true,
		caption: "运行记录列表",
		add: true,
		edit: true,
		addtext: "Add",
		edittext: "Edit",
		mtype: "POST",
		multiselect : true,
		hidegrid: false
	});
	$("#recordList").setSelection(4, true);
	$("#recordList").jqGrid("navGrid", "#recordListPager", {
		edit: true,
		add: true,
		del: true,
		search: false
	}, {
		height: 200,
		reloadAfterSubmit: true
	});
</script>