/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jiangnan.es.login.exception;

import com.jiangnan.es.common.exception.ApplicationException;

/**
 * @description 用户不存在异常
 * @author ywu@wuxicloud.com
 * 2016年2月18日 上午10:06:51
 */
public class AccountNotExistException extends ApplicationException {

	private static final long serialVersionUID = -5441794349513569089L;
	
	/**
	 * @param code
	 * @param defaultMessage
	 * @param args
	 */
	public AccountNotExistException(String code, String defaultMessage,
			Object[] args) {
		super(code, defaultMessage, args);
	}

	public AccountNotExistException() {
		this("account.not.exists", null, null);
	}

}
