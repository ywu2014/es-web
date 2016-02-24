/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package org.apache.shiro.cache;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import net.sf.ehcache.Ehcache;

import org.springframework.cache.support.SimpleValueWrapper;

/**
 * @description spring缓存包装
 * @author yejunwu123@gmail.com
 * @since 2015年8月21日 下午5:38:13
 */
public class SpringEhCacheWrapper implements Cache<Object, Object> {
	
	private org.springframework.cache.Cache springCache;
	
	public SpringEhCacheWrapper(org.springframework.cache.Cache cache) {
		this.springCache = cache;
	}

	@Override
	public Object get(Object key) throws CacheException {
		Object value = springCache.get(key);
		if (value instanceof SimpleValueWrapper) {
			return ((SimpleValueWrapper)value).get();
		}
		return value;
	}

	@Override
	public Object put(Object key, Object value) throws CacheException {
		springCache.put(key, value);
		return value;
	}

	@Override
	public Object remove(Object key) throws CacheException {
		springCache.evict(key);
		return null;
	}

	@Override
	public void clear() throws CacheException {
		springCache.clear();
	}

	@Override
	public int size() {
		if (springCache.getNativeCache() instanceof Ehcache) {
			return (int)((Ehcache)springCache).getSize();
		}
		throw new UnsupportedOperationException("invoke spring cache abstract size method not support");
	}

	@Override
	public Set<Object> keys() {
		if (springCache.getNativeCache() instanceof Ehcache) {
			@SuppressWarnings("unchecked")
			List<Object> keys = ((Ehcache)springCache).getKeys();
			return new HashSet<Object>(keys);
		}
		throw new UnsupportedOperationException("invoke spring cache abstract keys method not support");
	}

	@Override
	public Collection<Object> values() {
		throw new UnsupportedOperationException("invoke spring cache abstract values method not support");
	}

}
