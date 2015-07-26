/**
 * Copyright (c)2015-? by www.hhf.com. All rights reserved.
 * 
 */
package com.hhf.seller.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hhf.common.exception.TechException;
import com.hhf.constants.product.ProductConstants.SellerBrand$Status;
import com.hhf.model.product.Brand;
import com.hhf.model.product.SellerBrand;
import com.hhf.seller.util.LoginUtils;
import com.hhf.service.product.IBrandService;
import com.hhf.service.product.ISellerBrandService;

/**
 * 品牌管理
 * 
 * @author xuzunyuan
 * @date 2015年2月6日
 */
@Controller
public class SellerBrandController {
	@Autowired
	ISellerBrandService sellerBrandService;

	@Autowired
	IBrandService brandService;

	@RequestMapping("/product/brand")
	public String list(HttpServletRequest request) {
		List<SellerBrand> brands = sellerBrandService
				.getSellerBrandList(LoginUtils.getLoginInfo(request)
						.getSellerId());

		request.setAttribute("brands", brands);

		return "/sellerBrand/brandList";
	}

	@RequestMapping("/product/brandPage")
	public String page(
			HttpServletRequest request,
			@RequestParam(value = "sellerBrandId", required = false) Integer sellerBrandId) {

		if (sellerBrandId != null && sellerBrandId != 0) {
			SellerBrand sellerBrand = sellerBrandService
					.getSellerBrandById(sellerBrandId);

			if (!SellerBrand$Status.REJECT.equals(sellerBrand.getStatus())) {
				throw new TechException();
			}

			Brand brand = brandService.getByBrandId(sellerBrand.getBrandId()
					.longValue());

			sellerBrand.setBrandName(brand.getBrandName());
			sellerBrand.setBrandEname(brand.getBrandEname());

			request.setAttribute("sellerBrand", sellerBrand);
		}

		return "/sellerBrand/brandPage";
	}

	@RequestMapping("/product/brandCommit")
	public String page(HttpServletRequest request, SellerBrand sellerBrand) {
		sellerBrand.setSellerId(LoginUtils.getLoginInfo(request).getSellerId());

		if (sellerBrand.getSellerBrandId() == null
				|| sellerBrand.getSellerBrandId() == 0) {

			sellerBrandService.applySellerBrand(sellerBrand);

		} else {
			sellerBrandService.updateApplySellerBrand(sellerBrand);
		}

		return "redirect:/product/brandPage?m=2004&f=1";
	}
}
