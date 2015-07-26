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
		<script type="text/javascript" src="${jsUrl}/forget3.js?t=201407222036"></script>
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
			<div class="wrap ">
				<div class="signinForm findpw">
					<!-- findpw-hd -->
					<div class="auditStep">
						<h2>找回密码</h2>
						<ul class="mod-step">
							<li class="past">
								<i class="disc">1</i>
								<span class="strip"></span>
								<p class="text">输入用户名</p>
							</li>
							<li class="past">
								<i class="disc">2</i>
								<span class="strip"></span>
								<p class="text">验证身份</p>
							</li>
							<li class="now">
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
					<form class="form formA" id="frm" method="post" action="${ctx}/forget/step4">
						<fieldset>
							<dl class="form-item">
								<dt class="item-label"><label>新登录密码：</label></dt>
								<dd class="item-cont"><input type="password" class="txt textC" id="password" name="password" maxlength="20">
									<div class="checkHint errTxt">
									<div class="hintBox" id="password_msg"><span></span></div>
									</div>
									<div class="note">由字母加数字或符号至少两种以上字符组成的6-20位半角字符，区分大小写。</div>
								</dd>
							</dl>
							<dl class="form-item">
								<dt class="item-label"><label>确认新密码：</label></dt>
								<dd class="item-cont"><input type="password" class="txt textC" id="confirmPassword" name="confirmPassword" maxlength="20">
									<div class="checkHint errTxt">
									<div class="hintBox" id="confirmPassword_msg"><span></span></div>
									</div>
									<div class="warn hint block">再次输入新密码</div>
								</dd>
							</dl>
							<dl class="form-item">
								<dt class="item-label hidden"><label>提交：</label></dt>
								<dd class="item-cont"><input type="submit" class="btn btn-primary nextBtn" value="提交" />
									<input type="hidden" id="loginName" name="loginName" value="${fn:escapeXml(param.loginName)}">
									<input type="hidden" name="mobile" id="mobile" value="${param.mobile}">
								</dd>
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
