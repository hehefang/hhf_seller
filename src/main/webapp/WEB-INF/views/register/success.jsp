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
<title>注册成功-禾合坊</title>
<script type="text/javascript">
var count = 5;
	
$(function(){
	setTimeout(fn, 1000);
});	

function fn() {
	if(count == 0) {
		location.href = 'ws/main?m=1';
		
	} else {
		count--;
		$('#times').html(count);
		setTimeout(fn, 1000);
	}
}
</script>
</head>
<body id="regsignin">
	<div class="wrapper">
		<!-- header -->
		<div id="header">
			<div class="wrap">
				<!-- logo -->
				<div id="logo">
					<div class="logo"><a href="#" title="logo"><img src="${cssUrl}/img/logo.png" alt="logo" /></a></div>
					<h1>商家中心</h1>
				</div>
				<!-- logo end -->
			</div>
		</div>
		<!-- header end -->
		<!-- container -->
		<div id="container">
			<!-- login -->
			<div class="wrap regSuccess">
				<div class="signinForm">
					<dl>
						<dt><i class="icon i-rightLG"></i></dt>
						<dd>
							<h3>恭喜，${fn:escapeXml(param.loginName)}已注册成功！</h3>
							<p>帐号信息已发送到您注册时填写的手机号码 ，请注意查收！</p> 
							<p><strong id="times">5</strong>秒后，将为您自动跳转到卖家中心</p>
							<p><a href="ws/main?m=1" class="btn btn-primary goto">立即跳转</a></p>
						</dd>
					</dl>
				</div>
			</div>
			<!-- login end -->
		</div>
		<!-- container end -->
		<jsp:include page="/common/footer.jsp"/>
	</div>
</body>

</html>