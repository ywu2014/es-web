/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package org.apache.shiro.credential;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;

/**
 * @description 限制登录次数
 * @author ywu@wuxicloud.com
 * 2016年2月18日 下午6:00:17
 */
public class RetryLimitCredentialsMatcher extends HashedCredentialsMatcher {
	
	@Override
	public boolean doCredentialsMatch(AuthenticationToken token,
			AuthenticationInfo info) {
		//TODO 可以在此check登录次数
		
		return true;
	}
}
