/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package org.apache.shiro.session.listener;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.SessionListenerAdapter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @description 默认回话监听器
 * @author ywu@wuxicloud.com
 * 2016年2月24日 上午10:38:05
 */
public class DefaultSessionListenerAdapter extends SessionListenerAdapter {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DefaultSessionListenerAdapter.class);
	
	@Override
	public void onStart(Session session) {
		LOGGER.info("shiro session {} start...", session.getId());
		super.onStart(session);
	}
	
	@Override
	public void onExpiration(Session session) {
		//TODO KickoutSessionControlFilter中需要清除登录信息
		LOGGER.info("shiro session {} expirated...", session.getId());
		super.onExpiration(session);
	}
	
	@Override
	public void onStop(Session session) {
		//TODO KickoutSessionControlFilter中需要清除登录信息
		LOGGER.info("shiro session {} stop...", session.getId());
		super.onStop(session);
	}
}
