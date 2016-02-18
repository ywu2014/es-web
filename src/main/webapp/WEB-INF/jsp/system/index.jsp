<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>首页</title>

    <meta name="keywords" content="es,后台,响应式">
    <meta name="description" content="响应式后台管理框架">

    <!--[if lt IE 8]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->

    <%@include file="common/commonHeader.jspf" %>
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper">
        <%@include file="common/menu.jspf" %>
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                        <form role="search" class="navbar-form-custom" method="post" action="search_results.html">
                            <div class="form-group">
                                <input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search" id="top-search">
                            </div>
                        </form>
                    </div>
                    <ul class="nav navbar-top-links navbar-right">
                        <%@include file="common/headerMessage.jspf" %>
                        <%@include file="common/headerMessageWarn.jspf" %>
                        <li class="dropdown hidden-xs">
                            <a class="right-sidebar-toggle" aria-expanded="false">
                                <i class="fa fa-tasks"></i> 主题
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i></button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:;" class="active J_menuTab" data-id="index_v1.html">首页</a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i></button>
                <div class="btn-group roll-nav roll-right">
                    <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span></button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                        <li class="J_tabShowActive"><a>定位当前选项卡</a></li>
                        <li class="divider"></li>
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a></li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a></li>
                    </ul>
                </div>
                <a href="/logout" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="${ctx }/system/calendar" frameborder="0" data-id="index_v1.html" seamless></iframe>
            </div>
            <div class="footer">
                <div class="pull-right">&copy; 2015-2016 <a href="mailto:yejunwu126@126.com">ywu</a></div>
            </div>
        </div>
        <!--右侧部分结束-->
        <%@include file="common/themConfig.jspf" %>
        <%@include file="common/smallchat.jspf" %>
    </div>
    <%@include file="common/globalScript.jspf" %>
    <script src="${ctx }/static/lib/hplus/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/layer/layer.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/hplus.min.js?v=4.0.0"></script>
    <script type="text/javascript" src="${ctx }/static/lib/hplus/js/contabs.min.js"></script>
    <script src="${ctx }/static/lib/hplus/js/plugins/pace/pace.min.js"></script>
</body>
</html>