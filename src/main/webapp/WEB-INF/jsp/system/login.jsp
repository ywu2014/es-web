<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>登录</title>

    <meta name="keywords" content="es,后台,响应式">
    <meta name="description" content="响应式后台管理框架">
   
    <link href="${ctx }/static/lib/hplus/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx }/static/lib/hplus/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx }/static/lib/hplus/css/animate.min.css" rel="stylesheet">
    <link href="${ctx }/static/lib/hplus/css/style.min.css" rel="stylesheet">
    <link href="${ctx }/static/lib/hplus/css/login.min.css" rel="stylesheet">
   
    <!--[if lt IE 8]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
   
    <script>
        if(window.top!==window.self){window.top.location=window.location};
    </script>
</head>

<body class="signin">
    <div class="signinpanel">
        <div class="row">
            <div class="col-sm-7">
                <div class="signin-info">
                    <div class="logopanel m-b">
                        <h1>[ ES ]</h1>
                    </div>
                    <div class="m-b"></div>
                    <h4>欢迎使用 <strong>es 后台管理系统</strong></h4>
                    <ul class="m-b">
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 响应式后台系统</li>
                    </ul>
                    <strong></strong>
                </div>
            </div>
            <div class="col-sm-5">
                <form method="post" action="${ctx }/login">
                    <h4 class="no-margins">登录：</h4>
                    <p class="m-t-md text-danger">
                    	${loginError }
                    </p>
                    <input type="text" class="form-control uname" placeholder="用户名" name="userName" value="${userName }"/>
                    <input type="password" class="form-control pword m-b" placeholder="密码" name="password"/>
                    <a href="">忘记密码了？</a>
                    <button class="btn btn-success btn-block">登录</button>
                </form>
            </div>
        </div>
        <div class="signup-footer">
            <div class="pull-left">
            <jsp:useBean id="now" class="java.util.Date"/>
                &copy; 2015 - <fmt:formatDate value="${now }" pattern="yyyy"/> All Rights Reserved. es
            </div>
        </div>
    </div>
</body>
</html>