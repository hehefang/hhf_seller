/**
 * Copyright (c)2013-2014 by www.hhf.com. All rights reserved.
 * 
 */
package com.hhf.seller.service;

import javax.servlet.http.HttpServletRequest;

/**
 * 验证码服务
 * 
 * @author xuzunyuan
 * @date 2014年6月18日
 */
public interface IValidatorService {
	public void registerValidator(HttpServletRequest request, String validator,
			int period);

	public boolean checkValidator(HttpServletRequest request, String validator);
}
