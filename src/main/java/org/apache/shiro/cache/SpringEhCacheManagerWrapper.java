/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package org.apache.shiro.cache;

/**
 * @description spring缓存管理器包装
 * @author yejunwu123@gmail.com
 * @since 2015年8月21日 下午5:36:52
 */
public class SpringEhCacheManagerWrapper implements CacheManager {
	
	private org.springframework.cache.CacheManager cacheManager;
	
	public void setCacheManager(org.springframework.cache.CacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

	@Override
	public Cache<Object, Object> getCache(String name) throws CacheException {
		org.springframework.cache.Cache springCache = cacheManager.getCache(name);
		return new SpringEhCacheWrapper(springCache);
	}

}
