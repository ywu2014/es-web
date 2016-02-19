/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package org.apache.shiro.realm;

import javax.annotation.Resource;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jiangnan.es.authorization.user.entity.User;
import com.jiangnan.es.authorization.user.exception.PasswordNotMatchException;
import com.jiangnan.es.login.exception.AccountLockedException;
import com.jiangnan.es.login.exception.AccountNotExistException;
import com.jiangnan.es.login.service.LoginService;

/**
 * @description 自定义用户认证、授权realm
 * @author ywu@wuxicloud.com
 * 2016年2月17日 下午4:55:38
 */
public class UserRealm extends AuthorizingRealm {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UserRealm.class);
	
	@Resource
	LoginService loginService;
	
	@Override
	public String getName() {
		return "userRealm";
	}
	
	@Override
	public boolean supports(AuthenticationToken token) {
		return token instanceof UsernamePasswordToken;
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken)token;
		String userName = usernamePasswordToken.getUsername();
		if (null == usernamePasswordToken.getPassword()) {
			throw new AuthenticationException("请填写密码!");
		}
		String password = new String(usernamePasswordToken.getPassword());
		LOGGER.info("login info: username = {}, password = {}", userName, password);
		
		User user = new User(userName, password);
		
		//TODO 可以在此check登录次数
		
		try {
			loginService.login(user);
		} catch (AccountNotExistException e) {
			//账号不存在
			throw new UnknownAccountException();
		} catch (AccountLockedException e) {
			//账号被锁定
			throw new LockedAccountException();
		} catch (PasswordNotMatchException e) {
			//密码不正确
			throw new IncorrectCredentialsException();
		}
		
		AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(userName, password, getName());
		return authenticationInfo;
	}

}
