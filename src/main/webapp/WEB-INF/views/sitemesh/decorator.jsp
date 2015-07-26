<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/common/common.jsp"%>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<link rel="stylesheet" type="text/css" href="${cssUrl}/css/allstyle.min.css"/>
<script type="text/javascript" src="${jsUrl}/g.js?t=20150126"></script>
<title><decorator:title default="卖家中心-禾合坊"/></title>
<script type="text/javascript">
function appendParam(href, menuId) {
	if(href.indexOf('?') == -1) {
		href = href + '?m=' + menuId;
		
	} else {		
		href = href + '&m=' + menuId; 
	}
	
	return href;
}

$(function(){
	var bigMenu = $('#bigMenu'), smallMenu = $('#smallMenu');
	
	bigMenu.find('li > a').click(function(e){
		e.preventDefault();
		
		var b = $(this).parent().attr('b');
		if(b == '30' || b == '40') {
			if($.seller.isPaidDeposit != '1') {
				showDeposit();
				
				return;
			}
		}
		
		var item = smallMenu.find('li[b="' + b + '"]');
		var m = $(item[0]).attr('m');
		var href = $(item[0]).find('a').attr('href');
		
		self.location.href = appendParam(href, m);
	});
	
	smallMenu.find('li > a').click(function(e){
		e.preventDefault();
		self.location.href = appendParam($(this).attr('href'), $(this).parent().attr('m'));
	});
});

$(function() {
	var m = '${param.m}';
	if(!m) return;
	
	var smallMenu = $('#smallMenu');
	var sItem = smallMenu.find('li[m="' + m + '"]');
	var b = sItem.attr('b');
	
	sItem.addClass('curr');
	
	$('#smallMenu').find('li[b="' + b + '"]').show();
	
	var bItem = $('#bigMenu').find('li[b="' + b + '"]');
	bItem.addClass('curr');
});

function showDeposit() {
	$('#depositPop, #depositMask').show();
}

function closeDeposit() {
	$('#depositPop, #depositMask').hide();
}
</script>
</head>
<body>
<div class="wrapper wrap-helper wrap-brand wrap-special product">
		<!-- header -->
		<div id="header">
			<div class="wrap wrap-brand">
				<!-- logo -->
				<div id="logo"  style="height: 50px;">
					<div class="logo"><a href="http://www.hehefang.com" title="logo"><img src="${cssUrl}/img/logo.png" alt="logo" /></a></div>
					<h1>商家中心</h1>
				</div>
				<!-- logo end -->
				<!-- site -->
				<div id="site">
					<ul class="item">
						<li>|</li>						
						<li>
							<div class="hd"><a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">帮助中心</a></div>
						</li>
					</ul>
				</div>
				<!-- site end -->
				<!-- signin -->
				<div id="signin">
					<p><span>您好,<c:out value="${loginInfo.nickName}"/></span><span><a href="${ctx}/logout" class="exit">退出</a></span></p>
				</div>
				<!-- signin end -->
			</div>
		</div>
		<!-- header end -->
		<!-- mainNav -->
		<div id="mainNav">
			<div class="wrap">
				<ul id="bigMenu">
					<li class="nav-01" b="10"><a href="#"><i class="icon"></i>商家助手</a></li>
					<li class="nav-02" b="20"><a href="#"><i class="icon"></i>商品管理</a></li>
					<li class="nav-03" b="30"><a href="#"><i class="icon"></i>品牌特卖</a></li>
					<li class="nav-04" b="40"><a href="#"><i class="icon"></i>交易管理</a></li>
					<li class="nav-05" b="50"><a href="#"><i class="icon"></i>专场结算</a></li>
				</ul>
			</div>
		</div>
		<!-- mainNav end -->
		<!-- container -->
		<div id="container">
			<div class="wrap">
				<!-- aside -->
				<div id="aside">
					<div id="asideNav">
						<ul id="smallMenu">
							<li b="10" m="1001" style="display: none" ><a href="${ctx}/ws/summary"><i class="icon"></i>概览</a></li>
							<li b="10" m="1002" style="display: none" ><a href="${ctx}/helper/deposit"><i class="icon"></i>保证金</a></li>
							<li b="10" m="1003" style="display: none" ><a href="${ctx}/helper/payee"><i class="icon"></i>收款银行账户</a></li>
							<li b="10" m="1004" style="display: none" ><a href="${ctx}/helper/receipt"><i class="icon"></i>开票信息</a></li>
							<li b="10" m="1005" style="display: none" ><a href="${ctx}/helper/sellerInfo"><i class="icon"></i>基本信息</a></li>
							<li b="10" m="1006" style="display: none" ><a href="${ctx}/helper/retAddrlist"><i class="icon"></i>退货地址</a></li>
							<li b="10" m="1007" style="display: none" ><a href="${ctx}/helper/setPasswd"><i class="icon"></i>修改密码</a></li>
							
							<li b="20" m="2001" style="display: none" ><a href="${ctx}/product/category"><i class="icon"></i>发布新商品</a></li>
							<li b="20" m="2002" style="display: none" ><a href="${ctx}/product/online"><i class="icon"></i>在售商品管理</a></li>
							<li b="20" m="2003" style="display: none" ><a href="${ctx}/product/audit"><i class="icon"></i>审核中商品</a></li>
							<li b="20" m="2004" style="display: none" ><a href="${ctx}/product/brand"><i class="icon"></i>品牌管理</a></li>
							
							<li b="30" m="3001" style="display: none" ><a href="${ctx}/brandShow/list"><i class="icon"></i>特卖专场列表</a></li>
							<li b="30" m="3002" style="display: none" ><a href="${ctx}/brandShow/show"><i class="icon"></i>新建品牌特卖</a></li>
							
							<li b="40" m="4001" style="display: none" ><a href="${ctx}/order/queryOrder"><i class="icon"></i>全部订单</a></li>
							<li b="40" m="4002" style="display: none" ><a href="${ctx}/order/sendOrder"><i class="icon"></i>订单发货</a></li>
							<li b="40" m="4003" style="display: none" ><a href="${ctx}/order/returnOrder"><i class="icon"></i>退货管理</a></li>
							
							<li b="50" m="5001" style="display: none" ><a href="${ctx}/helper/settleaccounts"><i class="icon"></i>专场结算</a></li>
						</ul>
					</div>
				</div>
				<!-- aside end -->
				<!-- main -->
				<div id="main" class="specialmaintain">
					<decorator:body/>
				</div>
				<!-- main end -->
			</div>			
			
		</div>
		<!-- container end -->
		<!-- footer -->
		<jsp:include page="/common/footer.jsp"/>
		<!-- footer end -->
	</div>
	
	<div class="popup popup-primary" style="width:620px;margin-left:-310px; margin-top:-101px; display: none" id="depositPop">
		<div class="hd"><h2></h2><i class="close" onclick="javascript:closeDeposit();"></i></div>
		<div class="bd">
			<dl class="popup-doc">
				<dt>
					<i class="icon i-danger"></i>
				</dt>
				<dd>
					<h3>公司保证金未缴纳 ！</h3>
					<p>您公司保证金审核未通过，因此暂时不能申请或管理“品牌专场”功能，请尽快完成缴费。</p>
					<div class="btnWrap"><a href="javascript:closeDeposit();" class="btn btn-primary">我知道了</a></div>
				</dd>
			</dl>
		</div>
	</div>
	<div class="mask" id="depositMask" style="display: none"></div>
	
</body>
</html>
