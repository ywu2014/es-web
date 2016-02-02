<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<form id="operationForm" action="${ctx }/system/auth/operation/${action}" method="post">
		<table class="formTable">
			<tr>
				<td>标识：</td>
				<td>
					<input type="hidden" name="id" value="${operation.id }"/>
					<input id="resource" name="code" type="text" class="easyui-validatebox" data-options="width: 150" value="${operation.code }"/>
				</td>
			</tr>
			<tr>
				<td>描述：</td>
				<td><textarea rows="3" cols="41" name="description" style="font-size: 12px;font-family: '微软雅黑'">${operation.description }</textarea></td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	//提交表单
	$('#operationForm').form({
		dataType: "json",
	    onSubmit: function() {    
	    	/* var isValid = $(this).form('validate');
			return isValid;	// 返回false终止表单提交 */
			return true;
	    },    
	    success: function(data) {
	    	var obj = $.parseJSON(data);
	    	responseTips(obj, null, editDialog);
	    }    
	});
</script>