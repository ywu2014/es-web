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
            <span class="modal-title">编辑调度</span>
        </div>
        <div class="modal-body">
        	<form id="jobTaskForm" action="${ctx }/system/manage/schedule/${action}" method="post" class="form-horizontal">
				<div class="form-group">
                    <label class="col-sm-3 control-label">beanId：</label>
                    <div class="col-sm-8">
                    	<input type="hidden" name="id" value="${jobTask.id }"/>
                        <input type="text" name="beanId" placeholder="beanId" class="form-control" value="${jobTask.beanId }" <c:if test="${action eq 'update' }">readonly="readonly"</c:if>/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">方法名称：</label>
                    <div class="col-sm-8">
                        <input name="methodName" placeholder="方法名称" class="form-control" value="${jobTask.methodName }" <c:if test="${action eq 'update' }">readonly="readonly"</c:if>/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">组名称：</label>
                    <div class="col-sm-8">
                        <input type="text" name="group" placeholder="组名称" class="form-control" value="${jobTask.group }" <c:if test="${action eq 'update' }">readonly="readonly"</c:if>/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">表达式：</label>
                    <div class="col-sm-8">
                        <input type="text" name="expression" placeholder="表达式" class="form-control" value="${jobTask.expression }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">描述：</label>
                    <div class="col-sm-8">
                        <input type="text" name="description" placeholder="描述" class="form-control" value="${jobTask.description }"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">参数：</label>
                    <div class="col-sm-8">
                        <input type="text" name="params" placeholder="参数" class="form-control" value="${jobTask.params }"/>
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
		$("#jobTaskForm").submit();
	});
	//提交表单
	$('#jobTaskForm').form({
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
	    	$("#jobList").trigger("reloadGrid");
	    }    
	});
</script>