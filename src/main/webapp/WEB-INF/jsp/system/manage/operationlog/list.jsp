<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>操作日志</title>
	<%@include file="../../common/commonHeader.jspf" %>
    <!-- Data Tables -->
	<link href="${ctx }/static/lib/hplus/css/plugins/jqgrid/ui.jqgrid.css" rel="stylesheet">
	<link href="${ctx }/static/lib/hplus/css/plugins/chosen/chosen.css" rel="stylesheet">
	<link href="${ctx }/static/lib/hplus/css/style.min.css?v=4.0.0" rel="stylesheet">
	<style>
        /* Additional style to fix warning dialog position */
        #alertmod_table_list_2 {
            top: 900px !important;
        }
    </style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>系统管理/操作日志</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="table_data_tables.html#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="table_data_tables.html#">选项1</a>
                                </li>
                                <li><a href="table_data_tables.html#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                    	<div class="row">
	                        <div class="col-sm-3 m-b-xs">
	                            <button id="addResource" class="btn btn-primary btn-xs"><i class="fa fa-check"></i>&nbsp;添加</button>
                        </div>
                    </div>
                        <table id="resourceTable" class="table table-striped table-bordered table-hover dataTables-example">
                            <thead>
                                <tr>
                                    <th>操作人</th>
                                    <th>操作时间</th>
                                    <th>操作说明</th>
                                    <th>模块名称</th>
                                    <th>标识</th>
                                    <c:if test="${!empty columns }">
                                    	<c:forEach items="${columns }" var="column">
                                    		<th>${column }</th>
                                    	</c:forEach>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${operationLogs.rows }" var="operationLog">
                            		<tr class="gradeX">
	                                    <td class="center">${operationLog.userName }</td>
	                                    <td class="center"><fmt:formatDate value="${operationLog.operateTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                                    <td class="center">${operationLog.operation }</td>
	                                    <td class="center">${operationLog.module }</td>
	                                    <td class="center">${operationLog.identifier }</td>
	                                    <c:if test="${!empty columns }">
	                                    	<c:forEach items="${operationLog.columns }" var="column">
	                                    		<td class="center">${column.value }</td>
	                                    	</c:forEach>
	                                    </c:if>
	                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal inmodal" id="editDialog" tabindex="-1" role="dialog" aria-hidden="true"></div>
    
    <%@include file="../../common/globalScript.jspf" %>
    <script src="${ctx }/static/lib/hplus/js/plugins/peity/jquery.peity.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/jqgrid/i18n/grid.locale-cn.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/jqgrid/jquery.jqGrid.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/content.min.js?v=1.0.0"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/serialize/jquery.serialize-object.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/bedialog/jquery.bedialog.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/form/jquery.form.js"></script>
    <script>
        $(document).ready(function() {
        	$("#addResource").click(function() {
        		$("#editDialog").bedialog({
				    url: "${ctx}/system/auth/resource/add"
				});
			});
        });
    </script>
</body>
</html>