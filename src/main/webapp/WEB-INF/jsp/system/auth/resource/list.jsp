<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>资源列表</title>
	<%@include file="../../common/commonHeader.jspf" %>
    <!-- Data Tables -->
	<link href="${ctx }/static/lib/hplus/css/plugins/jqgrid/ui.jqgrid.css" rel="stylesheet">
	<link href="${ctx }/static/lib/hplus/css/plugins/toastr/toastr.min.css" rel="stylesheet">
	<link href="${ctx }/static/lib/hplus/css/plugins/chosen/chosen.css" rel="stylesheet">
	<link href="${ctx }/static/lib/hplus/css/style.min.css?v=4.0.0" rel="stylesheet">
	<link href="${ctx }/static/lib/hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
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
                        <h5>用户授权/资源管理</h5>
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
	                        	<shiro:hasPermission name="resource:add">
	                        		<button id="addResource" class="btn btn-primary btn-xs"><i class="fa fa-check"></i>&nbsp;添加</button>
	                        	</shiro:hasPermission>
                        	</div>
                    	</div>
                        <table id="resourceTable" class="table table-striped table-bordered table-hover dataTables-example">
                            <thead>
                                <tr>
                                    <th>资源名称</th>
                                    <th>资源标识</th>
                                    <th>资源图标</th>
                                    <th>资源类型</th>
                                    <th>跳转链接</th>
                                    <th>排序</th>
                                    <th>资源描述</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${resources }" var="resource">
                            		<tr class="gradeX" data-tt-id="${resource.id }" data-tt-parent-id="${resource.pid }">
	                                    <td>${resource.name }</td>
	                                    <td>${resource.identifier }</td>
	                                    <td><i class="fa ${resource.icon }"></i>&nbsp;${resource.icon }</td>
	                                    <td class="center">${resource.type }</td>
	                                    <td class="center">${resource.url }</td>
	                                    <td class="center">${resource.sort }</td>
	                                    <td class="center">${resource.description }</td>
	                                    <td class="center">
                                			<button class="btn btn-info btn-xs" type="button" onclick="updateResource('${resource.id }')">
                                				<i class="fa fa-paste"></i>&nbsp;修改
                                			</button>
                                			<button class="btn btn-danger btn-xs" type="button" onclick="deleteResource('${resource.id }')">
                                				<i class="fa fa-paste"></i>&nbsp;删除
                                			</button>
	                                    </td>
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
    <script src="${ctx }/static/lib/hplus/js/plugins/toastr/toastr.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/chosen/chosen.jquery.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/treetable/jquery.treetable.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
    <script>
        $(document).ready(function() {
        	$("#resourceTable").treetable();
        	
        	$("#addResource").click(function() {
        		$("#editDialog").bedialog({
				    url: "${ctx}/system/auth/resource/add"
				});
			});
        });
        
        //更新资源
        function updateResource(resourceId) {
        	$("#editDialog").bedialog({
			    url: "${ctx}/system/auth/resource/update/" + resourceId
			});
        }
        
        //删除资源
        function deleteResource(resourceId) {
        	swal({
                title: "确定删除?",
                text: "删除后将无法恢复,请谨慎操作!",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function (isConfirm) {
            	if (isConfirm) {
            		$.ajax({
        				type: 'get',
        				dataType: 'json',
        				url: "${ctx}/system/auth/resource/delete/" + resourceId,
        				success: function(data) {
        					//var obj = $.parseJSON(data);
        					responseTips(data);
        					swal.close();
        				}
        			});
            	}
            });
        }
    </script>
</body>
</html>