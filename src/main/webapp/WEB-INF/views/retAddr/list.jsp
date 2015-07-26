<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>订单管理-禾合坊</title>
	</head>
	<body>
		<link rel="stylesheet" type="text/css" href="${cssUrl}/css/helper.css"/>
		<!-- mainCaption -->
		<div class="mainCaption">
			<h2>退货地址</h2>
		</div>
		<!-- mainCaption end -->
		<div class="section">
			<!-- form -->
			<form class="form form-helper">
				<fieldset>
					<div class="legend"><h3>已创建的退货地址</h3></div>
					<table class="table table-line table-full">
						<colgroup>
							<col width="90">
							<col width="150">
							<col width="270">
							<col width="70">
							<col width="100">
							<col width="120">
							<col width="160">
						</colgroup>
						<thead>
							<tr>
								<th>收货人</th>
								<th>所在地区</th>
								<th>详细地址</th>
								<th>邮编</th>
								<th>手机号码</th>
								<th>固定电话</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${retAddrList!=null && fn:length(retAddrList)>0}">
								<c:forEach items="${retAddrList}" var="retAddr">
								<tr>
									<td><c:out value="${retAddr.receiver}" /></td>
									<td>
										<c:out value="${retAddr.provinceName}"></c:out>
										<c:out value="${retAddr.cityName}"></c:out>
										<c:out value="${retAddr.districtName}"></c:out>
									</td>
									<td class="table-left"><c:out value="${retAddr.addr}"></c:out></td>
									<td><c:out value="${retAddr.zipCode}"></c:out></td>
									<td>${retAddr.mobile}</td>
									<td>${retAddr.tel}</td>
									<td id="${retAddr.sRAId}" class="td-operate">
										<p>
										<c:choose>
											<c:when test="${retAddr.isDefault}"><span id="defaut" >默认</span></c:when>
											<c:otherwise><a href="javascript:void(0);">设为默认</a></c:otherwise>
										</c:choose>
										|<a href="javascript:void(0);">编辑</a>|<a href="javascript:void(0);">删除</a>
										</p>
									</td>
								</tr>
								</c:forEach>
				 			</c:if>
						</tbody>
					</table>
				</fieldset>
				<fieldset>
					<input name="sRAId" id="sRAId" type="hidden">
					
					<div class="legend"><h3>新增退货地址</h3></div>
					<div class="form-item">
						<div class="item-label"><label><em>*</em>所在地区：</label></div>
						<div class="item-cont">
							<select id="province" class="select"></select>
							<select id="city" class="select"></select>
							<select id="district" class="select"></select>
							<span id="sel" class="errTxt"></span>
						</div>
					</div>
					<div class="form-item">
						<div class="item-label"><label><em>*</em>收件地址：</label></div>
						<div class="item-cont">
							<input id="addr" type="text" class="txt lg w-xl" maxlength="50"/>
						</div>
					</div>
					<div class="form-item">
						<div class="item-label"><label>邮编：</label></div>
						<div class="item-cont">
							<input id="zipCode" type="text" class="txt lg" maxlength="6"/>
							<span class="errTxt"></span>
						</div>
					</div>
					<div class="form-item">
						<div class="item-label"><label><em>*</em>联系人姓名：</label></div>
						<div class="item-cont">
							<input id="receiver" type="text" class="txt lg w-lgl" maxlength="15" />
						</div>
					</div>
					<div class="form-item">
						<div class="item-label"><label><em>*</em>手机号码：</label></div>
						<div class="item-cont">
							<input id="mobile" type="text" class="txt lg w-lgl" maxlength="11"/>
							<span class="errTxt"></span>
						</div>
					</div>
					<div class="form-item">
						<div class="item-label"><label>固定电话：</label></div>
						<div class="item-cont">
							<div class="txt-tel">
								<input id="telArea" type="text" class="txt lg telArea"><i>-</i><input id="telNum" type="text" class="txt lg telNum"><i>-</i><input id="telExt" type="text" class="txt lg telExt">
							</div>
							<span class="note">手机号码和固定电话可任填一项</span>
						</div>
					</div>
					<div class="form-item">
						<div class="item-cont">
							<label><input name="isDefault" id="isDefault" type="checkbox" class="chk">设为默认</label>
						</div>
					</div>
					<div class="form-item">
						<div class="item-label hide"><label>提交审核：</label></div>
						<div class="item-cont">
							<input id="save" type="button" value="保 存" class="btn btn-primary lg p-xl">
						</div>
					</div>
				</fieldset>
			</form>
		<!-- form end -->
		</div>
		
		<script>
			function getGeo(pId, elemId){
				$("#sel").text("");
				
				if(elemId == "city"){
					$("#district").empty().append('<option value="-1">请选择</option>');
				}
				$("#"+elemId).empty().append('<option value="-1">请选择</option>');
				
				if(pId >= 0){
					$.ajax({
						url  : "${ctx}/ajax/geoList",
						type : "GET",
						async: false,
						data : {fId : pId},
						success : function(geoList) {
							$.each(geoList, function( index, geo ) {
								$("#"+elemId).append('<option value="'+geo.geoId+'">'+geo.geoName+'</option>');
							});
						}
					});
				}
			}
		
			function initGeo(){
				getGeo(0, "province");
				
				$("#province, #city").change(function(){
					var id = $(this).val();
				
					if($(this).attr("id") == "province"){
						getGeo(id, "city");
					}else if($(this).attr("id") == "city"){
						getGeo(id, "district");
					}
				});
				
				$("#district").change(function(){
					$("#sel").text("");
				});
			}
			
			$(function(){
				initGeo();
				
				$(".td-operate a").on("click", function(){
					var this$ = $(this);
					
					var sRAId = this$.parent().parent().attr("id");
					var cont = this$.text();
					 
					if(cont == "设为默认"){
						$.ajax({
							url  : "${ctx}/helper/setDefalut",
							type : "POST",
							data : {sRAId : sRAId},
							success : function(re) {
								if(re == 1){
									$("#defaut").replaceWith( '<a href="javascript:void(0);">设为默认</a>');
									this$.replaceWith( '<span id="defaut" >默认</span>');
								}
							}
						});
					}else if(cont == "编辑"){
						$.ajax({
							url  : "${ctx}/helper/getRetAddr",
							type : "POST",
							data : {sRAId : sRAId},
							success : function(retAddr) {
								if(retAddr){
									$("#sRAId").val(sRAId);
									$("#province").val(retAddr.province).trigger("change");
									$("#city").val(retAddr.city).trigger("change");
									$("#district").val(retAddr.district);
									
									$("#addr").val(retAddr.addr);
									$("#receiver").val(retAddr.receiver);
									$("#zipCode").val(retAddr.zipCode);
									$("#mobile").val(retAddr.mobile);
									$("#isDefault").attr("checked", retAddr.isDefault);
									
									if(retAddr.tel){
										var tel = retAddr.tel.split("-");
										if(tel.length == 2){
											$("#telArea").val(tel[0]);
											$("#telNum").val(tel[1]);
										}else if(tel.length == 3){
											$("#telArea").val(tel[0]);
											$("#telNum").val(tel[1]);
											$("#telExt").val(tel[2]);
										}
									}else{
										$("#telArea,#telNum,#telExt").val("");
									}
								}
							}
						});
					}else if(cont == "删除"){
						$.ajax({
							url  : "${ctx}/helper/delRetAdress",
							type : "POST",
							data : {sRAId : sRAId},
							success : function(re) {
								if(re == 1){
									window.location.href = "${ctx}/helper/retAddrlist?m=${param.m}";
								}
							}
						});
					}
				});
				
				$("#zipCode").blur(function(){
					var zipCode = $.trim($(this).val());
					if(zipCode.length>0 && !/^\d{6}$/.exec(zipCode)){
						$(this).next().text("编码须为６位数字");
						$(this).focus();
					}else{
						$(this).next().text("");
					}
				});
				
				$("#mobile").blur(function(){
					var mobile = $.trim($("#mobile").val());
					if(mobile.length>0 && !/^1\d{10}$/.exec(mobile)){
						$(this).next().text("手机号须为1开头的11位数字");
						$(this).focus();
					}else{
						$(this).next().text("");
					}
				});
				
				$("#save").click(function(){
					var provinceId = $("#province").val();
					var provinceName;
					if(provinceId > 0){
						provinceName = $("#province").find("option:selected").text();
					}else{
						$("#sel").text("请选择省份");
						return;
					}
					
					var cityId = $("#city").val();
					var cityName;
					if(cityId > 0){
						cityName = $("#city").find("option:selected").text();
					}else{
						$("#sel").text("请选择城市");
						return;
					}
					
					var districtId = $("#district").val();
					var districtName;
					if(districtId > 0){
						districtName = $("#district").find("option:selected").text();
					}else{
						$("#sel").text("请选择地区");
						return;
					}
					
					var addr = $("#addr").val();
					if(addr.trim().length ==  0){
						return;
					}
					
					var zipCode = $.trim($("#zipCode").val());
					if(zipCode.length>0 && !/^\d{6}$/.exec(zipCode)){
						return;
					}
					
					var receiver = $.trim($("#receiver").val());
					if(receiver.length ==  0){
						return;
					}
					
					var mobileFlag = false;
					
					var mobile = $.trim($("#mobile").val());
					if(mobile.length>0 && /^1\d{10}$/.exec(mobile)){
						mobileFlag = true;
					}
					
					var tel;
					var telFlag = false;
					
					var telArea = $.trim($("#telArea").val());
					var telNum = $.trim($("#telNum").val());
					var telExt = $.trim($("#telExt").val());
					
					if(telArea.length>0 && /^\d{3,4}$/.exec(telArea) && 
							telNum.length>0 && /^\d{7,8}$/.exec(telNum) &&
							(telExt.length==0 || telExt.length>0 && /^\d{1,8}$/.exec(telExt))){
						tel = telArea+"-"+telNum;
						
						if(telExt.length > 0){
							tel += "-"+telExt;
						}
						telFlag = true;
					}
					
					if(!(mobileFlag || telFlag)){
						return;
					}
					
					var sRAId = $("#sRAId").val();
					var isDefault = $("#isDefault").prop("checked");
					$.ajax({
						url  : "${ctx}/helper/saveRetAddr",
						type : "POST",
						data : {sRAId : sRAId,
								province	 : provinceId,
								provinceName : provinceName,
								city	 : cityId,
								cityName : cityName,
								district	 : districtId,
								districtName : districtName,
								addr	: addr,
								zipCode : zipCode, 
								receiver : receiver, 
								mobile : mobile, 
								tel : tel, 
								isDefault : isDefault
								},
						success : function(re) {
							if(re == 1){
								window.location.href = "${ctx}/helper/retAddrlist?m=${param.m}";
							}
						}
					});
				}); 
				
			});
		</script>
	</body>
</html>
				
