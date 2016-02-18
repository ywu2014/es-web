/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jiangnan.es.login.service;

import com.jiangnan.es.authorization.user.entity.User;

/**
 * @description 登录业务接口
 * @author ywu@wuxicloud.com
 * 2016年2月18日 上午10:01:18
 */
public interface LoginService {
	User login(User user);
}
