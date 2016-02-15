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
            <span class="modal-title">编辑权限</span>
        </div>
        <div class="modal-body">
        	<form id="privilegeForm" action="${ctx }/system/auth/privilege/${action}" method="post" class="form-horizontal">
				<div class="form-group">
                    <label class="col-sm-3 control-label">资源：</label>
                    <div class="col-sm-8">
                    	<input type="hidden" name="id" value="${privilege.id }"/>
                        <select id="resourceId" name="resource.id" data-placeholder="选择资源名称..." class="chosen-select" style="width: 350px;" tabindex="2">
	                        <option value="">请选择资源名称</option>
	                        <c:forEach items="${resources }" var="res">
	                        	<option value="${res.id }" hassubinfo="true" <c:if test="${res.id eq privilege.resource.id }">selected="selected"</c:if>>${res.name }</option>
	                        </c:forEach>
	                    </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">操作：</label>
                    <div class="col-sm-8">
                        <select class="form-control" name="operation.id">
			            	<option value="">操作类型</option>
							<c:forEach items="${operations }" var="operation">
								<option value="${operation.id }" <c:if test="${privilege.operation.id eq operation.id }">selected="selected"</c:if>>${operation.description }</option>
							</c:forEach>
						</select>
                    </div>
                </div>
                <div class="form-group">
                	<label class="col-sm-3 control-label">描述：</label>
                	<div class="col-sm-8">
                    	<input type="text" placeholder="描述" class="form-control" name="description" value="${privilege.description }"/>
                    </div>
                </div>
			</form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
            <button id="editBtn" type="button" class="btn btn-primary">保存</button>
        </div>
	</div>
</div>

<script type="text/javascript">
	$("#resourceId").chosen();
	
	$("#editBtn").click(function() {
		$("#privilegeForm").submit();
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
	    	responseTips(obj);
	    	$('#editDialog').modal('hide');
	    	$("#privilegeList").trigger("reloadGrid");
	    }    
	});
</script>