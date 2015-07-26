package com.hhf.seller.controller;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhf.common.mybatis.Page;
import com.hhf.common.util.DateUtils;
import com.hhf.constants.order.OrderConstants;
import com.hhf.model.order.LogisticsCompany;
import com.hhf.model.order.Order;
import com.hhf.model.order.OrderItem;
import com.hhf.model.order.ReturnOrder;
import com.hhf.model.product.BrandShow;
import com.hhf.model.seller.SellerRetAddress;
import com.hhf.param.order.OrderCondition;
import com.hhf.seller.util.LoginUtils;
import com.hhf.service.order.IOrderService;
import com.hhf.service.order.IRetOrderService;
import com.hhf.service.product.IBrandShowService;
import com.hhf.service.seller.ISellerRetAddrService;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@InitBinder  
    protected void initBinder(HttpServletRequest request,  
        ServletRequestDataBinder binder) throws Exception {  
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");  
        CustomDateEditor editor = new CustomDateEditor(df, true);  
        binder.registerCustomEditor(Date.class, editor);  
    }
	
	@Autowired
	private IOrderService orderService;
	@Autowired
	private IRetOrderService retOrderService;
	@Autowired
	private IBrandShowService brandShowService;
	@Autowired
	private ISellerRetAddrService sellerRetAddressService;
	
	@RequestMapping(value="/queryOrder")
	public String queryOrder(@ModelAttribute OrderCondition orderCondition, HttpServletRequest request, Page<Order> page, ModelMap modelMap){
		page.setPageSize(10);
		
		//卖家id
		Integer sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		orderCondition.setSellerId(sellerId);
		
		page = this.orderService.getOrdersByOrderConditon(orderCondition, page);
		modelMap.addAttribute("page", page);
		
		List<BrandShow> brandShows = this.brandShowService.getOnlinedBrandShowsOfSeller(sellerId);
		modelMap.addAttribute("brandShows", brandShows);
		
		return "order/queryOrder";
	}
	
	@RequestMapping(value="/sendOrder")
	public String sendOrderList(@ModelAttribute OrderCondition orderCondition, HttpServletRequest request, Page<Order> page, ModelMap modelMap){
		page.setPageSize(10);
		//要发货的订单
		orderCondition.setOrderStatus(OrderConstants.ORDER_STATUS_WAITDELIVERED);
		
		//卖家id
		Integer sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		orderCondition.setSellerId(sellerId);
		
		page = this.orderService.getOrdersByOrderConditon(orderCondition, page);
		modelMap.addAttribute("page", page);
		
		List<BrandShow> brandShows = this.brandShowService.getOnlinedBrandShowsOfSeller(sellerId);
		modelMap.addAttribute("brandShows", brandShows);
		
		return "order/sendOrder";
	}
	
	@RequestMapping(value="/returnOrder")
	public String returnOrderList(@RequestParam(value = "brandShowId", required = false) Long brandShowId, 
			@RequestParam(value = "startDate", required = false) Date startDate, 
			@RequestParam(value = "endDate", required = false) Date endDate, 
			@RequestParam(value = "retOrderCode", required = false) String retOrderCode, 
			HttpServletRequest request, Page<ReturnOrder> page, ModelMap modelMap){
		page.setPageSize(10);
		
		Map<String , Object> cond = new HashMap<>();
		
		if(brandShowId!=null && brandShowId>0){
			cond.put("brandShowId", brandShowId);
			modelMap.put("brandShowId", brandShowId.longValue());
		}
		
		if(startDate != null){
			cond.put("startDate", startDate);
			modelMap.put("startDate", startDate);
		}
		
		if(endDate != null){
			String strEndDate = DateUtils.formatDate(endDate, "yyyy-MM-dd");
			strEndDate = strEndDate+" 23:59:59";
			endDate = DateUtils.parseDate(strEndDate);
			
			modelMap.put("endDate", endDate);
			cond.put("endDate", endDate);
		}
		
		if(StringUtils.isNotEmpty(retOrderCode)){
			cond.put("retOrderCode", retOrderCode);
		}
		
		//卖家id
		Integer sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		cond.put("sellerId", sellerId);
		
		page = this.retOrderService.getRetOrdersByPage(cond, page);
		modelMap.addAttribute("page", page);
		
		List<BrandShow> brandShows = this.brandShowService.getOnlinedBrandShowsOfSeller(sellerId);
		modelMap.addAttribute("brandShows", brandShows);
		
		return "order/returnOrder";
	}
	
	@RequestMapping(value="/retOrderDetail")
	public String retOrderDetail(@RequestParam Long retOrderId, HttpServletRequest request, ModelMap modelMap){
		
		if(retOrderId!=null && retOrderId>0){
			ReturnOrder retOrder = this.retOrderService.getRetOrderInfoByRetOrderId(retOrderId);
			modelMap.addAttribute("returnOrder", retOrder);
			
			if(retOrder != null){
				//退货地址
				BrandShow brandShow = this.brandShowService.getBrandShowById(retOrderId.intValue());
				if(brandShow!=null && brandShow.getsRAId()>0){
					SellerRetAddress retAddr = this.sellerRetAddressService.getAddrById(brandShow.getsRAId());
					modelMap.addAttribute("retAddr", retAddr);
				}
			}
		}
		
		return "order/retOrderDetail";
	}
	
	@RequestMapping(value="/modRetOrder", method=RequestMethod.POST)
	@ResponseBody
	public int modRetOrder(@RequestParam(value = "retOrderId") Long retOrderId, 
			@RequestParam(value = "status") String status, HttpServletRequest request){
		int re = 0;
		
		if(retOrderId!=null && retOrderId>0 && StringUtils.isNotEmpty(status)){
			ReturnOrder retOrder = new ReturnOrder();
			retOrder.setRetOrderId(retOrderId);		
			retOrder.setStatus(status);
			
			if(OrderConstants.order_return_audit.equals(retOrder.getStatus())){
				retOrder.setAuditDate(new Date());
				retOrder.setAuditByName(LoginUtils.getLoginInfo(request).getLoginName());
			}else if(OrderConstants.order_return_comfirm.equals(retOrder.getStatus())){
				retOrder.setConfirmDate(new Date());
			}
			
			re = this.retOrderService.updateRetOrderByIdSelective(retOrder);
		}
		
		return re;
	}
	
	@RequestMapping(value="/getLogiComs", method=RequestMethod.POST)
	@ResponseBody
	public List<LogisticsCompany> getLogiCompanys(@RequestParam(value = "showId") int brandShowId){
		return this.brandShowService.getLogisticsCompanyListOfBrandShow(brandShowId);
	}
	
	@RequestMapping(value="/send", method=RequestMethod.POST)
	@ResponseBody
	public int sendOrder(@RequestParam(value = "orId") Long orderId, 
			@RequestParam(value = "logiId") int logiId, 
			@RequestParam(value = "logiName") String logiName, 
			@RequestParam(value = "awbNo") String awbNo, HttpServletRequest request){
		
		Order order = new Order();
		order.setOrderId(orderId);
		order.setOrderStatus(OrderConstants.ORDER_STATUS_DELIVERED);
		order.setLogisticsCompa(logiId+0L);
		order.setLogisticsName(logiName);
		order.setAwbNo(awbNo);
		
		Date date = new Date();
		order.setSendTime(date);
		order.setLastUpdateDate(date);
		order.setLastUpdateByName(LoginUtils.getLoginInfo(request).getLoginName());
		
		return this.orderService.updateOrder2Sended(order);
	}
	
	@RequestMapping(value="/orderDetail")
	public String orderDetail(@RequestParam Long orderId, HttpServletRequest request, ModelMap modelMap){
		Order order = this.orderService.getOrderById(orderId);
		List<OrderItem> orderItems = null;
		
		if(order != null){
			orderItems = this.orderService.getOrderItemsByOrderId(order.getOrderId().intValue());
			if(orderItems != null){
				order.setOrderItems(orderItems);
			}
		}
		
		modelMap.addAttribute("order", order);
		
		return "order/orderDetail";
	}
	 
}
