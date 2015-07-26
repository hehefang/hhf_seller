/**
 * Copyright (c)2013-2014 by www.hhf.com. All rights reserved.
 * 
 */
package com.hhf.seller.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.ConvertUtils;

import com.hhf.common.encrypt.MD5Encrypt;
import com.hhf.common.util.DateUtils;
import com.hhf.common.util.RequestUtils;
import com.alibaba.dubbo.common.utils.StringUtils;

/**
 * 登录工具
 * 
 * @author xuzunyuan
 * @date 2014年1月6日
 */
public class LoginUtils {
	private static final String COOKIE_S_NAME = "__s";
	private static final String COOKIE_SM_NAME = "__sm";
	private static final String COOKIE_ST_NAME = "__st";
	private static final String SPLITTER = "|";
	private static final String SPLITTER_REGEXP = "\\|";
	private static final String PUBLIC_KEY = "hhf_2015";
	private static final String ATTR_LOGIN_INFO_NAME = "loginInfo";
	private static final int DEFAULT_MAX_AGE = 7 * 24 * 60 * 60; // __s默认生存一周(单位为秒)
	private static final int DEFAULT_LIVE_PERIOD = 2 * 60 * 60 * 1000; // __st默认生存两小时(单位为毫秒)
	private static final String CLIENT_DT_PARAM_NAME = "clientDt";

	/**
	 * 根据客户端cookie严格验证是否已登录
	 * 
	 * @param request
	 * @return
	 */
	public static final boolean isLogined(HttpServletRequest request) {
		// 验证三个cookie是否存在
		Cookie __s = RequestUtils.getCookie(request, COOKIE_S_NAME);
		if (__s == null)
			return false;

		Cookie __sm = RequestUtils.getCookie(request, COOKIE_SM_NAME);
		if (__sm == null)
			return false;

		Cookie __st = RequestUtils.getCookie(request, COOKIE_ST_NAME);
		if (__st == null)
			return false;

		// 校验__s cookie的格式
		if (getLoginInfo(request) == null)
			return false;

		// 验证当前时间比st时间要早，st的格式为失效时间（时间戳格式）| 客户端与服务器端时间差（秒）
		String[] s_timestamps = __st.getValue().split(SPLITTER_REGEXP);
		if (s_timestamps.length != 2)
			return false;

		long l_timestamps;

		try {
			l_timestamps = (long) ConvertUtils.convert(s_timestamps[0],
					long.class);
		} catch (Exception e) {
			return false; // 异常情况认为cookie认为损坏，要求重新登录
		}

		if (DateUtils.currentDate().getTime() > l_timestamps) {
			return false;
		}

		// 验证sm字符串符合md5(__s + key + $_SERVER[‘HTTP_USER_AGENT’])的加密规则
		String encrypt = MD5Encrypt.md5(__s.getValue() + PUBLIC_KEY
				+ RequestUtils.getUserAgent(request));

		return (encrypt.equals(__sm.getValue()));
	}

	/**
	 * 从__s cookie中取出用户登录信息，格式为seller_id | seller_login_id | store_id |
	 * nick_name | login_name | type | level
	 * 
	 * @param request
	 * @return 当__s cookie不存在或格式损坏时返回null
	 */
	public static final LoginInfo getLoginInfo(HttpServletRequest request) {
		LoginInfo loginInfo = null;

		loginInfo = (LoginInfo) request.getAttribute(ATTR_LOGIN_INFO_NAME);
		if (loginInfo == null) {
			Cookie __s = RequestUtils.getCookie(request, COOKIE_S_NAME);
			if (__s == null)
				return null;

			String[] values = __s.getValue().split(SPLITTER_REGEXP);
			if (values.length != 6)
				return null;

			loginInfo = new LoginInfo();

			try {
				loginInfo.setSellerId((int) ConvertUtils.convert(values[0],
						int.class));

				// 只有loginId不允许为0
				loginInfo.setSellerLoginId((int) ConvertUtils.convert(
						values[1], int.class));
				if (loginInfo.getSellerLoginId() == 0)
					return null;

				loginInfo.setNickName(values[2]);
				loginInfo.setLoginName(values[3]);
				loginInfo.setType(values[4]);
				loginInfo.setIsPaidDeposit(values[5]);

			} catch (Exception e) {
				return null;
			}

			request.setAttribute(ATTR_LOGIN_INFO_NAME, loginInfo);
		}

		return loginInfo;
	}

	/**
	 * 注册登录信息到cookie
	 * 
	 * @param response
	 * @param loginInfo
	 */
	public static void registerLoginInfo(HttpServletRequest request,
			HttpServletResponse response, LoginInfo loginInfo) {
		// __s cookie
		String __s = loginInfo.getSellerId()
				+ SPLITTER
				+ loginInfo.getSellerLoginId()
				+ SPLITTER
				+ (loginInfo.getNickName() == null ? "" : loginInfo
						.getNickName())
				+ SPLITTER
				+ loginInfo.getLoginName()
				+ SPLITTER
				+ (loginInfo.getType() == null ? "" : loginInfo.getType())
				+ SPLITTER
				+ (loginInfo.getIsPaidDeposit() == null ? "0" : loginInfo
						.getIsPaidDeposit());

		RequestUtils.setCookie(request, response, COOKIE_S_NAME, __s,
				DEFAULT_MAX_AGE, false);

		// __sm cookie
		String __sm = MD5Encrypt.md5(__s + PUBLIC_KEY
				+ RequestUtils.getUserAgent(request));

		RequestUtils.setCookie(request, response, COOKIE_SM_NAME, __sm, 0,
				false);

		// __st cookie
		long serverTime = DateUtils.currentDate().getTime();

		long timediffer = 0; // 客户端服务端时间差(客户端 - 服务端)

		String clientTime = request.getParameter(CLIENT_DT_PARAM_NAME);
		if (!StringUtils.isBlank(clientTime)) {
			timediffer = ((long) ConvertUtils.convert(clientTime, long.class))
					- serverTime;
		}

		RequestUtils.setCookie(request, response, COOKIE_ST_NAME,
				((serverTime + DEFAULT_LIVE_PERIOD) + SPLITTER + timediffer),
				0, false);
	}

	/**
	 * 去除登录信息cookie
	 * 
	 * @param request
	 * @param response
	 */
	public static void removeLoginInfo(HttpServletRequest request,
			HttpServletResponse response) {

		RequestUtils.deleteCookie(request, response, COOKIE_SM_NAME, false);
		RequestUtils.deleteCookie(request, response, COOKIE_ST_NAME, false);
	}

	/**
	 * 
	 * 卖家的登录信息
	 * 
	 * @author xuzunyuan
	 * @date 2014年1月6日
	 */
	public static class LoginInfo {
		private int sellerId;
		private int sellerLoginId;
		private String nickName;
		private String loginName;
		private String type;
		private String isPaidDeposit; // 保证金缴纳标志

		public int getSellerId() {
			return sellerId;
		}

		public void setSellerId(int sellerId) {
			this.sellerId = sellerId;
		}

		public int getSellerLoginId() {
			return sellerLoginId;
		}

		public void setSellerLoginId(int sellerLoginId) {
			this.sellerLoginId = sellerLoginId;
		}

		public String getNickName() {
			return nickName;
		}

		public void setNickName(String nickName) {
			this.nickName = nickName;
		}

		public String getLoginName() {
			return loginName;
		}

		public void setLoginName(String loginName) {
			this.loginName = loginName;
		}

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

		public String getIsPaidDeposit() {
			return isPaidDeposit;
		}

		public void setIsPaidDeposit(String isPaidDeposit) {
			this.isPaidDeposit = isPaidDeposit;
		}
	}
}
