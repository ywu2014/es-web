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
            <span class="modal-title">${cache.name }详细统计</span>
        </div>
        <div class="modal-body">
        	<table class="table table-bordered">
        		<thead>
                    <tr>
                        <th>键</th>
                        <th>操作</th>
                    </tr>
                </thead>
	            <tbody>
	            	<c:forEach items="${cache.keys }" var="key">
	            		<tr>
		                    <td>${key }</td>
		                    <td data-key="${key }">
		                    	<button type="button" class="btn btn-primary btn-xs view">查看</button>
                        		<button type="button" class="btn btn-default btn-xs invalid">失效</button>
		                    </td>
		                </tr>
	            	</c:forEach>
	            </tbody>
	        </table>
        </div>
	</div>
</div>

<script type="text/javascript">
	$(".view").click(function() {
		var td = $(this).closest('td');
		var key = td.data("key");
		$.ajax({
			type: 'post',
			dataType: 'json',
			url: "${ctx}/system/manage/cache/${cache.name }/" + key + "/detail",
			success: function(data) {
				var detailNode = td.find(".alert");
	            if(detailNode.length) {
	                detail.remove();
	            }
				detailNode = "<div class='alert alert-success alert-dismissable'><button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>";
				
				var detailInfo = "";
	            detailInfo += "命中次数:" + data.hitCount;
	            detailInfo +=" | ";
	            /* detailInfo += "大小:" + data.size;
	            detailInfo +=" | "; */
	            detailInfo += "最后创建/更新时间:" + data.latestOfCreationAndUpdateTime;
	            detailInfo +=" | ";
	            detailInfo += ",最后访问时间:" + data.lastAccessTime;
	            detailInfo +=" | ";
	            detailInfo += "过期时间:" + data.expirationTime;
	            detailInfo +=" | ";
	            detailInfo += "timeToIdle(秒):" + data.timeToIdle;
	            detailInfo +=" | ";
	            detailInfo += "timeToLive(秒):" + data.timeToLive;
	            detailInfo +=" | ";
	            detailInfo += "version:" + data.version;

	            detailInfo +="<br/><br/>";
	            detailInfo +="值:" + data.objectValue;
	            
	            detailNode += detailInfo;
	            detailNode += "</div>";
	            
	            td.append(detailNode);
			}
		});
	});
	$(".invalid").click(function() {
		var td = $(this).closest("td");
		var key = td.data("key");
		$.ajax({
			type: 'post',
			dataType: 'json',
			url: "${ctx}/system/manage/cache/${cache.name }/" + key + "/invalid",
			success: function(data) {
				td.closest("tr").remove();
			}
		});
	});
</script>