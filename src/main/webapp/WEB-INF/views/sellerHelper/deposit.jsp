<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>卖家|保证金</title>
</head>
<body>
	<link rel="stylesheet" href="${cssUrl}/css/helper.css" />
	<div class="wrapper wrap-helper">
		<!-- container -->
		<div id="container">
			<!-- main -->
			<div id="main">
				<!-- mainCaption -->
				<div class="mainCaption">
					<h2>保证金</h2>
				</div>
				<!-- mainCaption end -->
				<div id="deposit">
					<div class="mod-tips">
						<dl>
							<dt class="imgIcon"><i class="icon i-danger"></i></dt>
							<dd>
								<h4>您公司保证金<c:out value="${s.isPaidDeposit == '1' ? '已缴纳' : '未缴纳'}"/>！</h4>
								<c:if test="${s.isPaidDeposit == '0'}">
								<p>您公司保证金审核未通过，因此暂时不能申请或管理“品牌专场”功能，请尽快完成缴费。</p>
							    </c:if>
							    <c:if test="${s.isPaidDeposit == '1'}">
							    <script type="text/javascript">$(function(){showDeposit1()})</script>
							    </c:if>
							</dd>
						</dl>
					</div>
					<h3>如何缴纳保证金？</h3>
					<div class="textInfo">
						<p>目前我们接受线下打款的方式来缴纳保证金，你可以根据以下信息进行汇款，我们会在收到款后两个工作日内审核入账。</p>
						<div class="bankInfo">
							<p><strong>开户名：</strong>北京宝源昌行商贸有限公司</p>
							<p><strong>开户银行：</strong>建行东大街支行</p>
							<p><strong>银行账号：</strong>1100 1069 6000 5302 6784</p>
						</div>
						<div class="note"><em class="textMark warnColor">*</em>保证金不接受个人帐号汇款！请务必使用企业对公帐号汇款，汇款备注为 “ <b>禾合坊保证金</b> ” ，以便核查。</div>
						<div class="note"><em class="textMark warnColor">*</em>禾合坊仅提供如上唯一的保证金收款账号，请勿相信其他任何个人或组织以任何方式提供的银行账号。</div>
					</div>
					<h3><a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">保证金收费标准</a></h3>
					<h3><a href="http://help.hehefang.com/seller/shangjiaruzhu.html" target="_blank">保证金管理规则</a></h3>
				</div>
			</div>
			<!-- main end -->
		</div>
<script type="text/javascript">

function showDeposit1() {
	$('#depositPop1, #depositMask1').show();
}

function closeDeposit1() {
	$('#depositPop1, #depositMask1').hide();
}
</script>
		<!-- container end -->
	</div>
		<div class="popup popup-primary" style="width:620px;margin-left:-310px; margin-top:-101px; display: none" id="depositPop1">
		<div class="hd"><h2></h2><i class="close" onclick="javascript:closeDeposit1();"></i></div>
		<div class="bd">
			<dl class="popup-doc">
				<dt>
					<i class="icon i-right"></i>
				</dt>
				<dd>
					<h3>保证金已缴纳 ！</h3>
					<p>您公司保证金已确认到账，请尽快发布品牌特卖活动。</p>
					<div class="btnWrap"><a href="javascript:closeDeposit1();" class="btn btn-primary">我知道了</a></div>
				</dd>
			</dl>
		</div>
	</div>
	<div class="mask" id="depositMask1" style="display: none"></div>
</body>
</html>