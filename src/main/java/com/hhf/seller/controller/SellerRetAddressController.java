/**
 * Copyright (c)2015-? by www.hhf.com. All rights reserved.
 * 
 */
package com.hhf.seller.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhf.constants.SystemConstants;
import com.hhf.model.seller.SellerRetAddress;
import com.hhf.seller.util.LoginUtils;
import com.hhf.service.seller.ISellerRetAddrService;

@Controller
@RequestMapping("/helper/")
public class SellerRetAddressController {
	@Autowired
	ISellerRetAddrService sellerRetAddressService;

	@RequestMapping("/saveRetAddr")
	@ResponseBody
	public int saveRetAddr(@ModelAttribute SellerRetAddress retAddress, HttpServletRequest request) {
		int re = 0;
		
		//卖家id
		retAddress.setSellerId(LoginUtils.getLoginInfo(request).getSellerId());
		
		//修改
		if(retAddress.getsRAId()!=null && retAddress.getsRAId()>0){
			re = this.sellerRetAddressService.updateSellerRetAddressById(retAddress);
		}else{//新增
			retAddress.setStatus(SystemConstants.DB_STATUS_VALID);
			re = this.sellerRetAddressService.insertSellerRetAddress(retAddress);
		}
				
		return re;
	}
	
	@RequestMapping("/getRetAddr")
	@ResponseBody
	public SellerRetAddress getRetAddr(@RequestParam(value = "sRAId") Integer sRAId) {
		return this.sellerRetAddressService.getAddrById(sRAId);
	}
	
	@RequestMapping("/retAddrlist")
	public String list(HttpServletRequest request) {
		//卖家id
		Integer sellerId = LoginUtils.getLoginInfo(request).getSellerId();
				
		List<SellerRetAddress> addrList = this.sellerRetAddressService.getValidAddrListOfSeller(sellerId);

		request.setAttribute("retAddrList", addrList);

		return "/retAddr/list";
	}
	
	@RequestMapping(value="/setDefalut", method=RequestMethod.POST)
	@ResponseBody
	public int setDefalut(@RequestParam(value = "sRAId") Integer sRAId, HttpServletRequest request){
		//卖家id
		Integer sellerId = LoginUtils.getLoginInfo(request).getSellerId();
				
		return this.sellerRetAddressService.setIsDefault(sRAId, sellerId);
	}
	
	/**
	 * @param sRAId 
	 * @param request
	 * @return 1:删除成功,0:失败,-1:不属性卖家地址
	 */
	@RequestMapping(value="/delRetAdress", method=RequestMethod.POST)
	@ResponseBody
	public int delRetAdress(@RequestParam(value = "sRAId") Integer sRAId, HttpServletRequest request){
		int re = 0;
		
		//卖家id
		Integer sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		SellerRetAddress adress = this.sellerRetAddressService.getAddrById(sRAId);		
		if(adress.getSellerId() == sellerId.intValue()){
			re = this.sellerRetAddressService.deleteSellerRetAddressById(sRAId);
		}else{
			re = -1;
		}
		
		return re;
	}
}
