<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ES后台管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="es" />
    <meta name="description" content="es基础框架,整合一些常用的框架,提供一些通用的模块" />

    <%@include file="../../common/scriptInclude.jspf" %>
</head>
<body>
	<div id="toolbar" style="padding: 5px; height: auto;">
        <div>
        	<form action="" id="privilegeSearchForm">
	       		<input class="easyui-validatebox" name="resource.name" data-options="prompt: '资源名称'" style="width: 100px;"/>
	            <span class="toolbar-item dialog-tool-separator"></span>
	            <select class="easyui-combobox" name="operation.id" data-options="width: 100">
	            	<option value="">操作类型</option>
					<c:forEach items="${operations }" var="operation">
						<option value="${operation.id }">${operation.description }</option>
					</c:forEach>
				</select>
	            <span class="toolbar-item dialog-tool-separator"></span>
	            <a id="search" href="javascript:void(0)" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-search'" onclick="query();">查询</a>
        	</form>
       		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add();">添加</a>
       		<span class="toolbar-item dialog-tool-separator"></span>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" data-options="disabled:false" onclick="del()">删除</a>
        	<span class="toolbar-item dialog-tool-separator"></span>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="update()">修改</a>
            <span class="toolbar-item dialog-tool-separator"></span>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addOperation()">添加操作</a>
        </div>
	</div>
	<table id="privilege"></table>
	<div id="editDialog"></div>

	<script type="text/javascript">
		var privilegeDg, editDialog;
        $(function () {
        	privilegeDg = $("#privilege").datagrid({
                fit: true,
                fitColumns : true,
                border: false,
                method: "get",
                url: ctx + "/system/auth/privilege/list",
                singleSelect: true,
                idField: 'id',
                animate: true,
                remoteSort: false,
                rownumbers: true,
                pagination: true,
                striped: true,
                columns: [[
					{field: 'id', title: 'id', width: 40, sortable: true, hidden: true},
                    {field: 'resourceName', title: '资源名称', width: 130, sortable: true},
                    {field: 'operation', title: '操作名称', width: 158, sortable: false},
                    {field: 'description', title: '描述', width: 230, sortable: false}
                ]],
                toolbar: "#toolbar"
            });
        });
      	//添加权限
        function add() {
            editDialog = $('#editDialog').dialog({
            	title: "添加权限",
                modal: true,
                width: 380,
                height: 220,
                href: '${ctx}/system/auth/privilege/add',
                buttons: [
                	{
                		text: '确认',
                		handler: function() {
                			$("#privilegeForm").submit();
                		}
                	},{
                		text: '取消',
                		handler: function() {
                			editDialog.panel("close");
                		}
                	}
                ]
            });
        }
      	
      	//添加权限操作
      	function addOperation() {
            editDialog = $('#editDialog').dialog({
            	title: "添加操作",
                modal: true,
                width: 380,
                height: 200,
                href: '${ctx}/system/auth/operation/add',
                buttons: [
                	{
                		text: '确认',
                		handler: function() {
                			$("#operationForm").submit();
                		}
                	},{
                		text: '取消',
                		handler: function() {
                			editDialog.panel("close");
                		}
                	}
                ]
            });
        }
        
        //查看权限详情
        
        //修改权限
        function update() {
        	var row = privilegeDg.datagrid('getSelected');
        	if (emptyRow(row)) {
        		return;
        	}
            editDialog = $('#editDialog').dialog({
            	title: "修改权限",
                modal: true,
                width: 380,
                height: 220,
                href: "${ctx}/system/auth/privilege/update/" + row.id,
                buttons: [
                	{
                		text: '确认',
                		handler: function() {
                			$("#privilegeForm").submit();
                		}
                	},{
                		text: '取消',
                		handler: function() {
                			editDialog.panel("close");
                		}
                	}
                ]
            });
        }
        
        //删除权限
        function del() {
        	var row = privilegeDg.datagrid('getSelected');
        	if (emptyRow(row)) {
        		return;
        	}
        	parent.$.messager.confirm('提示', '删除后无法恢复,确定删除?', function(data) {
        		if (data) {
        			$.ajax({
        				type:'get',
        				dataType: 'json',
        				url:"${ctx}/system/auth/privilege/delete/" + row.id,
        				success: function(data) {
        					//var obj = $.parseJSON(data);
        					responseTips(data, privilegeDg);
        				}
        			});
        		} 
        	});
        }
        
        //查询
        function query() {
        	var params = $("#privilegeSearchForm").serializeObject();
        	console.log(params);
        	privilegeDg.datagrid('load', params); 
        }
    </script>
</body>
</html>