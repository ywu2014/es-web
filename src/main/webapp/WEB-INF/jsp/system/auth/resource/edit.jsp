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
            <span class="modal-title">编辑资源</span>
        </div>
        <div class="modal-body">
        	<form id="resourceForm" action="${ctx }/system/auth/resource/${action}" method="post" class="form-horizontal">
				<div class="form-group">
                    <label class="col-sm-3 control-label">资源名称：</label>
                    <div class="col-sm-8">
                    	<input type="hidden" name="id" value="${resource.id }"/>
                        <input type="text" name="name" placeholder="资源名称" class="form-control" value="${resource.name }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">资源标识：</label>
                    <div class="col-sm-8">
                        <input name="identifier" placeholder="资源标识" class="form-control" value="${resource.identifier }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">资源图标：</label>
                    <div class="col-sm-8">
                        <input type="text" name="icon" placeholder="资源图标" class="form-control" value="${resource.icon }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">资源类型：</label>
                    <div class="col-sm-8">
                        <select class="form-control m-b" name="type">
							<c:forEach items="${resourceTypes }" var="resourceType">
								<option value="${resourceType }" <c:if test="${resourceType eq resource.type }">selected="selected"</c:if>>${resourceType.name }</option>
							</c:forEach>
						</select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">父级资源：</label>
                    <div class="col-sm-8">
	                    <select id="parentId" name="pid" data-placeholder="选择父级资源..." class="chosen-select" style="width: 350px;" tabindex="2">
	                        <option value="">请选择父级资源</option>
	                        <c:forEach items="${resources }" var="res">
	                        	<option value="${res.id }" hassubinfo="true" <c:if test="${res.id eq resource.pid }">selected="selected"</c:if>>${res.name }</option>
	                        </c:forEach>
	                    </select>
	                </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">跳转链接：</label>
                    <div class="col-sm-8">
                        <input type="text" name="url" placeholder="跳转链接" class="form-control" value="${resource.url }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">排序：</label>
                    <div class="col-sm-8">
                        <input type="text" name="sort" placeholder="排序" class="form-control" value="${resource.sort }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">资源描述：</label>
                    <div class="col-sm-8">
                        <input type="text" name="description" placeholder="资源描述" class="form-control" value="${resource.description }"/>
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
	$(document).ready(function() {
		$('#resourceForm').form({
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
		    }    
		});
		
		$("#parentId").chosen();
		
		$("#editBtn").click(function() {
			//提交表单
			$("#resourceForm").submit();
		});
	});
</script>