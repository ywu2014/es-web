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
                        <h5>系统管理/缓存监控</h5>
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
                    	<c:forEach items="${caches }" var="cache">
                    		<c:set var="totalCount" value="${cache.statistics.cacheHits + cache.statistics.cacheMisses }"/>
                    		<c:set var="totalCount" value="${totalCount > 0 ? totalCount : 1 }"/>
                    		<c:set var="hitPercent" value="${cache.statistics.cacheHits * 1.0 / totalCount }"/>
                    		<div class="row">
		                        <div class="col-sm-12">
		                            <div class="ibox float-e-margins">
					                    <div class="ibox-title">
					                        <h5>${cache.name }</h5>
					                        <div class="ibox-tools">
					                            <a class="dropdown-toggle" onclick="showDetail('${cache.name }')">详情</a>
					                            <a class="collapse-link">
					                                <i class="fa fa-chevron-up"></i>
					                            </a>
					                            <a class="close-link">
					                                <i class="fa fa-times"></i>
					                            </a>
					                        </div>
					                    </div>
					                    <div class="ibox-content">
					                        <div class="panel-body">
					                            <table class="table">
						                            <tbody>
						                                <tr>
						                                    <td>总命中率:</td>
						                                    <td>${hitPercent }</td>
						                                </tr>
						                                <tr>
						                                    <td>命中次数:</td>
						                                    <td>${cache.statistics.cacheHits }</td>
						                                </tr>
						                                <tr>
						                                    <td>失效次数:</td>
						                                    <td>${cache.statistics.cacheMisses }</td>
						                                </tr>
						                                <tr>
						                                    <td>缓存总对象数:</td>
						                                    <td>${cache.statistics.objectCount }</td>
						                                </tr>
						                                <tr>
						                                    <td>最后一秒查询完成的执行数:</td>
						                                    <td>${cache.statistics.searchesPerSecond}</td>
						                                </tr>
						                                <tr>
						                                    <td>最后一次采样的平均执行时间(毫秒):</td>
						                                    <td>${cache.statistics.averageSearchTime}</td>
						                                </tr>
						                                <tr>
						                                    <td>平均获取时间(毫秒):</td>
						                                    <td>${cache.statistics.averageGetTime}</td>
						                                </tr>
						                            </tbody>
						                        </table>
					                        </div>
					                    </div>
					                </div>
		                        </div>
		                    </div>
                    	</c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal inmodal" id="detailDialog" tabindex="-1" role="dialog" aria-hidden="true"></div>
    
    <%@include file="../../common/globalScript.jspf" %>
    <script src="${ctx }/static/lib/hplus/js/plugins/peity/jquery.peity.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/jqgrid/i18n/grid.locale-cn.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/jqgrid/jquery.jqGrid.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/content.min.js?v=1.0.0"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/serialize/jquery.serialize-object.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/bedialog/jquery.bedialog.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/form/jquery.form.js"></script>
    <script>
        function showDetail(cacheName) {
        	$("#detailDialog").bedialog({
			    url: "${ctx}/system/manage/cache/" + cacheName + "/detail"
			});
        }
    </script>
</body>
</html>