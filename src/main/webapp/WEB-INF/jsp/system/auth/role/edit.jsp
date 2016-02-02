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
            <span class="modal-title">编辑角色</span>
        </div>
        <div class="modal-body">
        	<form id="roleForm" action="${ctx }/system/auth/role/${action}" method="post" class="form-horizontal">
				<div class="form-group">
                    <label class="col-sm-3 control-label">角色名称：</label>
                    <div class="col-sm-8">
                    	<input type="hidden" name="id" value="${role.id }"/>
                        <input type="text" name="name" placeholder="角色名称" class="form-control" value="${role.name }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">角色代号：</label>
                    <div class="col-sm-8">
                        <input name="code" placeholder="角色代号" class="form-control" value="${role.code }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">描述：</label>
                    <div class="col-sm-8">
                        <input type="text" name="description" placeholder="描述" class="form-control" value="${role.description }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">序号：</label>
                    <div class="col-sm-8">
                        <input type="text" name="sort" placeholder="序号" class="form-control" value="${role.sort }"/>
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
		$("#roleForm").submit();
	});
	//提交表单
	$('#roleForm').form({
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
	    	$("#roleList").trigger("reloadGrid");
	    }    
	});
</script>