<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>品牌特卖-禾合坊</title>
</head>
<body>

<link rel="stylesheet" href="${cssUrl}/css/product.css" />
<!-- mainCaption -->
<div class="mainCaption">
	<h2>我的商品</h2>
	<ul class="mod-step">
		<li class="past">
			<i class="disc">1</i>
			<span class="strip"></span>
			<p class="text">填写专场规则</p>
		</li>
		<li class="now">
			<i class="disc">2</i>
			<span class="strip"></span>
			<p class="text">专场商品设置</p>
		</li>
		<li class="last">
			<i class="disc"></i>
			<span class="strip"></span>
			<p class="text">等待审核</p>
		</li>
	</ul>
</div>
<!-- mainCaption end -->
<!-- specialmain -->
<div class="specialmain">
	<div class="hd">
		<div class="hd-left">
			<h2><a href=""><c:out value="${brandShow.title}"/></a></h2>
			<span>活动中</span>
			<p><span class="note">专场ID：<c:out value="${brandShow.brandShowId}"/></span><span class="note">当前状态不可操作</span></p>
		</div>
	</div>
	<div class="bd">
		<img src="${my:random(imgGetUrl)}?rid=${brandShow.showBannerImg}&op=s2_w1022_h320" alt="">
	</div>
</div>
<!-- specialmain end  -->
<!-- specialList -->
<div class="specialList">
	<c:forEach items="${brandShowDetailList}" var="brandShowDetail" varStatus="status">
		<c:if test="${!status.first && (brandShowDetail.prodId != lastBrandShowDetail.prodId)}">					
			</tbody>
		</table>						
		</c:if>
	
	<c:if test="${brandShowDetail.prodId != lastBrandShowDetail.prodId}">		
	<table class="table table-line table-product">
		<colgroup>
			<col width="100">
			<col width="180">
			<col width="180">
			<col width="193">
			<col width="170">
			<col width="170">
		</colgroup>
		<thead>
			<tr class="tr-head">
				<td colspan="7">
					<span>货号：<c:out value="${brandShowDetail.artNo}"/></span>
					<span><a href="#">商品名称：<c:out value="${brandShowDetail.prodName}"/></a></span>
					<span>品牌：<c:out value="${brand.brandName}"/></span>
				</td>
			</tr>
			<tr>
				<td>商品图片</td>
				<td>规格</td>
				<td>原价</td>
				<td>折扣</td>
				<td>特卖价</td>
				<td>库存</td>
			</tr>
		</thead>
		<tbody class="interleave-even">
		</c:if>	
			<tr>
				<td><img src="${my:random(imgGetUrl)}?rid=${brandShowDetail.prodImg}&op=s2_w50_h50" alt=""></td>
				<td><p><c:out value="${fn:replace(fn:replace(brandShowDetail.skuSpecName, ':::', ' : '), '|||', '</p><p>')}" escapeXml="false"/></p></td>
				<td>￥<c:out value="${brandShowDetail.orgPrice}"/></td>
				<td><p><span><c:out value="${brandShowDetail.discount}"/></span> 折</p></td>
				<td><p class="errTxt">￥<c:out value="${brandShowDetail.showPrice}"/></p></td>
				<td><p><span><c:out value="${brandShowDetail.showBalance}"/></span>/<span><c:out value="${brandShowDetail.showBalance - (empty(brandShowDetail.saleAmount) ? 0 : brandShowDetail.saleAmount)}"/></span></p></td>
			</tr>
		<c:if test="${status.last}">					
				</tbody>
			</table>						
		</c:if>
		
		<c:set var="lastBrandShowDetail" value="${brandShowDetail}"></c:set>
	</c:forEach>
	
<!-- specialList end-->



</body>
</html>