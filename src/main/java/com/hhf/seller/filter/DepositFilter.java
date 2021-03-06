package com.hhf.seller.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhf.constants.seller.SellerConstants.Seller$IsPaidDeposit;
import com.hhf.seller.util.LoginUtils;
import com.hhf.seller.util.LoginUtils.LoginInfo;

public class DepositFilter implements Filter {
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// do nothing

	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain filterChain) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;

		LoginInfo loginInfo = LoginUtils.getLoginInfo(request);

		if (loginInfo == null
				|| !(Seller$IsPaidDeposit.CHARGED).equals(loginInfo
						.getIsPaidDeposit())) {
			response.sendError(404);
			return;
		}

		filterChain.doFilter(request, response);

	}

	@Override
	public void destroy() {
		// do nothing

	}

}
