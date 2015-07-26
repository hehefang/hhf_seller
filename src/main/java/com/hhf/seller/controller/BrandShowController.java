/**
 * Copyright (c)2015-? by www.hhf.com. All rights reserved.
 * 
 */
package com.hhf.seller.controller;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hhf.common.mybatis.Page;
import com.hhf.common.util.DateUtils;
import com.hhf.common.util.RequestUtils;
import com.hhf.model.product.BrandShow;
import com.hhf.model.product.BrandShowDetail;
import com.hhf.seller.util.LoginUtils;
import com.hhf.seller.util.LoginUtils.LoginInfo;
import com.hhf.service.order.ILogisticsCompanyService;
import com.hhf.service.product.IBrandService;
import com.hhf.service.product.IBrandShowService;
import com.hhf.service.product.ISellerBrandService;
import com.hhf.service.seller.ISellerRetAddrService;
import com.hhf.service.seller.ISellerService;
import com.google.common.collect.Maps;

/**
 * 品牌特卖
 * 
 * @author xuzunyuan
 * @date 2015年2月27日
 */
@Controller
public class BrandShowController {
	@Autowired
	ISellerService sellerService;

	@Autowired
	IBrandShowService brandShowService;

	@Autowired
	ISellerBrandService sellerBrandService;

	@Autowired
	IBrandService brandService;

	@Autowired
	ISellerRetAddrService sellerRetAddrService;

	@Autowired
	ILogisticsCompanyService logisticsCompanyService;

	@Autowired
	private RedisTemplate<String, QueryForm> redisTemplate;

	// 综述
	@RequestMapping("/brandShow/show")
	public String brandShow(
			HttpServletRequest request,
			@RequestParam(value = "brandShowId", required = false) Integer brandShowId) {

		if (brandShowId != null && brandShowId != 0) {
			BrandShow brandShow = brandShowService
					.getBrandShowById(brandShowId);

			request.setAttribute("brandShow", brandShow);
		}

		LoginInfo loginInfo = LoginUtils.getLoginInfo(request);

		// 准备卖家品牌数据
		request.setAttribute("brandList", sellerBrandService
				.getValidBrandListOfSeller(loginInfo.getSellerId()));

		// 准备退货地址数据
		request.setAttribute("retAddrList", sellerRetAddrService
				.getValidAddrListOfSeller(loginInfo.getSellerId()));

		// 准备物流公司数据
		request.setAttribute("lcList",
				logisticsCompanyService.getValidLogisticsCompany());

		return "/brandShow/show";
	}

	// 下一步（保存特卖并来到明细页面）
	@RequestMapping("/brandShow/saveShow")
	public String saveBrandShow(HttpServletRequest request, BrandShow brandShow) {
		LoginInfo loginInfo = LoginUtils.getLoginInfo(request);
		brandShow.setSellerId(loginInfo.getSellerId());
		brandShow.setBrandName(brandService.getByBrandId(
				brandShow.getBrandId().longValue()).getBrandName());

		if (brandShow.getBrandShowId() == null
				|| brandShow.getBrandShowId() == 0) {
			brandShow.setCreateByDate(DateUtils.currentDate());
			brandShow.setCoName(sellerService.getSellerById(
					loginInfo.getSellerId()).getCoName());
			int brandShowId = brandShowService.newBrandShow(brandShow);
			brandShow.setBrandShowId(brandShowId);

		} else {
			brandShowService.modifyBrandShow(brandShow);
		}

		return "redirect:/brandShow/detail?m=3002&brandShowId="
				+ brandShow.getBrandShowId();
	}

	// 明细页面
	@RequestMapping("/brandShow/detail")
	public String brandShowDetail(HttpServletRequest request,
			@RequestParam("brandShowId") Integer brandShowId) {

		BrandShow brandShow = brandShowService.getBrandShowById(brandShowId);
		request.setAttribute("brandShow", brandShow);

		request.setAttribute("brand",
				brandService.getByBrandId(brandShow.getBrandId().longValue()));

		List<BrandShowDetail> brandShowDetailList = brandShowService
				.getDetailsOfBrandShow(brandShow.getBrandShowId());

		request.setAttribute("brandShowDetailList", brandShowDetailList);

		return "/brandShow/detail";
	}

	// 提交审核
	@RequestMapping("/brandShow/submitBrandShow")
	public String brandShowSubmit(DetailForm form, HttpServletRequest request) {
		LoginInfo loginInfo = LoginUtils.getLoginInfo(request);
		Date now = DateUtils.currentDate();

		BrandShowDetail[] details = new BrandShowDetail[form.getbSDId().length];

		for (int i = 0; i < form.getbSDId().length; i++) {
			BrandShowDetail detail = new BrandShowDetail();

			detail.setbSDId(form.getbSDId()[i]);
			detail.setBrandShowId(form.getBrandShowId());
			detail.setShowPrice(form.getShowPrice()[i]);
			detail.setShowBalance(form.getShowBalance()[i]);
			detail.setDiscount(form.getDiscount()[i]);
			detail.setProdId(form.getProdId()[i]);
			detail.setProdCode(form.getProdCode()[i]);
			detail.setSkuCode(form.getSkuCode()[i]);
			detail.setSkuId(form.getSkuId()[i]);
			detail.setProdName(form.getProdName()[i]);
			detail.setProdTitle(form.getProdTitle()[i]);
			detail.setProdImg(form.getProdImg()[i]);
			detail.setSkuSpecName(form.getSkuSpecName()[i]);
			detail.setOrgPrice(form.getOrgPrice()[i]);
			detail.setArtNo(form.getArtNo()[i]);

			if (form.getbSDId()[i] == null || form.getbSDId()[i] == 0) {
				detail.setCreateByDate(now);
				detail.setCreateByName(loginInfo.getLoginName());
			}

			details[i] = detail;
		}

		brandShowService.submitBrandShow(form.getBrandShowId(), details);

		return "redirect:/brandShow/list?m=3001";
	}

	@RequestMapping("/brandShow/list")
	public String brandShowList(HttpServletRequest request, QueryForm form) {
		if (form != null && form.getTitle() != null) {
			redisTemplate
					.opsForValue()
					.set("hhf_brandShowList_"
							+ RequestUtils
									.getCookieValue(request, "JSESSIONID"),
							form, 600, TimeUnit.SECONDS);
		} else {
			form = (QueryForm) redisTemplate.opsForValue().get(
					"hhf_brandShowList_"
							+ RequestUtils
									.getCookieValue(request, "JSESSIONID"));
			if (form == null)
				form = new QueryForm();
		}

		Map<String, Object> map = Maps.newHashMap();

		if (StringUtils.isNotBlank(form.getStartDt())) {
			map.put("startDt", DateUtils.parseDate(form.getStartDt(),
					DateUtils.PART_TIME_PATTERN));
		}
		if (StringUtils.isNotBlank(form.getEndDt())) {
			map.put("endDt", DateUtils.addDay(DateUtils.parseDate(
					form.getEndDt(), DateUtils.PART_TIME_PATTERN), 1));
		}
		if (StringUtils.isNotBlank(form.getTitle())) {
			map.put("title", form.getTitle());
		}

		int pageNo = (form.getCurrentPageNo() == 0 ? 1 : form
				.getCurrentPageNo());

		Page<BrandShow> brandShowPage = brandShowService
				.queryMyBrandShowByPage(LoginUtils.getLoginInfo(request)
						.getSellerId(), map, pageNo);

		request.setAttribute("brandShowPage", brandShowPage);
		request.setAttribute("cond", form);

		return "/brandShow/list";
	}

	@RequestMapping("/brandShow/showView")
	public String brandShowView(HttpServletRequest request,
			@RequestParam("brandShowId") Integer brandShowId) {

		return "/brandShow/showView";
	}

	@RequestMapping("/brandShow/detailView")
	public String brandShowDetailView(HttpServletRequest request,
			@RequestParam("brandShowId") Integer brandShowId) {
		BrandShow brandShow = brandShowService.getBrandShowById(brandShowId);
		request.setAttribute("brandShow", brandShow);

		request.setAttribute("brand",
				brandService.getByBrandId(brandShow.getBrandId().longValue()));

		List<BrandShowDetail> brandShowDetailList = brandShowService
				.getDetailsOfBrandShow(brandShow.getBrandShowId());

		request.setAttribute("brandShowDetailList", brandShowDetailList);

		return "/brandShow/detailView";
	}

	public static class DetailForm implements Serializable {
		/**
		 * 
		 */
		private static final long serialVersionUID = 4560796156033093338L;
		private Integer brandShowId;
		private BigDecimal[] showPrice;
		private Integer[] showBalance;
		private BigDecimal[] discount;
		private Integer[] bSDId;
		private Integer[] prodId;
		private String[] prodCode;
		private String[] skuCode;
		private Integer[] skuId;
		private String[] prodName;
		private String[] prodTitle;
		private String[] prodImg;
		private String[] skuSpecName;
		private BigDecimal[] orgPrice;
		private String[] artNo;

		public Integer getBrandShowId() {
			return brandShowId;
		}

		public String[] getArtNo() {
			return artNo;
		}

		public void setArtNo(String[] artNo) {
			this.artNo = artNo;
		}

		public void setBrandShowId(Integer brandShowId) {
			this.brandShowId = brandShowId;
		}

		public BigDecimal[] getShowPrice() {
			return showPrice;
		}

		public void setShowPrice(BigDecimal[] showPrice) {
			this.showPrice = showPrice;
		}

		public Integer[] getShowBalance() {
			return showBalance;
		}

		public void setShowBalance(Integer[] showBalance) {
			this.showBalance = showBalance;
		}

		public Integer[] getbSDId() {
			return bSDId;
		}

		public void setbSDId(Integer[] bSDId) {
			this.bSDId = bSDId;
		}

		public Integer[] getProdId() {
			return prodId;
		}

		public void setProdId(Integer[] prodId) {
			this.prodId = prodId;
		}

		public String[] getProdCode() {
			return prodCode;
		}

		public void setProdCode(String[] prodCode) {
			this.prodCode = prodCode;
		}

		public String[] getSkuCode() {
			return skuCode;
		}

		public void setSkuCode(String[] skuCode) {
			this.skuCode = skuCode;
		}

		public Integer[] getSkuId() {
			return skuId;
		}

		public void setSkuId(Integer[] skuId) {
			this.skuId = skuId;
		}

		public String[] getProdName() {
			return prodName;
		}

		public void setProdName(String[] prodName) {
			this.prodName = prodName;
		}

		public String[] getProdTitle() {
			return prodTitle;
		}

		public void setProdTitle(String[] prodTitle) {
			this.prodTitle = prodTitle;
		}

		public String[] getProdImg() {
			return prodImg;
		}

		public void setProdImg(String[] prodImg) {
			this.prodImg = prodImg;
		}

		public String[] getSkuSpecName() {
			return skuSpecName;
		}

		public void setSkuSpecName(String[] skuSpecName) {
			this.skuSpecName = skuSpecName;
		}

		public BigDecimal[] getOrgPrice() {
			return orgPrice;
		}

		public void setOrgPrice(BigDecimal[] orgPrice) {
			this.orgPrice = orgPrice;
		}

		public BigDecimal[] getDiscount() {
			return discount;
		}

		public void setDiscount(BigDecimal[] discount) {
			this.discount = discount;
		}

	}

	public static final class QueryForm implements Serializable {

		/**
		 * 
		 */
		private static final long serialVersionUID = -8651036937608261955L;

		private String startDt;
		private String endDt;
		private String title;
		private int currentPageNo;

		public String getStartDt() {
			return startDt;
		}

		public void setStartDt(String startDt) {
			this.startDt = startDt;
		}

		public String getEndDt() {
			return endDt;
		}

		public void setEndDt(String endDt) {
			this.endDt = endDt;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public int getCurrentPageNo() {
			return currentPageNo;
		}

		public void setCurrentPageNo(int currentPageNo) {
			this.currentPageNo = currentPageNo;
		}

	}
}
