<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/common/common.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>忘记密码-禾合坊</title>
		<link rel="stylesheet" href="${cssUrl}/css/allstyle.min.css" />
		<link rel="stylesheet" href="${cssUrl}/css/register.css" />
		<script type="text/javascript" src="${jsUrl}/g.js?t=20150126"></script>
		<script type="text/javascript" src="${jsUrl}/forget1.js?t=201407222036"></script>
	</head>
	<body id="regsignin">
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
			</div>
		</div>
		<!-- header end -->
		<!-- container -->
		<div id="container">
			<div class="wrap">
				<div class="signinForm findpw clearfix">
					<!-- findpw-hd -->
					<div class="auditStep">
						<h2>找回密码</h2>
						<ul class="mod-step">
							<li class="now">
								<i class="disc">1</i>
								<span class="strip"></span>
								<p class="text">输入用户名</p>
							</li>
							<li class="">
								<i class="disc">2</i>
								<span class="strip"></span>
								<p class="text">验证身份</p>
							</li>
							<li class="">
								<i class="disc">3</i>
								<span class="strip"></span>
								<p class="text">设置新密码</p>
							</li>
							<li class="last">
								<i class="disc"></i>
								<span class="strip"></span>
								<p class="text">完成</p>
							</li>
						</ul>
					</div>
					<!-- findpw-hd end -->
					<form class="form" action="${ctx}/forget/step2" id="frm" method="post">
						<fieldset>
							<dl class="form-item">
								<dt class="item-label"><label>用户名：</label></dt>
								<dd class="item-cont"><input type="text" class="txt textC" maxlength="20" name="loginName" id="loginName" value="${fn:escapeXml(param.loginName)}"></dd>
							</dl>
							<dl class="form-item">
								<dt class="item-label"><label>验证码：</label></dt>
								<dd class="item-cont">
									<input type="text" class="txt textE" name="validator" id="validator"  maxlength="4" autocomplete="off">
									<div class="item-code"><img width="63" height="34" src="${ctx}/validator?t=<%= new java.util.Date().getTime() %>" id="imgValidator"></div>
									<p class="changeone"><a href="#" id="changeone">换一张</a></p>
									<div class="note errTxt" id="msg"><c:out value="${msg}"/></div>
								</dd>
							</dl>
							<dl class="form-item">
								<dt class="item-label hidden"><label>下一步：</label></dt>
								<dd class="item-cont"><input type="submit" value="下一步" class="btn btn-primary lg nextBtn"></dd>
							</dl>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
		<!-- container end -->
		<!-- footer -->
		<jsp:include page="/common/footer.jsp"/>
		<!-- footer end -->
	</div>	
		
	</body>
</html>
