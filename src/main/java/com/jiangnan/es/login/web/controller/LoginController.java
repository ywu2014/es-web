/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jiangnan.es.login.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jiangnan.es.common.web.controller.BaseController;
import com.jiangnan.es.util.StringUtils;

/**
 * @description 登录控制器
 * @author ywu@wuxicloud.com
 * 2016年2月17日 下午4:10:19
 */
@Controller
@RequestMapping("/")
public class LoginController extends BaseController {
	
	@RequestMapping("login")
	public String login(Model model, String userName, HttpServletRequest request) {
		
		Exception loginFailureException = (Exception)request.getAttribute("shiroLoginFailure");
		if (null != loginFailureException) {
			if (loginFailureException instanceof UnknownAccountException) {
				model.addAttribute("loginError", "未知的账号");
			} else if (loginFailureException instanceof LockedAccountException) {
				model.addAttribute("loginError", "账号已被锁定");
			} else if (loginFailureException instanceof IncorrectCredentialsException) {
				model.addAttribute("loginError", "密码错误");
			} else {
				model.addAttribute("loginError", loginFailureException.getMessage());
			}
		}
		
		model.addAttribute("userName", userName);
		
		if (StringUtils.hasText(request.getParameter("kickout"))) {
			model.addAttribute("loginError", "账号登录限制,您已被踢出!");
		}
		
		//根据标识判断是跳转到前台首页还是后台首页
		return "system/login";
	}
}
