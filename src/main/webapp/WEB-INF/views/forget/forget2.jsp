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
		<script type="text/javascript" src="${jsUrl}/forget2.js?t=201407222036"></script>
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
							<li class="past">
								<i class="disc">1</i>
								<span class="strip"></span>
								<p class="text">输入用户名</p>
							</li>
							<li class="now">
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
					<form class="form formA" id="frm" action="<%= request.getContextPath() %>/forget/step3" method="post">
						<fieldset>
							<dl class="form-item">
								<dt class="item-label"><label>用户名：</label></dt>
								<dd class="item-cont"><div class="phoneCode"><c:out value="${param.loginName}"/>
									<input type="hidden" id="loginName" name="loginName" value="${param.loginName}"></div></dd>
							</dl>
							<dl class="form-item">
								<dt class="item-label"><label>已验证手机号：</label></dt>
								<dd class="item-cont">
									<div class="phoneCode" id="divMobile"></div>
									<input type="hidden" id="mobile" name="mobile" value="${requestScope.mobile}">
									<a href="#" class="btn btn-def checkCode" id="btnSms">获取短信验证码</a>
									<div class="note" id="btnSms_msg"></div>
								</dd>
							</dl>
							<dl class="form-item">
								<dt class="item-label"><label>短信验证码：</label></dt>
								<dd class="item-cont"><input type="text" class="txt textE" id="sms" name="sms" maxlength="6" autocomplete="off">
									<div class="note errTxt" id="sms_msg" ></div>
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
