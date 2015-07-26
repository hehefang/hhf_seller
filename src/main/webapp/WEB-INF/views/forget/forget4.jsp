<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/common/common.jsp"%>>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>忘记密码-禾合坊</title>
		<link rel="stylesheet" href="${cssUrl}/css/allstyle.min.css" />
		<link rel="stylesheet" href="${cssUrl}/css/register.css" />
		<script type="text/javascript" src="${jsUrl}/g.js?t=20150126"></script>	
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
							<li class="past">
								<i class="disc">2</i>
								<span class="strip"></span>
								<p class="text">验证身份</p>
							</li>
							<li class="past">
								<i class="disc">3</i>
								<span class="strip"></span>
								<p class="text">设置新密码</p>
							</li>
							<li class="last over">
								<i class="disc"></i>
								<span class="strip"></span>
								<p class="text">完成</p>
							</li>
						</ul>
					</div>
					<!-- findpw-hd end -->
					<form class="form formA">
						<dl class="successWarn">
							<dt><i class="icon i-rightLG"></i></dt>
							<dd>
								<h3>恭喜，修改密码成功！</h3>
								<p><a href="${ctx}/login" class="btn btn-def">现在登录</a></p>
							</dd>
						</dl>
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
