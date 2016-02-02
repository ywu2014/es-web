/**
 * Copyright (c) 2015-2016 yejunwu126@126.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jiangnan.es.index.web.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jiangnan.es.authorization.resource.entity.Resource;
import com.jiangnan.es.authorization.resource.service.ResourceService;
import com.jiangnan.es.common.web.controller.BaseController;

/**
 * @description 首页
 * @author ywu@wuxicloud.com
 * 2016年1月17日 下午4:48:10
 */
@RequestMapping("system/")
@Controller
public class IndexController extends BaseController {
	
	@javax.annotation.Resource
	ResourceService resourceService;
	
	@RequestMapping("/")
	public String index(Model model) {
		List<Resource> resources = resourceService.list();
		List<Resource> menus = resourceService.convertCascade(resources);
		//System.out.println(JsonUtils.object2JsonString(menus));
		model.addAttribute("menus", menus);
		return "system/index";
	}
	
	@RequestMapping("calendar")
	public String calendar() {
		return "system/common/calendar";
	}
}
