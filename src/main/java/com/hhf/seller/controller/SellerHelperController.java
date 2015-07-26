package com.hhf.seller.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhf.model.seller.Seller;
import com.hhf.model.seller.SellerReceipt;
import com.hhf.seller.util.LoginUtils;
import com.hhf.service.seller.ISellerLoginService;
import com.hhf.service.seller.ISellerReceiptService;
import com.hhf.service.seller.ISellerService;

@Controller
public class SellerHelperController {
	
	@Autowired
	ISellerService sellerService;
	@Autowired
	ISellerLoginService sellerLoginService;
	@Autowired
	ISellerReceiptService sellerReceiptService;

	/**
	 *  基本信息
	 * @return
	 */
	@RequestMapping(value="helper/sellerInfo")
	public String toSellerInfo(HttpServletRequest request,ModelMap modelMap){
		int sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		
		Seller seller = sellerService.getSellerById(sellerId);
		if(null != seller){
			modelMap.put("s",seller);
		}
		return "sellerHelper/sellerInfo";
	}
	
	/**
	 *  保证金
	 * @return
	 */
	@RequestMapping(value="helper/deposit")
	public String toDeposit(HttpServletRequest request,ModelMap modelMap){
		int sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		
		Seller seller = sellerService.getSellerById(sellerId);
		if(null != seller){
			modelMap.put("s",seller);
		}
		return "sellerHelper/deposit";
	}
	
	/**
	 *  开票信息
	 * @return
	 */
	@RequestMapping(value="helper/receipt")
	public String toReceipt(HttpServletRequest request,ModelMap modelMap){
		int sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		
		SellerReceipt sellerReceipt = sellerReceiptService.getSellerReceiptBySellerId(sellerId);
		
		if(null != sellerReceipt){
			if(StringUtils.isNotEmpty(sellerReceipt.getRegisterTel())){
				sellerReceipt.setRegisterTel(sellerReceipt.getRegisterTel());
			}
			
			Seller seller = sellerService.getSellerById(sellerId);
			if(null != seller){
				sellerReceipt.setCoName(seller.getCoName());
			}
			
			modelMap.put("receipt",sellerReceipt);
		}
		
		return "sellerHelper/receipt";
	}
	
	/**
	 *  保存开票信息
	 * @return
	 */
	@RequestMapping(value="helper/saveReceipt")
	@ResponseBody
	public int toSaveReceipt(HttpServletRequest request,@ModelAttribute SellerReceipt sellerReceipt){
		int sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		sellerReceipt.setSellerId(sellerId);	
		
		String tel = sellerReceipt.getTelNo();
		
		if(StringUtils.isNotEmpty(sellerReceipt.getTelArea()) && sellerReceipt.getTelArea().trim().length()>0){
			tel = sellerReceipt.getTelArea() + "-" + tel;
		}
		if(StringUtils.isNotEmpty(sellerReceipt.getTelExt()) && sellerReceipt.getTelExt().trim().length()>0){
			tel += "-" + sellerReceipt.getTelExt().trim();
		}
		
		sellerReceipt.setRegisterTel(tel);
		return sellerReceiptService.updateSellerReceipt(sellerReceipt);
	}	
	
	/**
	 * 收款银行账户
	 * @return
	 */
	@RequestMapping(value="helper/payee")
	public String toPayeeAccount(HttpServletRequest request,ModelMap modelMap){
		int sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		
		Seller seller = sellerService.getSellerById(sellerId);
		if(null != seller){
			modelMap.put("s",seller);
		}
		return "sellerHelper/payeeAccount";
	}

	/**
	 *  ajax调用：保存收款银行账户
	 * @return
	 */
	@RequestMapping(value="helper/savePayee")
	@ResponseBody
	public int savePayeeAccount(HttpServletRequest request,@ModelAttribute Seller seller){
		int sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		seller.setSellerId(sellerId);
		return sellerService.updateSeller(seller);
	}

	/**
	 * 修改密码
	 * @return
	 */
	@RequestMapping(value="helper/setPasswd")
	public String toSetPwd(HttpServletRequest request,ModelMap modelMap){
		return "sellerHelper/passwd";
	}

	/**
	 *  ajax调用：修改密码
	 * @return 0:失败,1:成功,-1:原密码不正确,-2:新密码不一致,-3:密码不能为空
	 */
	@RequestMapping(value="helper/savePasswd", method=RequestMethod.POST)
	@ResponseBody
	public int savePasswd(HttpServletRequest request,
			@RequestParam(value = "oldPwd") String oldPwd, 
			@RequestParam(value = "newPwd") String newPwd, 
			@RequestParam(value = "repeatNewPwd") String repeatNewPwd
			){
		int re = 0;
		
		if(StringUtils.isNotEmpty(oldPwd) && StringUtils.isNotEmpty(newPwd) && StringUtils.isNotEmpty(repeatNewPwd)){
			if(newPwd.equals(repeatNewPwd)){
				int loginId = LoginUtils.getLoginInfo(request).getSellerLoginId();
				re = sellerLoginService.changePassword(loginId, newPwd, oldPwd);
			}else{
				re = -2;
			}
		}else{
			re = -3;
		}
		
		return re;
	}
	
	/**
	 *  结算
	 * @return
	 */
	@RequestMapping(value="helper/settleaccounts")
	public String settleaccounts(HttpServletRequest request,@ModelAttribute Seller seller){
		return "sellerHelper/settleaccounts";
	}
}
