<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/common/common.jsp"%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<link rel="stylesheet" href="${cssUrl}/css/allstyle.min.css" />
<link rel="stylesheet" href="${cssUrl}/css/register.css" />
<script type="text/javascript" src="${jsUrl}/g.js?t=20150126"></script>
<script type="text/javascript" src="${jsUrl}/register.js?t=20150126"></script>
<title>商家注册-禾合坊</title>
<style type="text/css">
	.success-gou{
		background: url(img/reg-wraning.png) no-repeat right 4px;
	}
</style>
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
			<div class="wrap wrap-register">
				<div class="signinForm clearfix">
					 <form class="form" action="doRegister" id="frm" method="post">
					 	<h2>卖家注册</h2>
						<dl class="form-item item-user">
							<dt class="item-label"><label><em>*</em>用户名：</label></dt>
							<dd class="item-cont">
								<input type="text" placeholder="" class="txt lg" id="loginName"
				name="loginName" maxlength="20" autocomplete="off" value="${fn:escapeXml(param.loginName)}"/>
								<div class="checkHint" id="loginName_msg"><div class="hintBox"><span>6-20位字符，可使用中文、英文、数字及“_”、“-”组成，注册后不允许修改</span></div></div>
							</dd>	
						</dl>
						<dl class="form-item item-pwd">
							<dt class="item-label"><label><em>*</em>昵称：</label></dt>
							<dd class="item-cont">
								<input type="text" class="txt lg" id="nickname"
				name="nickname" maxlength="24" autocomplete="off" value="${fn:escapeXml(param.nickname)}"/>
								<div class="checkHint" id="nickname_msg"><div class="hintBox"><span>5-24字符(12个汉字)，字母/数字/中文</span></div></div>
							</dd>
						</dl>
						<dl class="form-item item-pwd">
							<dt class="item-label"><label><em>*</em>密码：</label></dt>
							<dd class="item-cont">
								<input type="password" class="txt lg" id="password" name="password" maxlength="20"/>
								<div class="checkHint" id="password_msg"><div class="hintBox"><span>6-20字符，请使用英文加数字或符号组合密码，不能单独使用英文，数字或符号</span></div></div>
							</dd>
						</dl>
						<dl class="form-item item-pwd">
							<dt class="item-label"><label><em>*</em>确认密码：</label></dt>
							<dd class="item-cont">
								<input type="password" class="txt lg" id="password2" name="password2" maxlength="20"/>
								<div class="checkHint" id="password2_msg"><div class="hintBox"><span>请再次输入登录密码</span></div></div>
							</dd>
						</dl>
						<dl class="form-item item-phone">
							<dt class="item-label"><label><em>*</em>手机号：</label></dt>
							<dd class="item-cont">
								<input type="text" class="txt lg" id="mobile"
				name="mobile" maxlength="11" autocomplete="off" value="${fn:escapeXml(param.mobile)}"/>
								<div class="checkHint" id="mobile_msg"><div class="hintBox"><span>请输入11位手机号码（支持中国移动、联通、 电信的手机号码）</span></div></div>
							</dd>
						</dl>
						<dl class="form-item item-agree">
							<dt class="item-label"></dt>
							<dd class="item-cont">
								<p><input type="checkbox" name="chkAgreement" id="chkAgreement" value="" class="chk" checked="checked" /><label for="chkAgreement">我已阅读并同意</label><a href="http://css.seller.hehefang.com/deal2.html" target="_blank" >《禾合坊注册服务协议》</a><span class="errTxt" id="agreement_msg" style="display:none">请接受服务条款</span></p>
								<input type="submit" value="同意协议并注册"  class="btn btn-primary regBtn">
							</dd>
						</dl>
					</form>
					<div class="reg-login">
						<img src="${cssUrl}/img/register.png" alt="">
						<p>已有禾合坊商家账号？</p>
						<a href="${ctx}/login" class="btn btn-def">立即登录</a>
					</div>
				</div>
			</div>
		</div>
		<!-- container end -->
		
		<jsp:include page="/common/footer.jsp"/>
	</div>
</body>

</html>