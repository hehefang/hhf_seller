<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/common/common.jsp"%>       
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>申请新品牌-禾合坊</title>
</head>
<body>
	<link rel="stylesheet" href="${cssUrl}/css/product.css?t=20150129" />
	<link rel="stylesheet" href="${ctx}/uploadify/uploadify.css?t=20150129" />
	<script type="text/javascript">
		var ctx = '${ctx}';
		var imgUploadUrl = '${imgUploadUrl}';
		var imgGetUrl = '${my:random(imgGetUrl)}';
		var f = '${param.f}';
	</script>	
	<script type="text/javascript" src="${ctx}/uploadify/jquery.uploadify.min.js?t=20150129"></script>
	<script type="text/javascript" src="${jsUrl}/brandPage.js?t=20150604"></script>
	<script type="text/javascript">
		$(function(){
			if(f) $('#popBrand, #maskBrand').show();
		})			
	</script>
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
	
	<!-- mainCaption -->
	<div class="mainCaption">
		<h2>申请新品牌</h2><a href="${ctx}/product/brand?m=2004" class="btn btn-def applyBrand">品牌列表</a>
	</div>
	<!-- mainCaption end -->
	<div class="section">
		<!-- form -->
		<form class="form form-brand" method="post" action="brandCommit" id="frm">
			<div class="mod-tips">
				<dl>
					<dt class="imgIcon"><i class="icon i-dangerSM"></i></dt>
					<dd>
						<c:choose>
							<c:when test="${!empty(sellerBrand.auditContent)}"><p>驳回理由：<c:out value="${sellerBrand.auditContent}"/></p></c:when>
							<c:otherwise><p>添加的新品牌，系统将在3-5个工作日内审核，审核通过后才允许使用；</p></c:otherwise>
						</c:choose>						
					</dd>
				</dl>
			</div>
			<fieldset>
				<div class="legend"><h3>品牌信息</h3></div>
				<div class="form-item">
					<div class="item-label"><label><em>*</em>选择品牌：</label></div>
					<div class="item-cont">
						<c:choose>
							<c:when test="${empty(sellerBrand)}">
								<div class="searchGroup" id="searchGroup">
									<input type="text" class="txt lg w-lgl" id="brandName" name="brandName" autocomplete="off"/>
									<i class="icon i-zoom" id="searchBtn"></i>
								</div>
								<span class="note">找不到想要申请的品牌？请联系客服： 400-898-8888</span>
								<div class="brandResult">
									<ul id="searchResult">
									</ul>
								</div>
							</c:when>
							<c:otherwise>
								<input type="text" class="txt lg w-lg " style="width:230px;background-color:#eee" id="brandName" name="brandName" value="${sellerBrand.showName}" readonly="readonly">
							</c:otherwise>						
						</c:choose>						
						
						<input type="hidden" id="brandId" name="brandId" value="${sellerBrand.brandId}">
						<div class="note errTxt" id="brandId_msg"></div>
					</div>
				</div>
				<div class="form-item">
					<div class="item-label"><label><em>*</em>授权类型：</label></div>
					<div class="item-cont">
						<label><input type="radio" class="radio" name="authType" value="1" ${sellerBrand.authType == '1' ? 'checked="checked"' : ''}/>自有品牌</label>
						<label><input type="radio" class="radio" name="authType" value="2" ${sellerBrand.authType == '2' ? 'checked="checked"' : ''}/>独家代理</label>
						<label><input type="radio" class="radio" name="authType" value="3" ${sellerBrand.authType == '3' ? 'checked="checked"' : ''}/>一级代理</label>
						<label><input type="radio" class="radio" name="authType" value="4" ${sellerBrand.authType == '4' ? 'checked="checked"' : ''}/>二级代理</label>
						<label><input type="radio" class="radio" name="authType" value="5" ${sellerBrand.authType == '5' ? 'checked="checked"' : ''}/>三级代理</label>
						<div class="note errTxt" id="authType_msg"></div>
					</div>
				</div>
				<div class="form-item">
					<div class="item-label"><label><em>*</em>授权有效期：</label></div>
					<div class="item-cont">
						<div class="txt-section"><input type="text" class="txt txt-date" onfocus="WdatePicker()" name="sAuthStartDate" id="sAuthStartDate" value="${sellerBrand.sAuthStartDate}"><i>到</i>
							<input type="text" class="txt txt-date" onfocus="WdatePicker()" name="sAuthEndDate" id="sAuthEndDate" value="${sellerBrand.sAuthEndDate}">
						</div>
						<span class="note">长期有效的可不填结束日期</span>
						<div class="note errTxt" id="authDate_msg"></div>
					</div>
				</div>
				<div class="form-item">
					<div class="item-label"><label><em>*</em>商标注册证 / 商标受理通知书：</label></div>
					<div class="item-cont">
						<div class="mod-upload" style="position:relative;">
							<c:choose>
								<c:when test="${empty(sellerBrand.trademarkCert)}">
									<img src="${cssUrl}/img/upload_img.jpg" alt="" id="imgTrademarkCert">
								</c:when>
								<c:otherwise>
									<img src="${my:random(imgGetUrl).concat('?rid=').concat(sellerBrand.trademarkCert)}&op=s2_w97_h97" alt="" id="imgTrademarkCert">
								</c:otherwise>
							</c:choose>
						</div>
						<p class="submit-btn">
							<input type="hidden" id="trademarkCert" name="trademarkCert" value="${sellerBrand.trademarkCert}" data-required="true" data-describedby="trademarkCert_msg" data-description="trademarkCert">
							<input type="button" class="btn btn-def" value="上 传" id="btnTrademarkCert">
						</p>
						<div class="note errTxt" id="trademarkCert_msg"></div>
					</div>
				</div>
				<div class="form-item">
					<div class="item-label"><label><em>*</em>品牌授权书：</label></div>
					<div class="item-cont">
						<div class="mod-upload" style="position:relative;">
							<c:choose>
								<c:when test="${empty(sellerBrand.authCert)}">
									<img src="${cssUrl}/img/upload_img.jpg" alt="" id="imgAuthCert">
								</c:when>
								<c:otherwise>
									<img src="${my:random(imgGetUrl).concat('?rid=').concat(sellerBrand.authCert)}&op=s2_w97_h97" alt="" id="imgAuthCert">
								</c:otherwise>
							</c:choose>
						</div>
						<p class="submit-btn">
							<input type="hidden" id="authCert" name="authCert" value="${sellerBrand.authCert}" data-required="true" data-describedby="authCert_msg" data-description="authCert">
							<input type="button" class="btn btn-def" value="上 传" id="btnAuthCert">
						</p>
						<div class="note errTxt" id="authCert_msg"></div>
					</div>
				</div>
				<div class="form-item">
					<div class="item-label"><label><em>*</em>其他资质：</label></div>
					<div class="item-cont">
						<div class="mod-upload" style="position:relative;">
							<c:choose>
								<c:when test="${empty(sellerBrand.otherCert)}">
									<img src="${cssUrl}/img/upload_img.jpg" alt="" id="imgOtherCert">
								</c:when>
								<c:otherwise>
									<img src="${my:random(imgGetUrl).concat('?rid=').concat(sellerBrand.otherCert)}&op=s2_w97_h97" alt="" id="imgOtherCert">
								</c:otherwise>
							</c:choose>
						</div>
						<p class="submit-btn">
							<input type="hidden" id="otherCert" name="otherCert" value="${sellerBrand.otherCert}" data-required="true" data-describedby="otherCert_msg" data-description="otherCert">
							<input type="button" class="btn btn-def" value="上 传" id="btnOtherCert">
						</p>
						<div class="note errTxt" id="otherCert_msg"></div>
					</div>
				</div>
				<div class="form-item item-category">
					<div class="item-label"><label><em>*</em>经营类目：</label></div>
					<div class="item-cont">
						<textarea name="categories" id="categories" cols="60" rows="5" class="resize-none" placeholder="例如服装，玩具" style="width: 420px;height: 60px" data-required="true" data-describedby="categories_msg" data-description="categories"><c:out value="${sellerBrand.categories}"/></textarea>
						<div class="note errTxt" id="categories_msg"></div>
					</div>
				</div>
				<div class="form-item">
					<div class="item-label hide"><label>提交审核：</label></div>
					<div class="item-cont">
						<input type="hidden" name="sellerBrandId" id="sellerBrandId" value="${sellerBrand.sellerBrandId}">
						<input type="submit" value="提交审核" class="btn btn-primary lg p-lg">
						<input type="button" value="取 消" class="btn btn-def lg p-lg" onclick="javascript:self.location.href='brand?m=2004';">
					</div>
				</div>
			</fieldset>
		</form>
	<!-- form end -->
	</div>
	
	<!-- popup -->
	<div class="popup popup-primary" style="width:600px;margin-left:-300px;display:none" id="popBrand">
		<div class="hd"><h2></h2><i class="close" onclick="javascript:$('#popBrand, #maskBrand').hide();"></i></div>
		<div class="bd">
			<dl class="popup-doc">
				<dt>
					<i class="icon i-right"></i>
				</dt>
				<dd>
					<h3>品牌申请成功 ！</h3>
					<p>请等待系统审核，审核进度可通过品牌列表进行查询。</p>
					<div class="btnWrap"><a href="${ctx}/product/brand?m=2004" class="btn btn-primary">查看已申请品牌</a></div>
				</dd>
			</dl>
		</div>
	</div>	
	<div class="mask" id="maskBrand" style="display:none"></div>
	<!-- popup end -->
	
</body>
</html>