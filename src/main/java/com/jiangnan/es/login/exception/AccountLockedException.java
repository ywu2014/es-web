/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jiangnan.es.login.exception;

import com.jiangnan.es.common.exception.ApplicationException;

/**
 * @description 账号锁定异常
 * @author ywu@wuxicloud.com
 * 2016年2月18日 上午10:30:11
 */
public class AccountLockedException extends ApplicationException {
	
	private static final long serialVersionUID = 6885439420865899825L;
	
	/**
	 * @param code
	 * @param defaultMessage
	 * @param args
	 */
	public AccountLockedException(String code, String defaultMessage,
			Object[] args) {
		super(code, defaultMessage, args);
	}

	public AccountLockedException() {
		this("account.locked", null, null);
	}
}
