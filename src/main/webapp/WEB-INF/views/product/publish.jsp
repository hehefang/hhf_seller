<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>卖家|发布商品</title>
</head>
<body>
	<link rel="stylesheet" href="${cssUrl}/css/product.css" />
	<div class="wrapper product">
		<!-- container -->
		<div id="container">
			<!-- main -->
			<div id="main">
				<!-- mainCaption -->
				<div class="mainCaption">
					<c:choose>
						<c:when test="${!empty(p) }">
							<h2>修改商品</h2>
						</c:when>
						<c:otherwise>
							<h2>发布新商品</h2>
						</c:otherwise>
					</c:choose>
				</div>
				<!-- mainCaption end -->
				<!-- issueProduct -->
				<div class="issueProduct">
					<form class="form" id="publishForm">
						<fieldset>
							<div class="legend">填写商品信息</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>商品类目：</label></div>
								<div class="item-cont">
									<span class="categoryTxt">${pathName }</span><input type="button" class="btn btn-def" onclick="publish.modifyBc('${pathId}')" value="修改" />
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>商品标题：</label></div>
								<div class="item-cont"><input type="text" class="txt lg w-xl" id="title" name="title" onblur="publish.validateTitle();" value="<c:out value="${p.title}"/>" ><span class="note" id='title_warn'>还可输入<b>30</b>个字!</span></div>
								<div class="note errTxt"></div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>商品卖点：</label></div>
								<div class="item-cont"><input type="text" class="txt lg w-xl" id="subtitle" onblur="publish.validateSubtitle();"  name="subtitle"  value="<c:out value="${p.subtitle}"/>"  maxlength="100"></div>
								<div class="note errTxt"></div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>货号：</label></div>
								<div class="item-cont"><input type="text" class="txt lg w-lg" id="artNo" name="artNo" value="<c:out value="${p.artNo}"/>"  onblur="publish.validateArtNo();" ><span class="note">12-16位数字/字母</span></div>
								<div class="note errTxt"></div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>品牌：</label></div>
								<div class="item-cont">
									<select id="brand" name="brand" onchange="publish.validateBrand();" class="select">
									
										<option value="-1">请选择品牌</option>
										<c:if test="${!empty(brand)}">
										<c:forEach items="${brand}" var="b">
											<option value="<c:out value='${b.brandId}'/>" id="brand${b.brandId}" ><c:out value="${b.brandName }"></c:out> </option>
										</c:forEach>
										</c:if>
									</select>
								</div>
								<div class="note errTxt"></div>
							</div>
							
							<c:if test="${!empty(bc.attrList)}">
								<c:forEach items="${bc.attrList}" var="attr">
									<div class="form-item">
										<div class="item-label">
											<c:choose>
												<c:when test="${attr.isRequire}">
													<label><em>*</em>${attr.attrName}：</label>
												</c:when>
												<c:otherwise>
													<label>${attr.attrName}：</label>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="item-cont">
											<div class="mod-attrChk" id="attrValAnc${attr.attrId}">
												<c:choose>
													<c:when test="${attr.displayMode == 1 }">
														<select name="attrValue" attrId="${attr.attrId}" class="select" onchange="publish.valaidateAttr('${attr.attrId}');">
															<option value=""></option>
															<c:forEach items="${attr.attrValueList }" var="attrValue" >
																<option value="${attrValue.attrValueId }|||${attrValue.attrValue }" attrValueId="${attrValue.attrValueId}"><c:out value='${attrValue.attrValue }'/></option>
															</c:forEach>
														</select>
													</c:when>
													<c:otherwise>
														<ul>
														<c:forEach items="${attr.attrValueList }" var="attrValue">
															<li><label><input type="checkbox" onchange="publish.valaidateAttr('${attr.attrId}');" class="chk" name="attrValue" attrId="${attr.attrId}" attrValueId="${attrValue.attrValueId}"  attrValueName="${attrValue.attrValue}"><c:out value='${attrValue.attrValue }'/></label></li>
														</c:forEach>
														</ul>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
										<input type="hidden" name="attr" attrId="${attr.attrId}" attrName="${attr.attrName}" displayMode="${attr.displayMode}" require="${attr.isRequire ? 'true' : 'false'}"/>
										<div class="note errTxt" id="attrValueErr${attr.attrId}"></div>
									</div>
								</c:forEach>
							</c:if>	
							
							<c:if test="${!empty(bc.specList)}">
								<c:forEach items="${bc.specList}" var="spec" varStatus="var">
									<div class="form-item item-color">
										<div class="item-label"><label><em>*</em>${spec.specName }：</label></div>
										<div class="item-cont">
											<div class="mod-attrChk">
												<ul var="${var.count }" specId="${spec.specId}" specName="${spec.specName}" id="specValAnc${spec.specId}">
													<c:forEach items="${spec.specValueList }" var="specValue">
													<li>
														<input type="checkbox" class="chk" name="specValue" skuSpecName="${spec.specName}" skuSpecId="${spec.specId}" specValueId="${specValue.specValueId}" specOrder="${spec.displayOrder}" onchange="publish.generateSku(this);publish.validateSpec(this);">
														<c:if test="${!empty(specValue.imgUrl)}">
															<img  name="colorIcon" colorName="${specValue.specValueName }"  src="${specValue.imgUrl }" alt="" class="colorBlock">
														</c:if>
														<label name="specValueTxt" >${specValue.specValueName }</label>
														<input type="text" class="txt" value="<c:out value='${specValue.specValueName}'/>">
													</li>
													</c:forEach>
												</ul>
											</div>
										</div>
										<div class="note errTxt" id="spacErr${spec.specId}"></div>
									</div>
								</c:forEach>
							</c:if>
							
							<div class="form-item sku-attr">
								<div class="item-label" style="display: none;"><label><em>*</em>SKU销售属性：</label></div>
 								<div class="item-cont" id="genSpec">
								</div> 
							</div>
					 	 	<div class="form-item" id="skuImgDiv" style="display: none;" >
								<div class="item-label"><label><em>*</em>SKU图片：</label></div>
								<div class="item-cont">
									<div class="uploadSKUImg">
										<div class="wrap">
											<span class="note warnColor">请使用白底图片，禁止出现拼接、水印、促销等信息；尺寸 800*800 px及以上，文件最大为500K</span>
											<ul id="skuImg">
											</ul>
										</div>
										<div class="note errTxt" id="errSkuImg"></div>
									</div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>商品描述：</label></div>
								<div class="item-cont">
									<div class="editer">
										<textarea id="detail" name="detail" style="width: 800px; height: 400px;"><c:out value="${p.detail}"/></textarea>
									</div>
								</div>
								<span class="note" id='detail_warn' style="padding-left: 110px;">还可输入<b>30</b>个字!</span>
							</div>
							<div class="form-item">
								<div class="item-label"></div>
								<div class="item-cont">
									<c:choose>
										<c:when test="${!empty(p) }">
											<input type="button" value="修 改" onclick="publish.saveProduct();" class="btn btn-primary lg p-lg">
										</c:when>
										<c:otherwise>
											<input type="button" value="发 布" onclick="publish.saveProduct();" class="btn btn-primary lg p-lg">
										</c:otherwise>
									</c:choose>
<!-- 									<input type="button" value="预 览" class="btn btn-bezelFree">
 -->								</div>
							</div>
						</fieldset>
						<input type="hidden" id="bcId" name="bcId" value="${bc.bcId }">
						<input type="hidden" id="bcCode" name="bcCode" value="${bc.bcCode }">
						<input type="hidden" id="brandId" name="brandId" value="">
						<input type="hidden" id="brandName" name="brandName" value="">
						<input type="hidden" id="prodId" name="prodId" value="${p.prodId }" />
						<input type="hidden" id="imgUrl" name="imgUrl" value="${p.imgUrl }" />
						<input type="hidden" id="auditStatus" name="auditStatus" value="${p.auditStatus }">
						<input type="hidden" id="attrValueId" name="attrValueId" value=""/>
						<input type="hidden" id="attrValueName" name="attrValueName" value="" />
					</form>
				</div>
				<!-- issueProduct end  -->
			</div>
			<!-- main end -->
		</div>
		<!-- container end -->
	</div>
	<div class="popup popup-primary" style="width:500px;margin-left:-250px;display:none" id="popProduct">
		<div class="hd"><h2></h2><i class="close" onclick="javascript:$('#popProduct, #maskProduct').hide();"></i></div>
		<div class="bd">
			<dl class="popup-doc">
				<dt>
					<i class="icon i-right"></i>
				</dt>
				<dd>
					<h3>商品已发布  ！</h3>
					<p>您可在<b>“在售商品管理”</b>中查看、修改商品</p>
					<div class="btnWrap"><a href="${ctx}/product/category?m=2002" class="btn btn-primary">继续发布商品</a><a href="${ctx}/product/online?m=2002" class="btn btn-def">查看在售商品</a></div>
				</dd>
			</dl>
		</div>
	</div>
	<div class="mask"  id="maskProduct" style="display:none"></div>	
	<script type="text/javascript">
		var ctx = '${ctx}';
		var cssUrl = '${cssUrl}';
		var imgUploadUrl = '${imgUploadUrl}';
		var imgGetUrl = '${my:random(imgGetUrl)}';
		var attrValueId= '${p.attrValueId}';
		var brandId = '${p.brandId}';
		
		var skuSpecIdArr = [], skuSpecNameArr = [], skuSortRankArr = [], s_marketPrice = [],s_salePrice = [], s_stockBalance = [],s_sellerNo = [], s_imgUrl = [];
		<c:forEach items="${p.skus}" var="sku" varStatus="status">
			skuSpecIdArr['${status.index}'] = '${sku.skuSpecId}';
			skuSpecNameArr['${status.index}'] = '${sku.skuSpecName}';
			skuSortRankArr['${status.index}'] = '${sku.sortRank}';
			s_marketPrice['${status.index}'] = '${sku.marketPrice}';
			s_salePrice['${status.index}'] = '${sku.salePrice}';
			s_stockBalance['${status.index}'] = '${sku.stockBalance}';
			s_sellerNo['${status.index}'] = '${sku.sellerNo}';
			s_imgUrl['${status.index}'] = '${sku.skuImgUrl}';
		</c:forEach>

	</script>
	<script type="text/javascript" src="${jsUrl}/popWindown.js?t=20150210"></script>	
	<script type="text/javascript" src="${jsUrl}/publish.js?t=20150604"></script>
</body>
</html>