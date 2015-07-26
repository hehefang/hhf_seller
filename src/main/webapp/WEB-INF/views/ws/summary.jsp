<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>概述-禾合坊</title>
</head>
<body>
<link rel="stylesheet" href="${cssUrl}/css/helper.css" />

<!-- mainCaption -->
<div class="mainCaption">
	<h2>概览</h2>
</div>
<!-- mainCaption end -->
<div id="deposit">
	<!-- overview -->
	<div class="overview">
		<!-- over-left -->
		<div class="over-left">
			<div class="overL-hd">
				<h4><c:out value="${seller.coName}"/></h4>
				<p>保证金：<span class="successColor" id="spanDeposit"><c:out value="${seller.isPaidDeposit == '1' ? '已缴纳' : '未缴纳'}"/></span></p>
				<ul>
					<li>开店时间：<span><fmt:formatDate value="${seller.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </span></li>
					<li>经营品牌：<span class="note"><c:out value="${fn:replace(seller.coBrand, ',', ' ')}"/></span></li>
					<li>商品库：<span><b>${productCount}</b>件</span></li>
				</ul>
			</div>
			<div class="overL-main">
				<div class="hd">
					<h4>店铺提醒</h4>
				</div>
				<div class="bd">
					<div class="remindMain">
						<h4>您需要尽快处理</h4>
						<ul>
							<li>交易管理：<a href="${ctx}/order/sendOrder?m=4002">待发货订单<span>（<em class="errTxt">${toBeProcessOrderCount}</em>）</span></a><a href="${ctx}/order/returnOrder?m=4003">待退货的订单<span>（<em class="errTxt">${toBeProcessRetOrderCount}</em>）</span></a></li>
						</ul>
					</div>
				</div>
				<div class="bd last">
					<div class="remindMain">
						<h4>品牌特卖专场</h4>
						<ul>
							<li>专场管理：<a href="${ctx}/brandShow/list?m=3001">审核中<span>（<em class="errTxt">${auditingBrandShowCount}</em>）</span></a><a href="${ctx}/brandShow/list?m=3001">驳回待修改的专场<span>（<em class="errTxt">${rejectedBrandShowCount}</em>）</span></a><a href="${ctx}/brandShow/list?m=3001">进行中的专场<span>（<em class="errTxt">${onlineBrandShowCount}</em>）</span></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- over-left -->
		<!-- over-right -->
		<div class="over-right">
			<div class="guide">
				<h4>新手指南</h4>
				<ul>
					<li>•<a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">商家操作指南手册</a></li>
					<li>•<a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">商家品控指导手册</a></li>
					<li>•<a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">商家违规处罚规则</a></li>
					<li>•<a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">商家合作协议</a></li>
					<li>•<a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">100%正品保证</a></li>
					<li>•<a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">专场包邮服务</a></li>
					<li>•<a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">48小时发货服务</a></li>
					<li>•<a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">7天无理由退货服务</a></li>
					<li>•<a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">发票服务</a></li>
				</ul>
			</div>
			<div class="sideImg">
				<a href="#">
					<img src="${cssUrl}/img/temp/rig.jpg" alt="">
				</a>
			</div>
			<div class="sideImg">
				<a href="#">
					<img src="${cssUrl}/img/temp/rig.jpg" alt="">
				</a>
			</div>
		</div>
		<!-- over-right end -->
	</div>
	<!-- overview end -->
</div>

</body>
</html>