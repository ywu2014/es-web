<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>会话过期</title>

    <meta name="keywords" content="es,后台,响应式">
    <meta name="description" content="响应式后台管理框架">
   
    <link href="${ctx }/static/lib/hplus/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx }/static/lib/hplus/css/animate.min.css" rel="stylesheet">
    <link href="${ctx }/static/lib/hplus/css/style.min.css" rel="stylesheet">
   
    <!--[if lt IE 8]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
   
    <script>
        if(window.top!==window.self){window.top.location=window.location};
    </script>
</head>

<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <h1>出错了</h1>
        <h3 class="font-bold">当前会话已过期</h3>

        <div class="error-desc">
            <br/>您可以重新登录看看
            <br/><a href="${ctx }/login" class="btn btn-primary m-t">登录</a>
        </div>
    </div>
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.5"></script>
</body>
</html>