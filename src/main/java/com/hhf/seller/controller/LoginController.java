/**
 * Copyright (c)2013-2014 by www.hhf.com. All rights reserved.
 * 
 */
package com.hhf.seller.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.ConvertUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hhf.common.util.RequestUtils;
import com.hhf.common.util.SimpleCheckUtils;
import com.hhf.seller.service.IValidatorService;
import com.hhf.seller.util.LoginUtils;
import com.hhf.seller.util.LoginUtils.LoginInfo;
import com.hhf.service.seller.ISellerLoginService;
import com.hhf.service.seller.ISellerLoginService.SellerLoginValidate;
import com.alibaba.dubbo.common.utils.StringUtils;

/**
 * 卖家登录控制器
 * 
 * @author xuzunyuan
 * @date 2014年1月6日
 */
@Controller
public class LoginController {
	private static final Logger log = LoggerFactory
			.getLogger(LoginController.class);

	private static final String sellerLoginErrCountCookieKey = "__c";

	@Autowired
	ISellerLoginService loginService;

	@Autowired
	IValidatorService validatorService;

	@RequestMapping("/login")
	public String login(HttpServletRequest request) {
		return LoginUtils.isLogined(request) ? "redirect:/ws/main"
				: "/login/login";
	}

	@RequestMapping("/logout")
	public String logout(HttpServletRequest request,
			HttpServletResponse response) {

		LoginUtils.removeLoginInfo(request, response);

		return "redirect:/login";
	}

	@RequestMapping("/loginValidate")
	public String validate(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("loginName") String loginName,
			@RequestParam("password") String password,
			@RequestParam(value = "validator", required = false) String validator) {

		SimpleCheckUtils.checkArgument(StringUtils.isNotEmpty(loginName)
				&& StringUtils.isNotEmpty(password));

		final String MSG_KEY = "errorMsg";
		SellerLoginValidate validate = null;
		int errCount = getErrCount(request);

		if (errCount >= 3) {
			SimpleCheckUtils.checkArgument(validator != null);

			if (!validatorService.checkValidator(request, validator)) {
				request.setAttribute(MSG_KEY, "验证码不正确");
				return "/login/login";
			}
		}

		try {
			validate = loginService.loginByLoginName(loginName, password,
					RequestUtils.getRemoteAddr(request));

			// 正常通过验证，定向到主工作台
			if (validate.getValidateStatus() == SellerLoginValidate.PASSED) {
				LoginInfo loginInfo = new LoginInfo();

				loginInfo
						.setSellerId(validate.getSellerLogin().getSellerId() == null ? 0
								: validate.getSellerLogin().getSellerId());
				loginInfo.setSellerLoginId(validate.getSellerLogin()
						.getSellerLoginId());
				loginInfo.setNickName(validate.getSellerLogin().getNickname());
				loginInfo
						.setLoginName(validate.getSellerLogin().getLoginName());
				loginInfo.setType(validate.getSellerLogin().getType());
				if (validate.getSeller() != null) {
					loginInfo.setIsPaidDeposit(validate.getSeller()
							.getIsPaidDeposit());
				}

				LoginUtils.registerLoginInfo(request, response, loginInfo);

				// 删除错误计数
				resetErrCount(request, response);

				return "redirect:/ws/summary?m=1001";

			}
			// 登录失败
			else {
				if (validate.getValidateStatus() == SellerLoginValidate.NOT_EXIST)
					request.setAttribute(MSG_KEY, "会员名不存在");
				else if (validate.getValidateStatus() == SellerLoginValidate.FREEZED) {
					request.setAttribute(MSG_KEY, "会员名已冻结");
				} else if (validate.getValidateStatus() == SellerLoginValidate.INCORRECT_PASSWORD) {
					request.setAttribute(MSG_KEY, "会员名和密码不匹配");
				}
			}

		} catch (Exception e) {
			log.error(e.getMessage(), e);
			request.setAttribute(MSG_KEY, "系统发生异常，请稍后再试...");
		}

		increaseErrCount(request, response);
		return "/login/login";
	}

	/**
	 * 重置登录错误计数
	 * 
	 * @param request
	 * @param response
	 */
	private void resetErrCount(HttpServletRequest request,
			HttpServletResponse response) {
		RequestUtils.deleteCookie(request, response,
				sellerLoginErrCountCookieKey, false);
	}

	/**
	 * 错误计数 + 1
	 * 
	 * @param request
	 * @param response
	 */
	private void increaseErrCount(HttpServletRequest request,
			HttpServletResponse response) {

		String errCookie = RequestUtils.getCookieValue(request,
				sellerLoginErrCountCookieKey);
		int errCount;

		if (StringUtils.isBlank(errCookie)) {
			errCount = 1;
		} else {
			errCount = (int) ConvertUtils.convert(errCookie, int.class);
			errCount++;
		}
		RequestUtils.setCookie(request, response, sellerLoginErrCountCookieKey,
				errCount + "", 0, false);
	}

	/**
	 * 获取错误计数
	 * 
	 * @param request
	 * @return
	 */
	private int getErrCount(HttpServletRequest request) {

		String errCookie = RequestUtils.getCookieValue(request,
				sellerLoginErrCountCookieKey);
		int errCount;

		if (StringUtils.isBlank(errCookie)) {
			errCount = 0;
		} else {
			errCount = (int) ConvertUtils.convert(errCookie, int.class);
		}

		return errCount;
	}
}
