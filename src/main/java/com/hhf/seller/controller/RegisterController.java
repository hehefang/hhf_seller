/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.hhf.seller.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hhf.common.util.DateUtils;
import com.hhf.common.util.RequestUtils;
import com.hhf.common.util.SimpleCheckUtils;
import com.hhf.model.seller.SellerLogin;
import com.hhf.seller.util.LoginUtils;
import com.hhf.seller.util.LoginUtils.LoginInfo;
import com.hhf.service.seller.ISellerLoginService;
import com.alibaba.dubbo.common.utils.StringUtils;

/**
 * 卖家注册
 * 
 * @author xuzunyuan
 * @date 2014年1月8日
 */
@Controller
public class RegisterController {
	@Autowired
	private ISellerLoginService loginService;

	@RequestMapping("/register")
	public String register() {
		return "register/register";
	}

	@RequestMapping("/doRegister")
	public String doRegister(HttpServletRequest request,
			HttpServletResponse response, FormData formData) {

		// 检查入参
		SimpleCheckUtils.checkArgument(StringUtils.isNotEmpty(formData
				.getLoginName()));
		SimpleCheckUtils.checkArgument(StringUtils.isNotEmpty(formData
				.getPassword()));
		SimpleCheckUtils.checkArgument(StringUtils.isNotEmpty(formData
				.getMobile()));

		SellerLogin login = new SellerLogin();

		login.setMobile(formData.getMobile());
		login.setLoginName(formData.getLoginName());
		login.setLoginPwd(formData.getPassword());
		login.setNickname(formData.getNickname());
		login.setRegIp(RequestUtils.getRemoteAddr(request));
		login.setRegDate(DateUtils.currentDate());
		login.setLastLoginIp(RequestUtils.getRemoteAddr(request));
		login.setLastLoginDate(DateUtils.currentDate());

		int loginId = loginService.newLogin(login);

		if (loginId > 0) {
			// 自动完成登录
			LoginInfo loginInfo = new LoginInfo();
			loginInfo.setLoginName(login.getLoginName());
			loginInfo.setSellerLoginId(loginId);
			loginInfo.setNickName(login.getNickname());

			LoginUtils.registerLoginInfo(request, response, loginInfo);

			return "register/success";
		} else {
			return "register/register";
		}
	}

	public static final class FormData {
		private String loginName;
		private String password;
		private String mobile;
		private String nickname;

		public String getNickname() {
			return nickname;
		}

		public void setNickname(String nickname) {
			this.nickname = nickname;
		}

		public String getLoginName() {
			return loginName;
		}

		public void setLoginName(String loginName) {
			this.loginName = loginName;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getMobile() {
			return mobile;
		}

		public void setMobile(String mobile) {
			this.mobile = mobile;
		}
	}
}
