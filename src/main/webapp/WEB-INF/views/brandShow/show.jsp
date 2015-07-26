<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>品牌特卖-禾合坊</title>
</head>
<body>

<link rel="stylesheet" href="${cssUrl}/css/special.css" />
<link rel="stylesheet" href="${ctx}/uploadify/uploadify.css?t=20150129" />
<script type="text/javascript">
		var ctx = '${ctx}';
		var imgUploadUrl = '${imgUploadUrl}';
		var imgGetUrl = '${my:random(imgGetUrl)}';
</script>
<script type="text/javascript" src="${ctx}/uploadify/jquery.uploadify.min.js?t=20150129"></script>
<script type="text/javascript" src="${jsUrl}/region.js?t=20150129"></script>
<script type="text/javascript" src="${jsUrl}/brandShow.js?t=20150624"></script>
<style>
		.uploadBtn{
		 	cursor:hand;
			width: 78px;
			height: 26px;
			padding: 0;
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
<div class="mainCaption mc-newSpecial">
	<h2><c:choose>
		<c:when test="${empty(requestScope.brandShow)}">新建专场</c:when>
		<c:otherwise>专场规则</c:otherwise>
	</c:choose></h2>
	<ul class="mod-step">
		<li class="now">
			<i class="disc">1</i>
			<span class="strip"></span>
			<p class="text">填写专场规则</p>
		</li>
		<li class="">
			<i class="disc">2</i>
			<span class="strip"></span>
			<p class="text">专场商品设置</p>
		</li>
		<li class="last">
			<i class="disc"></i>
			<span class="strip"></span>
			<p class="text">等待审核</p>
		</li>
	</ul>
</div>
<!-- mainCaption end -->
<div class="section">
	<!-- form -->
	<form class="form form-special" action="saveShow" method="post" id="frm">
		<fieldset>
			<div class="legend"><h3>填写专场信息<a href="#">专场发布规则</a></h3></div>
			<div class="form-item">
				<div class="item-label"><label><em>*</em>选择品牌：</label></div>
				<div class="item-cont">
					<select name="brandId" id="brandId" class="select" data-describedby="brandId_msg" data-required="true" data-description="brandId">
						<option value="">请选择品牌</option>
						<c:forEach items="${requestScope.brandList}" var="brand">
							<option value="${brand.brandId}" ${brandShow.brandId == brand.brandId ? 'selected="selected"' : ''}><c:out value="${brand.showName}"/></option>
						</c:forEach>						
					</select>
					<span class="note">只可选择已审核通过的品牌</span>&nbsp;&nbsp;<a href="${ctx}/product/brandPage?m=2004">申请新品牌</a>
					<div class="note errTxt" id="brandId_msg"></div>
				</div>
			</div>
			<div class="form-item">
				<div class="item-label"><label><em>*</em>专场名称：</label></div>
				<div class="item-cont">
					<input type="text" class="txt lg w-xl" id="title" name="title" value="${fn:escapeXml(brandShow.title)}" maxlength="50" autocomplete="off"
						data-describedby="title_msg" data-required="true" data-description="title" data-pattern="\S"/>
					<div class="note errTxt" id="title_msg"></div>
				</div>
			</div>
			<div class="form-item">
				<div class="item-label"><label><em>*</em>专场页Banner：</label></div>
				<div class="item-cont">
					<input type="button" class="btn btn-def" value="上传图片" id="btnShowBannerImg"/>
					<input type="hidden" id="showBannerImg" name="showBannerImg" value="${brandShow.showBannerImg}" data-required="true" data-describedby="showBannerImg_msg" data-description="showBannerImg">
					<span class="note">图片大小必须为：1920px*400px，图片格式为：png/jpg/jpeg</span>&nbsp;&nbsp;
					<div class="item-preview preview1"><c:choose>
						<c:when test="${empty(brandShow.showBannerImg)}"><img src="${cssUrl}/img/prve1.jpg" alt="" id="imgShowBannerImg"/>	</c:when>
						<c:otherwise><img src="${my:random(imgGetUrl)}?rid=${brandShow.showBannerImg}&op=s2_w576_h111" alt="" id="imgShowBannerImg"/></c:otherwise>
					</c:choose>		
					</div>			
					<div class="note errTxt" id="showBannerImg_msg"></div>				
				</div>
			</div>
			<div class="form-item">
				<div class="item-label"><label><em>*</em>首页Banner：</label></div>
				<div class="item-cont">
					<input type="button" class="btn btn-def" value="上传图片" id="btnHomeBannerImg"/>
					<input type="hidden" id="homeBannerImg" name="homeBannerImg" value="${brandShow.homeBannerImg}" data-required="true" data-describedby="homeBannerImg_msg" data-description="homeBannerImg">
					<span class="note">建议选用专场页Banner缩略图，图片大小为：468*240px，图片格式为：png/jpg/jpeg</span>&nbsp;&nbsp;
					<div class="item-preview preview2"><c:choose>					
						<c:when test="${empty(brandShow.homeBannerImg)}"><img src="${cssUrl}/img/prve2.jpg" alt="" id="imgHomeBannerImg" />	</c:when>
						<c:otherwise><img src="${my:random(imgGetUrl)}?rid=${brandShow.homeBannerImg}&op=s2_w220_h219" alt="" id="imgHomeBannerImg"/></c:otherwise>
						</c:choose></div>
					<div class="note errTxt" id="homeBannerImg_msg"></div>	
				</div>
			</div>
			<div class="form-item">
				<div class="item-label"><label><em>*</em>专场页背景色：</label></div>
				<div class="item-cont">
					<input type="text" class="txt lg" name="bgColor" id="bgColor" maxlength="6" value="${brandShow.bgColor}"
						data-required="true" data-describedby="bgColor_msg" data-description="bgColor" data-conditional="confirmBgColor"/>
					<span class="note">十六进制颜色值，请向banner图设计者索取该色值</span>
					<div class="note errTxt" id="bgColor_msg"></div>	
				</div>				
			</div>
		</fieldset>
		<fieldset>
			<div class="legend"><h3>服务信息</h3></div>
			<div class="form-item item-address">
				<div class="item-label"><label><em>*</em>专场退货地址：</label></div>
				<div class="item-cont">
					<c:forEach items="${retAddrList}" var="retAddr">
						<label><input type="radio" class="radio" name="sRAId" value="${retAddr.sRAId}" ${retAddr.sRAId == brandShow.sRAId ? 'checked="checked"' : ''}/>
							<c:out value="${retAddr.provinceName}"/><c:out value="${retAddr.cityName}"/><c:out value="${retAddr.districtName}"/><c:out value="${retAddr.townName}"/>
							<c:out value="${retAddr.addr}"/>
							<span>（<c:out value="${retAddr.zipCode}"/>）</span>
							<span><c:out value="${retAddr.receiver}"/></span>
							<span><c:out value="${retAddr.mobile}"/></span>
						</label>						
					</c:forEach>	
					<div class="note errTxt" id="sRAId_msg"></div>				
				</div>
			</div>
			<div class="form-item">
				<div class="item-label"><label><em>*</em>客服QQ：</label></div>
				<div class="item-cont">
					<div class="itemGroup"><input type="text" class="txt lg w-lg" maxlength="11" name="serviceQqs" value="${brandShow.serviceQqs[0]}"/><span class="note">最多可添加5个客服QQ</span></div>
					<div class="itemGroup"><input type="text" class="txt lg w-lg" maxlength="11" name="serviceQqs" value="${brandShow.serviceQqs[1]}"/></div>
					<div class="itemGroup"><input type="text" class="txt lg w-lg" maxlength="11" name="serviceQqs" value="${brandShow.serviceQqs[2]}"/></div>
					<div class="itemGroup"><input type="text" class="txt lg w-lg" maxlength="11" name="serviceQqs" value="${brandShow.serviceQqs[3]}"/></div>
					<div class="itemGroup"><input type="text" class="txt lg w-lg" maxlength="11" name="serviceQqs" value="${brandShow.serviceQqs[4]}"/></div>
					<div class="note errTxt" id="serviceQqs_msg"></div>	
				</div>
			</div>
			<div class="form-item">
				<div class="item-label"><label><em>*</em>客服电话：</label></div>
				<div class="item-cont">
					<div class="itemGroup"><input type="text" class="txt lg w-lg" name="serviceTels" value="${brandShow.serviceTels[0]}" maxlength="18"/></div>
					<div class="itemGroup"><input type="text" class="txt lg w-lg" name="serviceTels" value="${brandShow.serviceTels[1]}" maxlength="18"/></div>
					<div class="note errTxt" id="serviceTels_msg"></div>	
				</div>
			</div>
			<div class="form-item">
				<div class="item-label"><label><em>*</em>发货城市：</label></div>
				<div class="item-cont">
					<select name="deliverProvince" id="deliverProvince" class="select" initValue="${brandShow.deliverProvince}" data-required="true" data-describedby="deliver_msg" data-description="deliverProvince">
						<option value="">省份</option>
					</select>
					<select name="deliverCity" id="deliverCity" class="select" initValue="${brandShow.deliverCity}" data-required="true" data-describedby="deliver_msg" data-description="deliverCity">
						<option value="">城市</option>
					</select>
					<div class="note errTxt" id="deliver_msg"></div>
				</div>
			</div>
			<div class="form-item item-express">
				<div class="item-label"><label><em>*</em>快递公司：</label></div>
				<div class="item-cont">
					<c:forEach items="${lcList}" var="lc">
						<label><input type="checkbox" class="chk" name="logisticsCompId" value="${lc.logisticsCompId}" ${my:inArray(brandShow.logisticsCompId, lc.logisticsCompId) ? 'checked="checked"' : ''}/><c:out value="${lc.logisticsCompName}"/></label>
					</c:forEach>
					<div class="note">用于订单发货时可选的快递公司</div> 
					<div class="note errTxt" id="logisticsCompId_msg"></div>
				</div>
			</div>
			<div class="form-item">
				<div class="item-cont">
					<input type="hidden" name="brandShowId" value="${brandShow.brandShowId}">
					<input type="submit" value="保 存" class="btn btn-primary lg p-xl" name="next">
					<input type="button" value="取 消" onclick="javascript:self.location.href='list?m=3001';" class="btn btn-def lg p-lg">
				</div>
			</div>
		</fieldset>
	</form>
<!-- form end -->
</div>


</body>
</html>