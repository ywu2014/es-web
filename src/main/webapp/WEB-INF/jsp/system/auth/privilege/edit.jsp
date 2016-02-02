<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<form id="privilegeForm" action="${ctx }/system/auth/privilege/${action}" method="post">
		<table class="formTable">
			<tr>
				<td>资源：</td>
				<td>
					<input type="hidden" name="id" value="${privilege.id }"/>
					<input id="resource" name="resource.id" type="text" class="easyui-validatebox" data-options="width: 150" value="${privilege.resource.id }"/>
				</td>
			</tr>
			<tr>
				<td>操作：</td>
				<td>
					<select class="easyui-combobox" name="operation.id" data-options="width: 150">
						<c:forEach items="${operations }" var="operation">
							<option value="${operation.id }" <c:if test="${privilege.operation.id eq operation.id }">selected="selected"</c:if>>${operation.description }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>描述：</td>
				<td><textarea rows="3" cols="41" name="description" style="font-size: 12px;font-family: '微软雅黑'">${privilege.description }</textarea></td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	/* var action = "${action}";
	if (action == "add") {
		$('#pid').val(pid);
	} */
	//父级菜单
	$('#resource').combotree({
		width: 150,
		method: 'GET',
	    url: ctx + "/system/auth/resource/json",
	    idField: 'id',
	    textFiled: 'name',
		parentField: 'pid',
		iconCls: 'icon',
	    animate: true
	});
	
	//提交表单
	$('#privilegeForm').form({
		dataType: "json",
	    onSubmit: function() {    
	    	/* var isValid = $(this).form('validate');
			return isValid;	// 返回false终止表单提交 */
			return true;
	    },    
	    success: function(data) {
	    	var obj = $.parseJSON(data);
	    	responseTips(obj, privilegeDg, editDialog);
	    }    
	});
</script>