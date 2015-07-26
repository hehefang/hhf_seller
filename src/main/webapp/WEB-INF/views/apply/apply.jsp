<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>卖家申请-禾合坊</title>
</head>
<body>	
	<link rel="stylesheet" href="${cssUrl}/css/join.css?t=20150129" />
	<link rel="stylesheet" href="${ctx}/uploadify/uploadify.css?t=20150129" />
	<script type="text/javascript">
		var ctx = '${ctx}';
		var imgUploadUrl = '${imgUploadUrl}';
		var imgGetUrl = '${my:random(imgGetUrl)}';
	</script>	
	<script type="text/javascript" src="${ctx}/uploadify/jquery.uploadify.min.js?t=20150129"></script>
	<script type="text/javascript" src="${jsUrl}/apply.js?t=20150604"></script>
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

	<div class="wrap">
				<!-- auditStep -->
				<div class="auditStep">
					<h2>商家入驻</h2>
					<ul class="mod-step">
						<li class="now">
							<i class="disc">1</i>
							<span class="strip"></span>
							<p class="text">提交申请</p>
						</li>
						<li class="">
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
				<div class="joinAplly">
					<form class="form form-join" method="post" action="submit" id="frm">
						<c:if test="${!empty(audit.auditOpinion)}">
						<div class="mod-tips">
							<dl>
								<dt class="imgIcon"><i class="icon i-danger"></i></dt>
								<dd>
									<p><c:out value="${(audit.auditOpinion)}"/></p>
								</dd>
							</dl>
						</div>
						</c:if>
						<fieldset>
							<div class="legend"><h3>企业信息<span>用于入驻资料的审核，请填写与公司营业执照一致的信息</span></h3></div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>公司名称：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-xl" autocomplete="off" maxlength="30"  id="coName" name="coName"
								 			value="${fn:escapeXml(data.coName)}" data-describedby="coName_msg" data-required="true" data-description="coName" data-pattern="\S">
									<div class="note errTxt" id="coName_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>营业执照注册号：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl" autocomplete="off" dblength="50"  id="coBln" name="coBln"
								 			value="${fn:escapeXml(data.coBln)}" data-describedby="coBln_msg" data-required="true" data-description="coBln">
									<div class="note errTxt" id="coBln_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>法人姓名：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lg" autocomplete="off" dblength="20"  id="lpName" name="lpName"
								 			value="${fn:escapeXml(data.lpName)}" data-describedby="lpName_msg" data-required="true" data-description="lpName">
									<div class="note errTxt" id="lpName_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>注册资本：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lg" autocomplete="off" maxlength="10"  id="registerCapital" name="registerCapital"
								 			value="${fn:escapeXml(data.registerCapital)}" data-describedby="registerCapital_msg" data-required="true" data-description="registerCapital"><span class="note">/ 万元</span>
									<div class="note errTxt" id="registerCapital_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>经营范围：</label></div>
								<div class="item-cont">
									<textarea name="bizScope" id="bizScope" cols="60" rows="5" dblength="1000" class="resize-none" placeholder="请填写营业执照上的经营范围" style="width: 420px;height: 80px"
										data-describedby="bizScope_msg" data-required="true" data-description="bizScope"><c:out value="${data.bizScope}"/></textarea>
									<div class="note errTxt" id="bizScope_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>营业期限：</label></div>
								<div class="item-cont">
									<div class="txt-section">
										<input type="text" class="txt txt-date" onfocus="WdatePicker()" name="sBtStartDate" id="sBtStartDate" value="${data.sBtStartDate}"><i>到</i>
										<input type="text" class="txt txt-date"  onfocus="WdatePicker()"  name="sBtEndDate" id="sBtEndDate" value="${data.sBtEndDate}"></div><span class="note">长期有效的可不填结束日期</span>
									<div class="note errTxt" id="btDate_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>营业执照所在地：</label></div>
								<div class="item-cont"><input type="text" class="txt lg w-lgl" id="btGeo" name="btGeo" dblength="30" value="${fn:escapeXml(data.btGeo)}"></div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>旗下／代理品牌：</label></div>
								<div class="item-cont"><textarea name="coBrand" id="coBrand" cols="60" rows="5" class="resize-none" placeholder="请填写品牌名称，多个可用,分隔" style="width: 420px;height: 60px" dblength="200"><c:out value="${data.coBrand}"/></textarea></div>
							</div>
						</fieldset>
						<fieldset class="papersUpload">
							<div class="legend"><h3>资料上传<span>仅支持JPG／GIF／PNG格式的图片，大小不超过1M</span></h3></div>
							<table class="table table-line table-left">
								<colgroup>
									<col width="170" />
									<col width="500" />
									<col width="80" />
									<col width="380" />
								</colgroup>
								<tbody>
									<tr>
										<td class="table-right">
											<p><em class="textMark warnColor">*</em>营业执照副本扫描件：</p>
											<p class="lightColor">（需加盖公司公章）</p>
										</td>
										<td>
											<div class="mod-upload">
												<c:choose>
													<c:when test="${empty(data.btImg)}">
														<img src="${cssUrl}/img/upload_img.jpg" alt="" id="imgBtImg">
													</c:when>
													<c:otherwise>
														<img src="${my:random(imgGetUrl)}?rid=${data.btImg}&op=s2_w97_h97" alt="" id="imgBtImg">
													</c:otherwise>
												</c:choose>													
												<input type="hidden" id="btImg" name="btImg" value="${data.btImg}" data-required="true" data-describedby="btImg_msg" data-description="btImg">
											</div>
											<p class="submit-btn">
												<input type="button" class="btn btn-def" value="上 传" id="btnBtImg">
											</p>
											<div class="note errTxt" id="btImg_msg"></div>												
										</td>
										<td class="table-right">
											<p>示例：</p>
										</td>
										<td>
											<div class="mod-UploadPreview">
												<div class="imgBox"><img width="180" height="129" src="${cssUrl}/img/temp/yingye.png" alt="" class=""></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="table-right">
											<p><em class="textMark warnColor">*</em>组织机构代码电子版：</p>
											<p class="lightColor">（需加盖公司公章）</p>
										</td>
										<td>
											<div class="mod-upload">
												<c:choose>
													<c:when test="${empty(data.orgCodeImg)}">
														<img src="${cssUrl}/img/upload_img.jpg" alt="" id="imgOrgCodeImg">
													</c:when>
													<c:otherwise>
														<img src="${my:random(imgGetUrl)}?rid=${data.orgCodeImg}&op=s2_w97_h97" alt="" id="imgOrgCodeImg">
													</c:otherwise>
												</c:choose>			
												<input type="hidden" id="orgCodeImg" name="orgCodeImg" value="${data.orgCodeImg}" data-required="true" data-describedby="orgCodeImg_msg" data-description="orgCodeImg">											
											</div>
											
											<p class="submit-btn">
												<input type="button" class="btn btn-def" value="上 传" id="btnOrgCodeImg">
											</p>
											<div class="note errTxt" id="orgCodeImg_msg"></div>	
										</td>
										<td class="table-right">
											<p>示例：</p>
										</td>
										<td>
											<div class="mod-UploadPreview">
												<div class="imgBox"><img width="180" height="129" src="${cssUrl}/img/temp/zuzhi.jpg" alt="" class=""></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="table-right">
											<p><em class="textMark warnColor">*</em>税务登记证电子版：</p>
											<p class="lightColor">（需加盖公司公章）</p>
										</td>
										<td>
											<div class="mod-upload">
												<c:choose>
													<c:when test="${empty(data.taxImg)}">
														<img src="${cssUrl}/img/upload_img.jpg" alt="" id="imgTaxImg">
													</c:when>
													<c:otherwise>
														<img src="${my:random(imgGetUrl)}?rid=${data.taxImg}&op=s2_w97_h97" alt="" id="imgTaxImg">
													</c:otherwise>
												</c:choose>		
												<input type="hidden" id="taxImg" name="taxImg" value="${data.taxImg}" data-required="true" data-describedby="taxImg_msg" data-description="taxImg">																							
											</div>
											
											<p class="submit-btn">
												<input type="button" class="btn btn-def" value="上 传" id="btnTaxImg">
											</p>
											<div class="note errTxt" id="taxImg_msg"></div>	
										</td>
										<td class="table-right">
											<p>示例：</p>
										</td>
										<td>
											<div class="mod-UploadPreview">
												<div class="imgBox"><img width="180" height="129" src="${cssUrl}/img/temp/shuiwu.jpg" alt="" class=""></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="table-right">
											<p><em class="textMark warnColor">*</em>银行开户许可证电子版：</p>
											<p class="lightColor">（需加盖公司公章）</p>
										</td>
										<td>
											<div class="mod-upload">
												<c:choose>
													<c:when test="${empty(data.bankLicenseImg)}">
														<img src="${cssUrl}/img/upload_img.jpg" alt="" id="imgBankLicenseImg">
													</c:when>
													<c:otherwise>
														<img src="${my:random(imgGetUrl)}?rid=${data.bankLicenseImg}&op=s2_w97_h97" alt="" id="imgBankLicenseImg">
													</c:otherwise>
												</c:choose>		
												<input type="hidden" id="bankLicenseImg" name="bankLicenseImg" value="${data.bankLicenseImg}" data-required="true" data-describedby="bankLicenseImg_msg" data-description="bankLicenseImg">																							
											</div>
											
											<p class="submit-btn">
												<input type="button" class="btn btn-def" value="上 传" id="btnBankLicenseImg">
											</p>
											<div class="note errTxt" id="bankLicenseImg_msg"></div>											
										</td>
										<td class="table-right">
											<p>示例：</p>
										</td>
										<td>
											<div class="mod-UploadPreview">
												<div class="imgBox"><img width="180" height="129" src="${cssUrl}/img/temp/kaihu.jpg" alt="" class=""></div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</fieldset>
						<fieldset>
							<div class="legend"><h3>联系人信息<span>用于入驻过程中接收入驻通知，请务必正确填写。</span></h3></div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>联系人姓名：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lg" id="bizManName" name="bizManName" value="${data.bizManName}" data-required="true" data-describedby="bizManName_msg" data-description="bizManName" dblength="20">
									<div class="note errTxt" id="bizManName_msg"></div>	
								</div>
								
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>联系人手机号码：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl" id="bizManMobile" name="bizManMobile" value="${data.bizManMobile}" data-required="true" data-describedby="bizManMobile_msg" data-description="bizManMobile" data-pattern="^[1]\d{10}$" maxlength="11">
									<div class="note errTxt" id="bizManMobile_msg"></div>		
								</div>								
							</div>
							<div class="form-item">
								<div class="item-label"><label>联系人固定电话：</label></div>
								<div class="item-cont">
									<div class="txt-tel">
										<input type="text" class="txt lg telArea"  id="telArea" name="telArea" value="${data.telArea}" maxlength="4"><i>-</i><input type="text" class="txt lg telNum" id="telNo" name="telNo" value="${data.telNo}" maxlength="8"><i>-</i><input type="text" class="txt lg telExt" id="telExt" name="telExt" value="${data.telExt}" maxlength="4">
									</div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label>传真号码：</label></div>
								<div class="item-cont">
									<div class="txt-tel">
										<input type="text" class="txt lg telArea" id="faxArea" name="faxArea" value="${data.faxArea}" maxlength="4"><i>-</i><input type="text" class="txt lg telNum" id="faxNo" name="faxNo" value="${data.faxNo}" maxlength="8"><i>-</i><input type="text" class="txt lg telExt" id="faxExt" name="faxExt" value="${data.faxExt}" maxlength="4">
									</div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>电子邮箱：</label></div>
								<div class="item-cont">
									<input type="text" class="txt lg w-lgl" id="bizManEmail" name="bizManEmail" value="${data.bizManEmail}" dblength="100" data-required="true" data-describedby="bizManEmail_msg" data-description="bizManEmail" data-conditional="confirmBizManEmail">
									<div class="note errTxt" id="bizManEmail_msg"></div>	
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label class="hide">入驻协议：</label></div>
								<div class="item-cont"><label><input type="checkbox" class="chk" checked="checked" id="chkProtocol"/>我已阅读并同意<a href="http://css.seller.hehefang.com/deal1.html" target="_blank">《禾合坊商家入驻条款》</a></label>
									<div class="note errTxt" id="protocol_msg"></div>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label class="hide">提交入驻申请：</label></div>
								<div class="item-cont">
									<input type="submit" class="btn btn-primary xl p-xl" value="提交入驻申请" />
									<input type="hidden" name="appId" id="appId" value="${data.appId}" />
								</div>
							</div>
						</fieldset>
					</form>
				</div>
				<!-- joinAplly end -->
			</div>
	
</body>
</html>