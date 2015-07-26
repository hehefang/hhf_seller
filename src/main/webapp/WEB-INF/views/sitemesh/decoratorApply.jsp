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
</head>
<body>
	<div class="wrapper">
		<!-- header -->
		<div id="header">
			<div class="wrap">
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
				<ul>
					<li class="nav-01"><a href="#"><i class="icon"></i>商家助手</a></li>
					<li class="nav-02"><a href="#"><i class="icon"></i>商品管理</a></li>
					<li class="nav-03"><a href="#"><i class="icon"></i>品牌特卖</a></li>
					<li class="nav-04"><a href="#"><i class="icon"></i>交易管理</a></li>
					<li class="nav-05"><a href="#"><i class="icon"></i>专场结算</a></li>
					
				</ul>
			</div>
		</div>
		<!-- mainNav end -->
		<!-- container -->
		<div id="container">
			<decorator:body/>
		</div>
		<!-- container end -->
		<!-- footer -->
		<jsp:include page="/common/footer.jsp"/>
		<!-- footer end -->
	</div>	
</body>
</html>
