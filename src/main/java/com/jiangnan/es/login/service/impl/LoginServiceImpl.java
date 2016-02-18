/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jiangnan.es.login.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jiangnan.es.authorization.user.entity.User;
import com.jiangnan.es.authorization.user.entity.UserState;
import com.jiangnan.es.authorization.user.service.PasswordService;
import com.jiangnan.es.authorization.user.service.UserService;
import com.jiangnan.es.login.exception.AccountLockedException;
import com.jiangnan.es.login.exception.AccountNotExistException;
import com.jiangnan.es.login.service.LoginService;
import com.jiangnan.es.util.StringUtils;

/**
 * @description 登录业务实现类
 * @author ywu@wuxicloud.com
 * 2016年2月18日 上午10:02:33
 */
@Service
public class LoginServiceImpl implements LoginService {
	
	@Resource
	UserService userservice;
	@Resource
	PasswordService passwordService;

	@Override
	public User login(User user) {
		String userName = user.getUserName();
		String password = user.getPassword();
		if (!StringUtils.hasText(userName)
				|| !StringUtils.hasText(password)) {
			throw new AccountNotExistException();
		}
		User u = userservice.findByUserName(userName);
		if (null == u) {
			throw new AccountNotExistException();
		}
		
		//验证账号锁定
		if (UserState.LOCK == u.getState()) {
			throw new AccountLockedException();
		}
		
		//验证密码过期
		
		//同一账号多人登录
		
		//验证密码
		passwordService.validate(u, user.getPassword());
		return u;
	}

}
