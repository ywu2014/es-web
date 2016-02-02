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
            <span class="modal-title">编辑用户</span>
        </div>
        <div class="modal-body">
        	<form id="userForm" action="${ctx }/system/auth/user/${action}" method="post" class="form-horizontal">
				<div class="form-group">
                    <label class="col-sm-3 control-label">用户名：</label>
                    <div class="col-sm-8">
                    	<input type="hidden" name="id" value="${user.id }"/>
                        <input type="text" name="userName" placeholder="用户名" class="form-control" value="${user.userName }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">密码：</label>
                    <div class="col-sm-8">
                        <input name="password" type="password" placeholder="密码" class="form-control" value="${user.password }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">电子邮件：</label>
                    <div class="col-sm-8">
                        <input type="text" name="email" placeholder="电子邮件" class="form-control" value="${user.email }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">头像：</label>
                    <div class="col-sm-8">
                        <input type="text" name="icon" placeholder="头像" class="form-control" value="${user.icon }"/>
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
	$("#editBtn").click(function() {
		$("#userForm").submit();
	});
	//提交表单
	$('#userForm').form({
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
	    	$("#userList").trigger("reloadGrid");
	    }    
	});
</script>