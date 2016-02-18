/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jiangnan.es.login;

import org.junit.Test;

import com.jiangnan.es.authorization.user.entity.User;
import com.jiangnan.es.authorization.user.service.PasswordService;
import com.jiangnan.es.authorization.user.service.impl.DefaultPasswordServiceImpl;

/**
 * @description TODO
 * @author ywu@wuxicloud.com
 * 2016年2月18日 下午1:42:16
 */
public class PasswordServiceTest {
	
	@Test()
	public void testGeneratePassword() {
		PasswordService passwordService = new DefaultPasswordServiceImpl();
		User user = new User("张三", "passw0rd");
		user.setSalt("P0C2a1eCua");
		String encryptedPassword = passwordService.encrypt(user);
		System.out.println(encryptedPassword);
	}
}
