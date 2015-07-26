<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>卖家|收款银行账户</title>
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
					<h2>收款银行账户</h2>
				</div>
				<!-- mainCaption end -->
				<div class="section">
					<!-- form -->
					<form class="form form-helper" id="payeeForm" >
						<div class="mod-tips">
							<dl>
								<dt class="imgIcon"><i class="icon i-dangerSM"></i></dt>
								<dd>
									<p>收款银行账户将用于结算时的商家收款账户，请准确填写。</p>
								</dd>
							</dl>
						</div>
						<fieldset>
							<div class="form-item">
								<div class="item-label"><label></label><em>*</em>收款单位全称：</div>
								<div class="item-cont">
									<input type="text" class="txt lg w-xl" id="payeeName" name="payeeName" value="<c:out value="${s.payeeName }" />" /><span class="note">请填写与入住申请完全一致的单位名称</span>
									<div class="note errTxt"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label></label><em>*</em>收款账号：</div>
								<div class="item-cont">
									<input type="text" class="txt lg w-xl" id="bankAcctNo" name="bankAcctNo" value="<c:out value="${s.bankAcctNo }" />" />
									<div class="note errTxt"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label></label><em>*</em>收款账户开户行：</div>
								<div class="item-cont">
									<input type="text" class="txt lg w-xl" id="branchName" name="branchName" value="<c:out value="${s.branchName }" />" />
									<div class="note errTxt"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label></label><em>*</em>开户行所在地：</div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl" id="branchAddress" name="branchAddress" value="<c:out value="${s.branchAddress }" />"   /><span class="note">请填写到城市，如河北省石家庄市</span>
									<div class="note errTxt"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-cont">
									<input type="button" id="savePayee" value="保 存" class="btn btn-primary lg p-xl">
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
	<script type="text/javascript" src="${jsUrl}/popWindown.js?t=20150210"></script>
	<script type="text/javascript">
	function checkFromData(){
		var ret = true;
		
		var payeeName = $('input[name=payeeName]'),bankAcctNo = $('input[name=bankAcctNo]'),branchName = $('input[name=branchName]'),branchAddress = $('input[name=branchAddress]');
	
		if(!payeeName.val()){
			payeeName.siblings().eq(1).text('收款单位全称不能为空！');
			ret = false;
		}else{
			payeeName.siblings().eq(1).text('');	
		}
		
		if(!bankAcctNo.val()){
			bankAcctNo.next().text('收款账号不能为空！');
			ret = false;
		}else{
			bankAcctNo.next().text('');
		}
		
		if(!branchName.val()){
			branchName.next().text('收款账户开户行不能为空！');
			ret = false;
		}else{
			branchName.next().text('');
		}
		
		if(!branchAddress.val()){
			branchAddress.siblings().eq(1).text('开户行所在地不能为空！');
			ret = false;
		}else{
			branchAddress.siblings().eq(1).text('');
		}
		
		return ret;
	}
	
	$(function(){
		$('#savePayee').bind('click',function(){
			if (!checkFromData()) {
				return false;
			}else{
				$.ajax({
					url : "${ctx }/helper/savePayee",
					data : $('#payeeForm').serialize(),
					type : "post",
					cache : false,
					async : false,
					success : function(data) {
						if (data > 0) {
							popWindown("修改成功","submit:收款银行账户资料修改成功！","","1");
						}else {
							popWindown("保存失败","issue:网络连接异常，请联系网络管理员！","","1");
							return;
						}
					}
				});
			}
		});
		
	});
	

	</script>
</body>
</html>