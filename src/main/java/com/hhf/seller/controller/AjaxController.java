package com.hhf.seller.controller;

import java.util.List;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhf.common.util.CapthaUtils;
import com.hhf.model.product.Brand;
import com.hhf.model.product.Product;
import com.hhf.model.user.Geo;
import com.hhf.service.product.IBrandService;
import com.hhf.service.product.ICategoryService;
import com.hhf.service.product.IProductService;
import com.hhf.service.product.ISellerBrandService;
import com.hhf.service.seller.ISellerLoginService;
import com.hhf.service.sms.ISmsService;
import com.hhf.service.user.IGeoService;

@Controller
@RequestMapping("/ajax")
public class AjaxController {
	private static final Logger logger = LoggerFactory
			.getLogger(AjaxController.class);

	private static final String SELLER_REGISTER_VALIDATOR_PREFIX = "hhf_seller_register_validator_"; // 卖家注册验证码前缀
	public static final String SELLER_FORGOT_PASSWORD_VALIDATOR_PREFIX = "hhf_seller_forgot_password_validator_"; // 卖家忘记密码验证码前缀

	@Autowired
	private ISellerLoginService loginService;

	@Autowired
	private ISmsService smsService;

	@Autowired
	IBrandService brandService;

	@Autowired
	ISellerBrandService sellerBrandService;

	@Autowired
	RedisTemplate<String, String> redisTemplate;

	@Autowired
	IGeoService geoService;

	@Autowired
	IProductService productService;

	@Autowired
	ICategoryService categoryService;

	/**
	 * 验证卖家账号是否已被使用
	 * 
	 * @param loginName
	 * @return
	 */
	@RequestMapping("/existLoginName")
	@ResponseBody
	public Boolean existLoginName(@RequestParam("loginName") String loginName) {
		Boolean b = null;

		try {
			b = loginService.existLoginName(loginName);

		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}

		return b;
	}

	/**
	 * 验证卖家昵称是否已被使用
	 * 
	 * @param nickname
	 * @return
	 */
	@RequestMapping("/existNickname")
	@ResponseBody
	public Boolean existNickname(@RequestParam("nickname") String nickname) {
		Boolean b = null;
		try {
			b = loginService.existLoginName(nickname);

		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}

		return b;
	}

	/**
	 * 发送卖家注册验证码
	 * 
	 * @param mobile
	 * @return
	 */
	@RequestMapping("/register/sendValidator")
	@ResponseBody
	public Boolean registerSendValidator(@RequestParam("mobile") String mobile) {
		Boolean b = null;

		// 获取一个6位数字验证码
		String validator = CapthaUtils.getNumber(6);

		int ret = smsService.sendSms(mobile, "尊敬的客户，您的注册动态验证码为：" + validator
				+ "，请在5分钟内完成注册！");

		if (ret == 0) {
			// 将验证码放入缓存，有效期5分钟
			redisTemplate.opsForValue().set(
					SELLER_REGISTER_VALIDATOR_PREFIX + mobile, validator, 300,
					TimeUnit.SECONDS);

			b = true;
		}

		return b;
	}

	/**
	 * 验证卖家注册验证码
	 * 
	 * @param mobile
	 * @param validator
	 * @return
	 */
	@RequestMapping("/register/checkValidator")
	@ResponseBody
	public Boolean registerCheckValidator(
			@RequestParam("mobile") String mobile,
			@RequestParam("validator") String validator) {

		String cachedValidator = (String) redisTemplate.opsForValue().get(
				SELLER_REGISTER_VALIDATOR_PREFIX + mobile);

		return validator.equals(cachedValidator);
	}

	/**
	 * 发送卖家忘记密码验证码
	 * 
	 * @param mobile
	 * @return
	 */
	@RequestMapping("/forgetPassword/sendValidator")
	@ResponseBody
	public Boolean forgetPasswordSendValidator(
			@RequestParam("mobile") String mobile) {
		Boolean b = null;

		// 获取一个6位数字验证码
		String validator = CapthaUtils.getNumber(6);

		int ret = smsService.sendSms(mobile, "尊敬的客户，您的找回密码动态验证码为：" + validator
				+ "，请在5分钟内完成操作！");

		if (ret == 0) {
			b = true;
			// 将验证码放入缓存，有效期5分钟
			redisTemplate.opsForValue().set(
					SELLER_FORGOT_PASSWORD_VALIDATOR_PREFIX + mobile,
					validator, 300, TimeUnit.SECONDS);
		}

		return b;
	}

	/**
	 * 验证卖家忘记密码验证码
	 * 
	 * @param mobile
	 * @param validator
	 * @return
	 */
	@RequestMapping("/forgetPassword/checkValidator")
	@ResponseBody
	public Boolean forgetPasswordCheckValidator(
			@RequestParam("mobile") String mobile,
			@RequestParam("validator") String validator) {

		String cachedValidator = (String) redisTemplate.opsForValue().get(
				SELLER_FORGOT_PASSWORD_VALIDATOR_PREFIX + mobile);

		return validator.equals(cachedValidator);
	}

	@RequestMapping("/queryBrand")
	@ResponseBody
	public List<Brand> queryBrand(@RequestParam("keyword") String keyword) {
		return brandService.getBrandsByName(keyword);
	}

	@RequestMapping("/matchBrand")
	@ResponseBody
	public Brand matchBrand(@RequestParam("keyword") String keyword) {
		return brandService.getBrandByName(keyword);
	}

	@RequestMapping("/existBrand")
	@ResponseBody
	public boolean existBrand(@RequestParam("sellerId") int sellerId,
			@RequestParam("brandId") int brandId) {

		return sellerBrandService.existSellerBrand(sellerId, brandId);
	}

	@RequestMapping("/geoList")
	@ResponseBody
	public List<Geo> getGeoListByFid(@RequestParam("fId") long fid) {
		return geoService.getGeoByFId(fid);
	}

	@RequestMapping("/getOnlineProduct")
	@ResponseBody
	public List<Product> getOnlineProductBySellerIdAndBrandId(
			@RequestParam("sellerId") int sellerId,
			@RequestParam("brandId") int brandId) {

		List<Product> productList = productService
				.getOnlineProductBySellerIdAndBrandId(sellerId, brandId);

		for (Product product : productList) {
			product.setSkus(productService.getSkusByProdId(product.getProdId()));
			product.setBcName(categoryService.getByBcId(product.getBcId())
					.getBcName());
		}

		return productList;
	}
}
