/**
 * Copyright (c)2013-2014 by www.hhf.com. All rights reserved.
 * 
 */
package com.hhf.seller.controller;

import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hhf.common.exception.BizException;
import com.hhf.common.util.SimpleCheckUtils;
import com.hhf.model.seller.SellerLogin;
import com.hhf.seller.service.IValidatorService;
import com.hhf.service.seller.ISellerLoginService;
import com.hhf.service.sms.ISmsService;
import com.alibaba.dubbo.common.utils.StringUtils;

/**
 * 忘记密码控制器
 * 
 * @author xuzunyuan
 * @date 2014年3月3日
 */
@Controller
public class ForgetController {
	@Autowired
	ISellerLoginService loginService;

	@Autowired
	IValidatorService validatorService;

	@Autowired
	ISmsService smsService;

	@Autowired
	private RedisTemplate<String, String> redisTemplate;

	@RequestMapping("/forget/step1")
	public String forget() {
		return "forget/forget1";
	}

	@RequestMapping("/forget/step2")
	public String forgetStep2(HttpServletRequest request, FormData formData) {
		SimpleCheckUtils.checkArgument(!StringUtils.isBlank(formData
				.getLoginName()));
		SimpleCheckUtils.checkArgument(!StringUtils.isBlank(formData
				.getValidator()));

		if (!validatorService.checkValidator(request, formData.getValidator())) {
			request.setAttribute("msg", "验证码不正确！");
			return "forget/forget1";
		}

		SellerLogin login = loginService.getLoginByLoginName(formData
				.getLoginName());

		if (login == null) {
			request.setAttribute("msg", "用户名不存在！");
			return "forget/forget1";
		}

		request.setAttribute("mobile", login.getMobile());

		return "forget/forget2";
	}

	@RequestMapping("/forget/step3")
	public String forgetStep3(HttpServletRequest request, FormData formData) {
		SimpleCheckUtils.checkArgument(!StringUtils.isBlank(formData
				.getLoginName()));
		SimpleCheckUtils.checkArgument(!StringUtils.isBlank(formData
				.getMobile()));
		SimpleCheckUtils.checkArgument(!StringUtils.isBlank(formData.getSms()));

		// 校验验证码，防攻击
		String cachedValidator = (String) redisTemplate.opsForValue().get(
				AjaxController.SELLER_FORGOT_PASSWORD_VALIDATOR_PREFIX
						+ formData.getMobile());

		if (!formData.getSms().equals(cachedValidator)) {
			request.setAttribute("msg", "您的操作时间过长导致验证失效，请重新操作！");
			return "forget/forget1";
		}

		redisTemplate.opsForValue().set(
				"SELLER_FORGOT_SMS_VALIDATED" + formData.getMobile(), "1", 300,
				TimeUnit.SECONDS);

		return "forget/forget3";
	}

	@RequestMapping("/forget/step4")
	public String forgetStep4(HttpServletRequest request, FormData formData)
			throws BizException {
		SimpleCheckUtils.checkArgument(!StringUtils.isBlank(formData
				.getLoginName()));
		SimpleCheckUtils.checkArgument(!StringUtils.isBlank(formData
				.getMobile()));
		SimpleCheckUtils.checkArgument(!StringUtils.isBlank(formData
				.getPassword()));
		SimpleCheckUtils.checkArgument(!StringUtils.isBlank(formData
				.getConfirmPassword()));

		String passFlag = (String) redisTemplate.opsForValue().get(
				"SELLER_FORGOT_SMS_VALIDATED" + formData.getMobile());

		if (!"1".equals(passFlag)) {
			request.setAttribute("msg", "您的操作时间过长导致验证失效，请重新操作！");
			return "forget/forget1";
		}

		SellerLogin login = loginService.getLoginByLoginName(formData
				.getLoginName());

		if (login == null)
			throw new BizException("用户名不存在！");

		loginService.changePassword(login.getSellerLoginId(),
				formData.getPassword(), null);

		return "forget/forget4";
	}

	public static final class FormData {
		private String loginName;
		private String validator;
		private String mobile;
		private String sms;
		private String password;
		private String confirmPassword;

		public String getLoginName() {
			return loginName;
		}

		public void setLoginName(String loginName) {
			this.loginName = loginName;
		}

		public String getValidator() {
			return validator;
		}

		public void setValidator(String validator) {
			this.validator = validator;
		}

		public String getMobile() {
			return mobile;
		}

		public void setMobile(String mobile) {
			this.mobile = mobile;
		}

		public String getSms() {
			return sms;
		}

		public void setSms(String sms) {
			this.sms = sms;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getConfirmPassword() {
			return confirmPassword;
		}

		public void setConfirmPassword(String confirmPassword) {
			this.confirmPassword = confirmPassword;
		}
	}
}
