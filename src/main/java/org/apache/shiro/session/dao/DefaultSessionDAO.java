/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package org.apache.shiro.session.dao;

import java.io.Serializable;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.EnterpriseCacheSessionDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @description 默认session dao实现,不进行持久化,只是利用缓存功能
 * @author ywu@wuxicloud.com
 * 2016年2月24日 下午1:47:53
 */
public class DefaultSessionDAO extends EnterpriseCacheSessionDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DefaultSessionDAO.class);
	
	@Override
	protected Session doReadSession(Serializable sessionId) {
		LOGGER.info("do read session {}...", sessionId);
		return null;
	}
	
	@Override
	protected void doUpdate(Session session) {
		//LOGGER.info("do update session {}...", session.getId());
		
		//TODO session的touch()、setAttribute()等方法会频繁调用此方法,导致更新频繁
	}
	
	@Override
	protected void doDelete(Session session) {
		LOGGER.info("do delete session {}...", session.getId());
	}
}
