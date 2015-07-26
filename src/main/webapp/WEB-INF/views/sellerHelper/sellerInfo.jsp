<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>卖家|基本信息</title>
</head>
<body>
	<link rel="stylesheet" href="${cssUrl}/css/helper.css" />
	<div class="wrapper wrap-helper">
		<!-- container -->
		<div id="container">
			<div id="main">
				<!-- mainCaption -->
				<div class="mainCaption">
					<h2>基本信息</h2>
				</div>
				<!-- mainCaption end -->
				<div class="section">
					<!-- form -->
					<form class="form form-helper">
						<fieldset>
							<div class="legend"><h3>商家信息</h3></div>
							<div class="form-item">
								<div class="item-label"><label>公司名称：</label></div>
								<div class="item-cont">
									<span><c:out value="${s.coName }" /></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>营业执照注册号：</label></div>
								<div class="item-cont">
									<span><c:out value="${s.coBln }" /></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>法人姓名：</label></div>
								<div class="item-cont">
									<span><c:out value="${s.lpName }" /></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>注册资本：</label></div>
								<div class="item-cont">
									<span><c:out value="${s.registerCapital }" />万元</span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>经营范围：</label></div>
								<div class="item-cont">
									<span><c:out value="${s.bizScope }" /></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>营业期限：</label></div>
								<div class="item-cont">
									<span><fmt:formatDate value="${s.btStartDate }" pattern="yyyy-MM-dd HH:mm:ss" /> 至 <fmt:formatDate value="${s.btEndDate }" pattern="yyyy-MM-dd HH:mm:ss" /></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>营业执照所在地：</label></div>
								<div class="item-cont">
									<span><c:out value="${s.btGeo }" /></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>入驻时间：</label></div>
								<div class="item-cont">
									<span><fmt:formatDate value="${s.createDate }" pattern="yyyy-MM-dd HH:mm:ss" /></span>
								</div>
							</div>
						</fieldset>
						<fieldset>
							<div class="legend"><h3>联系人信息</h3></div>
							<div class="form-item">
								<div class="item-label"><label>联系人姓名：</label></div>
								<div class="item-cont">
									<span><c:out value="${s.bizManName  }" /></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>联系人手机号码：</label></div>
								<div class="item-cont">
									<span><c:out value="${s.bizManMobile }" /></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>传真号码：</label></div>
								<div class="item-cont">
								<span><c:out value="${s.fax }" /></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>电子邮箱：</label></div>
								<div class="item-cont">
									<span><c:out value="${s.bizManEmail }" /></span>
								</div>
							</div>
						</fieldset>
					</form>
				<!-- form end -->
				</div>
			</div>
			<!-- main end -->
		</div>
		<!-- container end -->
	</div>
</body>
</html>