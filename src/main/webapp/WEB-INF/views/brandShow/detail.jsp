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
<script type="text/javascript" src="${jsUrl}/brandDetail.js?t=20150604"></script>
<script type="text/javascript">
		var ctx = '${ctx}';
		var brandId = ${brandShow.brandId};
		var imgGetUrl = '${my:random(imgGetUrl)}';
</script>

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
<form class="form form-special" action="submitBrandShow" method="post" id="frm">
<!-- specialmain -->
<div class="specialmain">
	<div class="hd">
		<div class="hd-left">
			<h2><c:out value="${brandShow.title}"/> </h2>
			<span><c:choose>
					<c:when test="${brandShow.status == '1'}">进行中</c:when>
					<c:when test="${brandShow.status == '2'}">结束</c:when>
					<c:when test="${brandShow.status == '3'}">异常终止</c:when>
					<c:when test="${brandShow.status == '4'}">编辑中</c:when>
					<c:when test="${brandShow.status == '5'}">待审核</c:when>
					<c:when test="${brandShow.status == '6'}">审核中</c:when>
					<c:when test="${brandShow.status == '7'}">等待上线</c:when>
					<c:when test="${brandShow.status == '8'}">驳回
					</c:when>				
					</c:choose></span>
			<p><span class="note">专场ID：<c:out value="${brandShow.brandShowId}"/></span><a href="show?brandShowId=${brandShow.brandShowId}&m=3001"><i class="icon i-write"></i>修改专场信息</a></p>
		</div>
		<div class="hd-right">
			<button class="btn btn-def lg" id="btnAddProduct" type="button"><b>+</b>&nbsp;&nbsp;添加商品</button>
			<button class="btn btn-primary lg" type="submit"><i class="icon i-upload"></i>提交审核</button>
		</div>
	</div>
	<div class="bd">
		<img src="${my:random(imgGetUrl)}?rid=${brandShow.showBannerImg}&op=s2_w1022_h320" alt="">
	</div>
</div>
<!-- specialmain end  -->
<!-- specialList -->
<div class="specialList" id="specialList">
	<c:forEach items="${brandShowDetailList}" var="brandShowDetail" varStatus="status">
		<c:if test="${!status.first && (brandShowDetail.prodId != lastBrandShowDetail.prodId)}">					
			</tbody>
		</table>						
		</c:if>
	
		<c:if test="${brandShowDetail.prodId != lastBrandShowDetail.prodId}">		
		<table class="table table-line table-product">
				<colgroup>
					<col width="60">
					<col width="160">
					<col width="140">
					<col width="153">
					<col width="150">
					<col width="150">
					<col width="180">
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
						<td>操作</td>
					</tr>
				</thead>
				<tbody class="interleave-even">
			</c:if>
					<tr>
						<td><img src="${my:random(imgGetUrl)}?rid=${brandShowDetail.prodImg}&op=s2_w50_h50" alt=""></td>
						<td><p><c:out value="${fn:replace(fn:replace(brandShowDetail.skuSpecName, ':::', ' : '), '|||', '</p><p>')}" escapeXml="false"/></p></td>
						<td>￥<c:out value="${brandShowDetail.orgPrice}"/></td>
						<td>
							<input type="text" class="txt sm w-sm" placeholder="10" maxlength="3" name="discount" value="${brandShowDetail.discount}">
							折
						</td>
						<td><input type="text" class="txt sm w-sm" placeholder="10" maxlength="11" name="showPrice" value="${brandShowDetail.showPrice}" marketPrice="${brandShowDetail.orgPrice}"></td>
						<td><input type="text" class="txt sm w-sm" placeholder="10" maxlength="6" name="showBalance" value="${brandShowDetail.showBalance}">
							<input type="hidden" name="prodId" value="${brandShowDetail.prodId}">
							<input type="hidden" name="skuId" value="${brandShowDetail.skuId}">
							<input type="hidden" name="bSDId" value="${brandShowDetail.bSDId}">
							<input type="hidden" name="prodCode" value="${brandShowDetail.prodCode}">
							<input type="hidden" name="skuCode" value="${brandShowDetail.skuCode}">
							<input type="hidden" name="prodName" value="${brandShowDetail.prodName}">
							<input type="hidden" name="prodTitle" value="${brandShowDetail.prodTitle}">
							<input type="hidden" name="prodImg" value="${brandShowDetail.prodImg}">
							<input type="hidden" name="skuSpecName" value="${brandShowDetail.skuSpecName}">
							<input type="hidden" name="orgPrice" value="${brandShowDetail.orgPrice}">
							<input type="hidden" name="artNo" value="${brandShowDetail.artNo}">
						</td>
						<c:if test="${brandShowDetail.prodId != lastBrandShowDetail.prodId}">	
						<td class="td-operate" rowspan="${fn:length(brandShowDetailList)}">					
							<p><a href="#" class="btn btn-def lg">移除商品</a></p>
						</td>
						</c:if>
					</tr>	
			<c:if test="${status.last}">					
				</tbody>
			</table>						
			</c:if>
		<c:set var="lastBrandShowDetail" value="${brandShowDetail}"></c:set>
	</c:forEach>

	<div class="paging" id="paging">
		<div class="pagingBtn">			
			<button class="btn btn-primary lg" type="submit">提交审核</button>
			<a href="javascript:self.location.href='list?m=3001';" class="btn btn-def lg">取 消</a>
			<input type="hidden" name="brandShowId" value="${brandShow.brandShowId}">
		</div>
		
	</div>
</div>
<!-- specialList end-->
</form>

<!-- popup -->
<div class="popup popup-primary" style="width:600px;margin-left:-300px; margin-top:-65px; display: none" id="popupTip">
	<div class="hd"><h2></h2><i class="close"></i></div>
	<div class="bd">
		<dl class="popup-doc">
			<dt>
				
			</dt>
			<dd>
				<h3>对不起，请添加商品并完整填写数据后再提交！</h3>
			</dd>
		</dl>
	</div>
</div>

<div class="popup popup-primary popup-specialProduct" style="width:900px;margin-left:-450px; margin-top:-193px; display: none" id="popupProduct">
	<div class="hd"><h2>选择专场商品</h2><i class="close"></i></div>
	<div class="bd">
		<table class="table table-line">
			<thead>
				<tr>
					<th width="105">图片</th>
					<th width="70">商品编码</th>
					<th width="220">名称</th>
					<th width="100">品牌</th>
					<th width="160">类目</th>
					<th width="110">特卖价格</th>
					<th width="118">操作</th>
				</tr>
			</thead>
		</table>
		<div class="table-wrap">
			<table class="table table-line" id="tblProduct">
				<colgroup>
					<col width="35" />
					<col width="70" />
					<col width="70" />
					<col width="220" />
					<col width="100" />
					<col width="160" />
					<col width="110" />
					<col width="118" />
				</colgroup>
				<tbody>
					
				</tbody>
			</table>
		</div>
		<div class="btnWrap">
			<input type="checkbox" class="chk" id="chkBatch" /><a href="javascript:;" class="btn btn-primary" id="btnBatch">批量添加</a>
		</div>
	</div>
</div>
<div class="mask" style="display:none" id="popupMask"></div> 
<!-- popup end -->

</body>
</html>