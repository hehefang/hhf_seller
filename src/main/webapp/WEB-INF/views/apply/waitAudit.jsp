<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/common/common.jsp"%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>入驻审核-禾合坊</title>
</head>
<body>
	<link rel="stylesheet" href="${cssUrl}/css/join.css" />
	
	<script type="text/javascript">
	function showApply() {
		$('#applyPop, #applyMask').show();
	}

	function closeApply() {
		$('#applyPop, #applyMask').hide();
	}
	
	<c:if test="${!empty(param.redy)}">
		$(function(){
			showApply();
		});
	</c:if>
	</script>
	<div class="wrap">
				<!-- auditStep -->
				<div class="auditStep">
					<h2>商家入驻</h2>
					<ul class="mod-step">
						<li class="past">
							<i class="disc">1</i>
							<span class="strip"></span>
							<p class="text">提交申请</p>
						</li>
						<li class="now">
							<i class="disc">2</i>
							<span class="strip"></span>
							<p class="text">入驻审核</p>
						</li>
						<li class="last">
							<i class="disc"></i>
							<span class="strip"></span>
							<p class="text">完成入驻</p>
						</li>
					</ul>
				</div>
				<!-- auditStep end -->
				<!-- joinAplly -->
				<div class="joinAplly apllyProgress">
					<form class="form form-join">
						<div class="mod-tips">
							<dl>
								<dt class="imgIcon"><i class="icon i-danger"></i></dt>
								<dd>
									<p>1、审核时效：资质初审3-5个工作日内，保证金审核 3-7个工作日内，店铺授权为每项审核通过后即生效。</p>
									<p>2、审核通过后，系统将通过手机、邮件方式通知您进行后续商品、专场添加事宜。</p>
								</dd>
							</dl>
						</div>
						<fieldset>
							<div class="legend"><h3>审核进度查询</h3></div>
							<table class="table table-line table-left table-full">
								<colgroup>
									<col width="220">
									<col width="390">
									<col width="220">
									<col width="180">
									<col width="130">
								</colgroup>
								<thead>
									<tr>
										<th class="table-center">审核条目</th>
										<th>您的情况</th>
										<th>操作时间</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="table-center">申请资料</td>
										<td>资料已上传</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${apply.applyDate}" /></td>
										<td><i class="icon i-clock"></i>
											<c:choose>
												<c:when test="${apply.status=='1'}">待审核</c:when>
												<c:when test="${apply.status=='3'}">驳回</c:when>
											</c:choose>
										</td>
										<td><c:choose>
												<%-- <c:when test="${apply.status=='1'}"><a href="${ctx}/apply/apply">查看</a></c:when> --%>
												<c:when test="${apply.status=='3'}"><a href="${ctx}/apply/apply">修改</a></c:when>
											</c:choose></td>
									</tr>
									<tr>
										<td class="table-center">保证金</td>
										<c:choose>
												<c:when test="${(not empty seller) and seller.isPaidDeposit=='1'}">
													<td>保证金已缴纳，可以发布商品及其他设置，可以添加活动</td>
													<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${seller.depositDate}" /></td>
													<td><i class="icon i-gold"></i>已缴款</td>
													<td></td>
												</c:when>
												<c:otherwise>
													<td>保证金未缴纳，可以发布商品及其他设置，但不能添加活动</td>
													<td></td>
													<td><i class="icon i-gold"></i>待缴款</td>
													<td></td>
												</c:otherwise>
										</c:choose>
									</tr>
								</tbody>
							</table>
						</fieldset>
					</form>
				</div>
				<!-- joinAplly end -->
			</div>
		
		<!-- popup -->
		<div class="popup popup-primary" style="width:620px;margin-left:-310px;margin-top:-105px; display: none" id="applyPop">
		<div class="hd"><h2></h2><i class="close" onclick="javascript:closeApply();"></i></div>
		<div class="bd">
			<dl class="popup-doc">
				<dt>
					<i class="icon i-right"></i>
				</dt>
				<dd>
					<h3>欢迎您加入禾合坊！</h3>
					<p>您的入驻申请已提交平台，预计将在3-5个工作日内审核完成。</p>
					<p>您可凭登录账号，登录后查询审核进度；如遇疑问或问题，请与平台客服中心联系！</p>
					<div class="btnWrap"><a href="javascript:closeApply();" class="btn btn-primary">我知道了</a></div>
				</dd>
			</dl>
		</div>
	</div>
	<div class="mask" id="applyMask" style="display: none"></div>
		
</body>
</html>