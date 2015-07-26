<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>卖家|开票信息</title>
</head>
<body>
	<link rel="stylesheet" href="${cssUrl}/css/helper.css" />
	<script type="text/javascript">
		var ctx = '${ctx}';
		var imgUploadUrl = '${imgUploadUrl}';
		var imgGetUrl = '${my:random(imgGetUrl)}';
	</script>	
	<script type="text/javascript" src="${ctx}/uploadify/jquery.uploadify.min.js?t=20150129"></script>
       <script type="text/javascript" src="${jsUrl}/jquery-validate.min.js?t=20150601"></script>
	<script type="text/javascript" src="${jsUrl}/popWindown.js?t=20150210"></script>
	<script type="text/javascript" src="${jsUrl}/receipt.js?t=20150129"></script>
	<style>
		.uploadBtn{
		 	cursor:hand;
			width: 54px;
			height: 24px;
			padding: 0;
			margin-left:20px;
			font-size: 12px;
			background: url(${cssUrl}/img/control/btnbg.jpg) repeat-x 0 10%;
			border-color: #c5c5c5;
			color:#666;
			text-shadow:none;
			border:1px solid #708090;
			font-weight:100;
			border-radius: 4px;
			-webkit-border-radius: 4px;
			-moz-border-radius: 4px;
		}
		
		 .uploadify:hover .uploadify-button {
			 padding: 0;
		     background:#F0F0F0;
		 }
	</style>
	<div class="wrapper wrap-helper">
		<!-- container -->
		<div id="container">
			<!-- main -->
			<div id="main">
				<!-- mainCaption -->
				<div class="mainCaption">
					<h2>开票信息</h2>
				</div>
				<!-- mainCaption end -->
				<div class="section">
					<!-- form -->
					<form class="form form-helper" id="receiptForm" method="post" >
						<div class="mod-tips">
							<dl>
								<dt class="imgIcon"><i class="icon i-dangerSM"></i></dt>
								<dd>
									<p>开票信息请勿必准确，以免影响发票的办理；<!-- 请有疑问，请与禾合坊客服联系，咨询电话：xxx-xxxxxxxx --></p>
								</dd>
							</dl>
						</div>
						<fieldset>
							<div class="legend"><h3>开票信息</h3></div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>单位全称：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl" dblength="33" id="coName" name="coName" value="<c:out value="${receipt.coName}"/>" data-required="true" data-describedby="coName_msg" data-description="coName"/>
									<div class="note errTxt" id="coName_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>公司税号：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl"  autocomplete="off" dblength="50" id="taxNo" name="taxNo" value = "<c:out value="${receipt.taxNo }" />" data-required="true" data-describedby="taxNo_msg" data-description="taxNo" />
									<div class="note errTxt" id="taxNo_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>公司注册地址：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-xl" dblength="30" id="registerAddr" name="registerAddr" value="<c:out value="${receipt.registerAddr }" />" data-required="true" data-describedby="registerAddr_msg" data-description="registerAddr"/>
									<div class="note errTxt" id="registerAddr_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>公司注册电话：</label></div>
								<div class="item-cont">
									<div class="txt-tel">
										<input type="text" class="txt lg telArea" data-pattern="^\d{3,4}$"  id="telArea" name="telArea" ata-required="true" value="${receipt.telArea}" maxlength="4"  data-description="telArea" data-describedby="telNo_msg" ><i>-</i>
										<input type="text" class="txt lg telNum" id="telNo" data-required="true" name="telNo" data-pattern="^\d{8}$" data-description="telNo"  data-describedby="telNo_msg" value="${receipt.telNo}" maxlength="8"><i>-</i>
										<input type="text" class="txt lg telExt" id="telExt" name="telExt" data-pattern="^\d{1,4}$" data-description="telExt"  data-describedby="telNo_msg" value="${receipt.telExt}" maxlength="4">
										<div class="note errTxt" id="telNo_msg"></div>
									</div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>开户行：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl" dblength="30" id="bankAcctName" name="bankAcctName" value="<c:out value="${receipt.bankAcctName }" />" data-required="true" data-describedby="bankAcctName_msg" data-description="bankAcctName" />
									<div class="note errTxt" id="bankAcctName_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>银行账号：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl" dblength="18" id="bankAcctNo" name="bankAcctNo" value="<c:out value="${receipt.bankAcctNo }" />" data-required="true" data-describedby="bankAcctNo_msg" data-description="bankAcctNo" />
									<div class="note errTxt" id="bankAcctNo_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>发票类型：</label></div>
								<div class="item-cont">
									<select name="taxType" id="taxType" class="select">
									<!--     <option value="">全部</option> -->
									    <option <c:if test="${receipt.taxType == '1'}">selected="selected"</c:if> value="1">一般纳税人</option>
									    <option <c:if test="${receipt.taxType == '2'}">selected="selected"</c:if> value="2">小规模纳税人</option>
									</select>
									<div class="note errTxt" id="taxType_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label">
									<label><em>*</em>税务登记证：</label>
									<p class="lightColor">（需加盖公司公章）</p>
								</div>
								<div class="item-cont">
									<div class="mod-upload" style="position:relative">
									<c:choose>
										<c:when test="${empty(receipt.taxImg)}">
											<img src="${cssUrl}/img/upload_img.jpg" alt="" id="imgTaxImg">
										</c:when>
										<c:otherwise>
											<img src="${my:random(imgGetUrl)}?rid=${receipt.taxImg}" alt="" id="imgTaxImg">
										</c:otherwise>
									</c:choose>			
									<input type="hidden" id="taxImg" name="taxImg" data-required="true" value="${receipt.taxImg}" data-describedby="taxImg_msg" data-description="taxImg">
									</div>
									<p class="submit-btn">
									<input type="button" class="btn btn-def" value="上 传" id="btnTaxImg">
									</p>
									<div class="note errTxt" id="taxImg_msg"></div>				
								</div>
							</div>
							<div class="form-item">
								<div class="item-label">
									<label><em>*</em>一般纳税人资质证明：</label>
									<p class="lightColor">（需加盖公司公章）</p>
								</div>
								<div class="item-cont">
									<div class="mod-upload" style="position:relative">
									<c:choose>
										<c:when test="${empty(receipt.qualiUrl)}">
											<img src="${cssUrl}/img/upload_img.jpg" alt="" id="imgQualiUrl">
										</c:when>
										<c:otherwise>
											<img src="${my:random(imgGetUrl)}?rid=${receipt.qualiUrl}" alt="" id="imgQualiUrl">
										</c:otherwise>
									</c:choose>			
									<input type="hidden" id="qualiUrl" name="qualiUrl" data-required="true" value="${receipt.qualiUrl}" data-describedby="qualiUrl_msg" data-description="qualiUrl">
									</div>
									<p class="submit-btn">
									<input type="button" class="btn btn-def" value="上 传" id="btnQualiUrl">
									</p>
									<div class="note errTxt" id="qualiUrl_msg"></div>	
								</div>
							</div>
						</fieldset>
						<fieldset>
							<div class="legend"><h3>收票人信息</h3></div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>收件人姓名：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl" id="rName" name="rName" value="<c:out value="${receipt.rName }" />" data-required="true" data-describedby="rName_msg" data-description="rName" dblength="20" />
									<div class="note errTxt" id="rName_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>收件人手机号：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl" id="rMobile" name="rMobile" value="<c:out value="${receipt.rMobile }" />" data-required="true" data-describedby="rMobile_msg" data-description="rMobile" data-pattern="^[1]\d{10}$" maxlength="11" />
									<div class="note errTxt" id="rMobile_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>收件地址：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-xl" id="rAddress" name="rAddress" value="<c:out value="${receipt.rAddress }" />" data-required="true" data-describedby="rAddress_msg" data-description="rAddress" dblength="60"/>
									<div class="note errTxt" id="rAddress_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-cont">
									<input type="submit" value="保 存"  class="btn btn-primary lg p-xl">
								</div>
							</div>
						</fieldset>
						<input type="hidden" id="receiptId" name="receiptId"  value="${receipt.receiptId }">
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
