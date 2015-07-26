/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.hhf.seller.service.impl;

import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.hhf.common.util.RequestUtils;
import com.hhf.seller.service.IValidatorService;

/**
 * 验证码服务
 * 
 * @author xuzunyuan
 * @date 2014年6月18日
 */
@Service
public class ValidatorService implements IValidatorService {
	private static final String SELLER_VALIDATOR_PREFIX = "hhf_seller_login_validator_prefix_";

	@Autowired
	private RedisTemplate<String, String> redisTemplate;

	@Override
	public void registerValidator(HttpServletRequest request, String validator,
			int period) {
		redisTemplate.opsForValue().set(
				SELLER_VALIDATOR_PREFIX
						+ RequestUtils.getCookieValue(request, "JSESSIONID"),
				validator, period, TimeUnit.SECONDS);
	}

	@Override
	public boolean checkValidator(HttpServletRequest request, String validator) {
		String cachedValidator = (String) redisTemplate.opsForValue().get(
				SELLER_VALIDATOR_PREFIX
						+ RequestUtils.getCookieValue(request, "JSESSIONID"));

		return validator.equalsIgnoreCase(cachedValidator);
	}

}
