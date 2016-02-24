/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package org.apache.shiro.web.filter;

import java.io.Serializable;
import java.util.Deque;
import java.util.LinkedList;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.DefaultSessionKey;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.WebUtils;

/**
 * @description 同账号多人登录过滤器
 * @author ywu@wuxicloud.com
 * 2016年2月18日 下午2:08:41
 */
public class KickoutSessionControlFilter extends AccessControlFilter {
	
	/**最多同时登录数*/
	private int maxSession = Integer.MAX_VALUE;
	/**是否剔除后登录者*/
	private boolean kickoutLater = true;
	
	private SessionManager sessionManager;
	/**剔除后跳转url*/
	private String kickoutUrl;
	
	private Map<String, Deque<Serializable>> map = new ConcurrentHashMap<String, Deque<Serializable>>();
	
	public int getMaxSession() {
		return maxSession;
	}

	public void setMaxSession(int maxSession) {
		this.maxSession = maxSession;
	}
	
	public boolean isKickoutLater() {
		return kickoutLater;
	}

	public void setKickoutLater(boolean kickoutLater) {
		this.kickoutLater = kickoutLater;
	}
	
	public void setSessionManager(SessionManager sessionManager) {
		this.sessionManager = sessionManager;
	}

	public void setKickoutUrl(String kickoutUrl) {
		this.kickoutUrl = kickoutUrl;
	}

	@Override
	protected boolean onAccessDenied(ServletRequest request,
			ServletResponse response) throws Exception {
		Subject subject = getSubject(request, response);
		if (!subject.isAuthenticated() && !subject.isRemembered()) {
			//如果没有登录,直接进行之后的流程
			//return true表示需要进行后续的处理
			return true;
		}
		
		Session session = subject.getSession();
		String userName = (String)subject.getPrincipal();
		Serializable sessionId = session.getId();
		Deque<Serializable> queue = map.get(userName);
		if (null == queue) {
			queue = new LinkedList<Serializable>();
			map.put(userName, queue);
		}
		
		//先放入队列,后面判断是否超过上限
		if (!queue.contains(sessionId)) {
			queue.push(sessionId);
		}
		
		//TODO session过期时需要从缓存中清除登录限制信息
		while(queue.size() > this.maxSession) {
			Serializable kickoutSessionId = null;
			if (kickoutLater) {
				kickoutSessionId = queue.removeFirst();
			} else {
				kickoutSessionId = queue.removeLast();
			}
			Session toKickoutSession = sessionManager.getSession(new DefaultSessionKey(kickoutSessionId));
			toKickoutSession.setAttribute("kickout", true);
		}
		
		if (null != session.getAttribute("kickout")) {
			subject.logout();
			saveRequest(request);  
	        WebUtils.issueRedirect(request, response, kickoutUrl);  
	        return false;
		}
		
		return true;
	}

	@Override
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse response, Object mappedValue) throws Exception {
		return false;
	}
}
