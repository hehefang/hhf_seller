package com.hhf.seller.controller;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhf.common.mybatis.Page;
import com.hhf.common.util.DateUtils;
import com.hhf.common.util.PropertyUtils;
import com.hhf.constants.product.ProductConstants;
import com.hhf.constants.product.ProductConstants.SellerBrand$Status;
import com.hhf.model.product.BaseCategory;
import com.hhf.model.product.Brand;
import com.hhf.model.product.Product;
import com.hhf.model.product.Sku;
import com.hhf.model.product.vo.BaseCategoryInfoVO;
import com.hhf.model.product.vo.ProductConvertUtil;
import com.hhf.model.product.vo.ProductVo;
import com.hhf.param.product.ProductCondition;
import com.hhf.seller.util.LoginUtils;
import com.hhf.seller.util.LoginUtils.LoginInfo;
import com.hhf.seller.util.YWHttpCilient;
import com.hhf.service.product.ICategoryService;
import com.hhf.service.product.IProductService;
import com.hhf.service.product.ISellerBrandService;
import com.alibaba.fastjson.JSONObject;

/**
 * 
 *  商品管理控制器
 * @author hkM
 *
 */
@Controller
public class ProductController {
	private static final Logger logger = LoggerFactory
			.getLogger(LoginController.class);
	
	@Autowired
	IProductService productService;
	@Autowired
	ICategoryService categoryService;
	@Autowired
	ISellerBrandService sellerBrandService;
	
	/**
	 * 
	 * @return 选择类目页面
	 */
	@RequestMapping(value = "/product/category")
	public String toSelectCategory(@RequestParam(value = "pathId", defaultValue = "") String pathId,
			ModelMap modelMap) {
		if(StringUtils.isNotBlank(pathId)){
			modelMap.addAttribute("pathId", pathId);
		}
		return "/product/category";
	}
	
	/**
	 * Ajax调用 返回子BC列表
	 * 
	 * @param pId
	 * @return 
	 */
	@RequestMapping(value = "/product/loadBc")
	@ResponseBody
	public List<BaseCategory> loadBcCategory(@RequestParam(value = "pId", defaultValue="0") Integer pId){
		return categoryService.getBaseCategorysByPId(pId, SellerBrand$Status.VALID);
	}
	
	/**
	 *  
	 * @return 发布商品页面
	 */
	@RequestMapping(value = "/product/publish")
	public String toPublish(
			@RequestParam(value = "bcId", required = false) Integer bcId,
			@RequestParam(value = "prodId", required = false) Integer prodId,
			HttpServletRequest request,ModelMap modelMap) {
		
		int sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		
		if(prodId != null){
			Product product = this.productService.getProductById(prodId);
			bcId = product.getBcId();
			modelMap.put("p",product);
		}

		BaseCategoryInfoVO bc = this.categoryService.getBaseCategoryInfoByBcId(bcId);
		if(null != bc){
			//1. 已选商品品类
			String pathName = bc.getPathName();
			if(StringUtils.isNotBlank(pathName)){ 
				pathName = pathName.trim().replace("|", "<em>&gt;</em>");
				modelMap.put("pathName",pathName + "<em>&gt;</em>" + bc.getBcName());
				modelMap.put("pathId", bc.getPathId() + "|" + bcId);
			}
		}else{
			logger.error("ICategoryService#getBaseCategoryInfoByBcId  return null !");
		}
		//2. 品牌
		List<Brand> brandList = sellerBrandService.getValidBrandListOfSeller(sellerId);
		if(null != brandList && brandList.size() >0){
			modelMap.put("brand", brandList);
		}
		modelMap.put("bc", bc);
		return "/product/publish";
	}
	
	private void saveSku(ProductVo p,LoginInfo loginInfo) {
		BigDecimal[] skuSalePrice = p.getSkuSalePrice();
		BigDecimal[] skuMarketPrice = p.getSkuMarketPrice();
		Integer[] skuStockBalance = p.getSkuStockBalance();
		Integer[] sellerNo = p.getSellerNo();
		
		// 1. 判断sku 是否存在 【通过skuspecId 判断】
		List<Sku> skus = this.productService.getSkusByProdId(p.getProdId());
		String[] skuSpecIds = p.getSkuSpecId();
		if(null != skuSpecIds && skuSpecIds.length >0){
			// 删除
			for (Sku sku : skus) {
				if (!this.isSkuExists(sku, skuSpecIds)) {
					sku.setSkuStatus(ProductConstants.SKU_STATUS_DELETE);
					this.productService.editSkuById(sku, sku.getStockBalance());
				}
			}
			
			for (int i = 0; i < skuSpecIds.length; i++) {
				String skuSpecId = skuSpecIds[i];
				Sku sku = this.findExistsSku(skuSpecId, skus);
				if(sku != null){//修改
					sku.setSkuSpecId(skuSpecId);
					sku.setSkuSpecName(p.getSkuSpecName()[i]);
					if (null != p.getSkuImgUrl() && p.getSkuImgUrl().length > 0) {
						String skuImgUrl = p.getSkuImgUrl()[i];
						if (null != skuImgUrl && skuImgUrl.length() > 0) {
							sku.setSkuImgUrl(skuImgUrl);
							if(skuImgUrl.equals(p.getImgUrl())){ //TODO 待优化记录默认sku
								sku.setSortRank(0);
							}else{
								sku.setSortRank(99);
							}
						} 
					} 
					
					sku.setSellerNo(sellerNo[i]+"");
					sku.setStockBalance(skuStockBalance[i]);
					sku.setMarketPrice(skuMarketPrice[i]); // 市场价
					sku.setSalePrice(skuSalePrice[i]);
					sku.setLastUpdateDate(DateUtils.currentDate());
					sku.setUpdateByName(loginInfo.getLoginName());

					this.productService.editSkuById(sku, null);
				}else{//新增
					Sku sku1 = new Sku();
					sku1.setProdId(p.getProdId());
					sku1.setProdCode(p.getProdCode());
					sku1.setMarketPrice(skuMarketPrice[i]);
					sku1.setSalePrice(skuSalePrice[i]);
					sku1.setStockBalance(skuStockBalance[i]);
					sku1.setSellerNo(sellerNo[i]+"");
					
					if (null != p.getSkuImgUrl() && p.getSkuImgUrl().length > 0) {
						String skuImgUrl = p.getSkuImgUrl()[i];
						if (null !=skuImgUrl && skuImgUrl.length() > 0) {
							sku1.setSkuImgUrl(skuImgUrl);
							if(skuImgUrl.equals(p.getImgUrl())){ //TODO 待优化记录默认sku
								sku1.setSortRank(0);
							}else{
								sku1.setSortRank(99);
							}
						} 
					} 
					sku1.setSkuSpecId(p.getSkuSpecId()[i]);
					sku1.setSkuSpecName(p.getSkuSpecName()[i]);
					sku1.setSkuStatus(ProductConstants.SKU_STATUS_NORMAL); 
					sku1.setCreateDate(DateUtils.currentDate());
					sku1.setCreateByName(loginInfo.getLoginName());
					sku1.setLastUpdateDate(DateUtils.currentDate());
					sku1.setUpdateByName(loginInfo.getLoginName());
					this.productService.addSku(sku1);
				}
			}
		}
	}
	
	/**
	 * 
	 *  Ajax调用：保存商品
	 * @return 成功|失败 
	 */
	@ResponseBody
	@RequestMapping(value = "/product/save")
	public Map<String,String> doSaveProduct(HttpServletRequest request,
			@ModelAttribute ProductVo vo){
		HashMap<String, String> resultMap = new HashMap<String,String>();
		LoginInfo loginInfo = LoginUtils.getLoginInfo(request);
		vo.setSellerId(loginInfo.getSellerId());
		
		Product product = ProductConvertUtil.voToProduct(vo,null);
		
		Integer prodId = product.getProdId();
		if(null != prodId && prodId > 0 ){
			productService.editProductById(product);
			resultMap.put("success", "1");
		}else{
			prodId = productService.addProduct(product);
			vo.setProdId(prodId);
			resultMap.put("success", "0");
		}
		
		saveSku(vo,loginInfo);
		
		return resultMap;
	}
	
	/**
	 * Ajax调用：删除商品
	 * 
	 * @return
	 */
	@RequestMapping(value = "/product/delProd")
	@ResponseBody
	public Map<String, String> delProduct(
			@RequestParam(value = "prodId", required = true) Integer prodId,
			HttpServletRequest request) {
		String loginName = LoginUtils.getLoginInfo(request).getLoginName();
		boolean b = productService.delProduct(prodId,loginName);
		return resultMsg(b,"");
	}
	
	/**
	 * Ajax调用：批量删除商品
	 * 
	 * @return
	 */
	@RequestMapping(value = "/product/batchdelProd", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> batchdelProduct(
			@RequestParam(value = "ids", required = true) String ids,
			HttpServletRequest request) {
		String loginName = LoginUtils.getLoginInfo(request).getLoginName();
		List<Integer> idList = new ArrayList<Integer>();
		if (StringUtils.isNotBlank(ids)) {
			String[] prodIds = ids.split(",");
			for (String prodId : prodIds) {
				idList.add(Integer.parseInt(prodId));
			}
		}
		boolean b = productService.batchdelProduct(idList,loginName);
		return resultMsg(b,"");
	}
	
	/**
	 * 
	 * @return 在售商品列表
	 */
	@RequestMapping(value = "/product/online")
	public String toOnlineProductPage(
			@ModelAttribute ProductCondition productCondition,
			@RequestParam(value = "sortField", defaultValue = "") String sortField,
			@RequestParam(value = "sortDirection", defaultValue = "") String sortDirection,
			HttpServletRequest request, Page<Product> page, ModelMap modelMap
			) {
		page.setPageSize(15);
		int sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		productCondition.setSellerId(sellerId);
		List<Brand> brandList = sellerBrandService.getValidBrandListOfSeller(sellerId);
		if(null != brandList && brandList.size() >0){
			modelMap.put("brand", brandList);
		}
		page = productService.searchOnlineProductPage(productCondition, sortField, sortDirection, page);
		List<Product> list = page.getResult();
		for (Product p : list) {
			BaseCategory bc = this.categoryService.getByBcId(p.getBcId());
			if(null != bc){
				String displayBcName = bc.getPathName().trim().replace("|", "/");
				p.setBcName(displayBcName +"/"+ bc.getBcName());
			}else{
				logger.error("ICategoryService#getBaseCategoryInfoByBcId  return null !");
			}
		}
		
		modelMap.addAttribute("sortField", sortField);
		modelMap.addAttribute("productCondition", productCondition);
		modelMap.addAttribute("page", page);
		return "/product/online";
	}
	
	/**
	 * 
	 * @return 审核驳回商品列表
	 */
	@RequestMapping(value = "/product/audit")
	public String toWaitAuditProductPage(
			@ModelAttribute ProductCondition productCondition,
			HttpServletRequest request, Page<Product> page, ModelMap modelMap
			) {
		page.setPageSize(15);
		int sellerId = LoginUtils.getLoginInfo(request).getSellerId();
		productCondition.setSellerId(sellerId);
		List<Brand> brandList = sellerBrandService.getValidBrandListOfSeller(sellerId);
		if(null != brandList && brandList.size() >0){
			modelMap.put("brand", brandList);
		}
		page = productService.searchAuditProductPage(productCondition, null, null, page);
		List<Product> list = page.getResult();
		for (Product p : list) {
			BaseCategoryInfoVO bc = this.categoryService.getBaseCategoryInfoByBcId(p.getBcId());
			if(null !=bc){
				String displayBcName = bc.getPathName().trim().replace("|", "/");
				p.setBcName(displayBcName +"/"+ bc.getBcName());
			}else{
				logger.error("ICategoryService#getBaseCategoryInfoByBcId  return null !");
			}
		}
		modelMap.addAttribute("page", page);
		modelMap.addAttribute("productCondition", productCondition);
		return "/product/audit";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/image/saveImg")
	public void uploadProductImg(HttpServletRequest request,
			HttpServletResponse response) {
		String opt = request.getParameter("opt");
		// 定义允许上传的文件扩展名
		HashMap<String, String> extMap = new HashMap<String, String>();
		extMap.put("image", "gif,jpg,jpeg,png,bmp");

		// 最大文件大小
		long maxSize = 512000;
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();

			if (!ServletFileUpload.isMultipartContent(request)) {
				pw.println(errorMsg("请选择文件。"));
			}

			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setHeaderEncoding("UTF-8");
			List<FileItem> items = upload.parseRequest(request);
			Iterator<FileItem> itr = items.iterator();

			while (itr.hasNext()) {
				FileItem item = itr.next();
				String fileName = item.getName();
				long fileSize = item.getSize();
				List<String> urls = null;

				if (fileName != null) {
					if (fileSize > maxSize) {// 检查文件大小
						pw.print(errorMsg("上传文件大小超过限制。"));
						return;
					}

					String fileExt = fileName.substring(
							fileName.lastIndexOf(".") + 1).toLowerCase(); // 检查扩展名

					if (!Arrays.<String> asList(extMap.get("image").split(","))
							.contains(fileExt)) {
						pw.print(errorMsg("上传文件扩展名是不允许的扩展名。\n只允许"
								+ extMap.get("image") + "格式。"));
						return;
					}

					if (!item.isFormField() && fileName != null) {// 执行上传
						urls = YWHttpCilient.uploadFileService(
								item.getInputStream(), fileName, opt);
						StringBuilder fullUrl = new StringBuilder();

						for (String url : urls) {
							fullUrl.append(((String[])PropertyUtils.getProperty("imgGetUrl"))[0]+"?rid=" + url + ",");
						}

						pw.print(getRight(fullUrl.substring(0,
								fullUrl.length() - 1)));
					}
				}
			}
		} catch (Exception e) {
			logger.info("上传文件失败！", e);
			pw.println(errorMsg("上传文件失败。"));
			return;
		} finally {
			pw.close();
		}
	}
	
	// 判断是否存在sku
	private boolean isSkuExists(Sku sku, String[] skuSpecIds) {
		for (String skuSpecId : skuSpecIds) {
			if (sku.getSkuSpecId().equals(skuSpecId))
				return true;
		}

		return false;
	}
	
	// 查询已经存在的sku
	private Sku findExistsSku(String skuSpecId, List<Sku> skuList) {
		for (Sku sku : skuList) {
			if (skuSpecId.equals(sku.getSkuSpecId()))
				return sku;
		}

		return null;
	}
	
	private String errorMsg(String message) {
		JSONObject obj = new JSONObject();
		obj.put("error", 1);
		obj.put("message", message);
		return obj.toJSONString();
	}
	
	private String getRight(String message) {
		JSONObject obj = new JSONObject();
		obj.put("error", 0);
		obj.put("url", message);
		return obj.toJSONString();
	}
	
	private Map<String,String> resultMsg(boolean b,String message) {
		HashMap<String, String> resultMap = new HashMap<String,String>();
		if (b) {// 成功
			resultMap.put("success", "1");
			resultMap.put("msg", message);
		} else {// 失败
			resultMap.put("error", "0");
			resultMap.put("msg", message);
		}
		return resultMap;
	}
}
