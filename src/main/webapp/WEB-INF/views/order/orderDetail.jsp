<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>订单管理-禾合坊</title>
	</head>
	<body>
		<!-- mainCaption -->
		<div class="mainCaption mc-mb">
			<h2>我的订单</h2>
		</div>
		<!-- mainCaption end -->
		<!-- message -->
		<div class="mod-message">
			<c:choose>
				<c:when test="${order.orderStatus=='3'}">
					<div class="hd">
						<h3 class="title">当前订单状态：<span class="warnColor">等待发货</span><input id="send" name="${order.orderId}_${order.brandShowId}" type="button" class="btn btn-primary sm" value="发货" /></h3>
					</div>
					<div class="bd">
						<div class="msg-text"><i class="icon i-horn"></i><b>系统提醒</b>：发货前请与买家确认发货信息及购买信息，确认无误后再执行发货处理。</div>
					</div>
				</c:when>
				<c:when test="${order.orderStatus=='8'}">
				<div class="hd">
					<h3 class="title">当前订单状态：<span class="successColor"><c:out value="${order.strOrderStatus}" /></span></h3>
				</div>
				<div class="bd">
					<div class="msg-text"><i class="icon i-horn"></i><b>系统提醒</b>：交易已成功后，如买家提出售后要求，请积极与买家协商，做好售后服务。</div>
				</div>
				</c:when>
				<c:otherwise>
				<div class="hd">
					<h3 class="title">当前订单状态：<span><c:out value="${order.strOrderStatus}" /></span></h3>
				</div>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- message end -->
		<!-- orderInfo -->
		<div class="mod-orderInfo">
			<div class="item">
				<table class="table table-left noborder">
					<caption>订单信息</caption>
					<colgroup>
						<col width="300">
						<col width="300">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<td>订单编号：${order.orderCode}</td>
							<td>付款方式：<c:out value="${order.strPayMode}" /></td>
							<td>订单来源：<c:out value="${order.strOrderSource}" /></td>
						</tr>
						<tr>
							<td>下单时间：<fmt:formatDate value="${order.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>付款时间：<fmt:formatDate value="${order.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>发货时间：<fmt:formatDate value="${order.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
					</tbody>
				</table>
			</div><!-- item end -->
			<div class="item">
				<table class="table table-left noborder">
					<caption>买家信息</caption>
					<colgroup>
						<col>
					</colgroup>
					<tbody>
						<tr>
							<td>收货地址：<c:out value="${order.rProvince}"/> <c:out value="${order.rCity}"/> <c:out value="${order.rCounty}"/> <c:out value="${order.rTown}"/> <c:out value="${order.rAddr}"/>，    收件人：<c:out value="${order.rName}" />，     联系电话：<c:choose><c:when test="${not empty order.rMobile and not empty order.rPhone}">${order.rMobile}&nbsp;/&nbsp;${order.rPhone}</c:when><c:when test="${not empty order.rMobile}">${order.rMobile}</c:when><c:when test="${not empty order.rPhone}">${order.rPhone}</c:when></c:choose></td> 
						</tr>
					</tbody>
				</table>
			</div><!-- item end -->
		</div>
		<!-- orderInfo end -->
		<!-- table -->
		<table class="table table-line table-order">
			<colgroup>
				<col width="86">
				<col width="300">
				<col width="150">
				<col width="127">
				<col width="113">
				<col width="130">
				<col width="119">
			</colgroup>
			<thead>
				<tr>
					<td colspan="2">商品</td>
					<td>商品编码</td>
					<td>单价</td>
					<td>数量</td>
					<td>优惠</td>
					<td>状态</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty order.orderItems}">
					<c:forEach items="${order.orderItems}" var="orderItem">
						<tr>
							<td>
								<div class="order-img">
									<img src="${my:random(imgGetUrl)}?rid=${orderItem.prodImg}&op=s2_w64_h64" alt="" />
								</div>
							</td>
							<td class="o-product">
								<p><a href="#" target="_blank"><c:out value="${orderItem.prodTitle}" /></a></p>
								<p class="lightColor">
									<c:forEach items="${orderItem.specNames}" var="spec">
										<span><c:out value="${spec.key}" /> : <c:out value="${spec.value}" /></span>
									</c:forEach>
								</p>
							</td>
							<td><c:out value="${orderItem.prodCode}" /></td>
							<td>
								<p>&yen;<fmt:formatNumber value="${orderItem.transPrice}" pattern="0.00" /></p>
							</td>
							<td>${orderItem.number}</td>
							<td><p>&yen;<fmt:formatNumber value="${(orderItem.salePrice - orderItem.transPrice) * orderItem.number}" pattern="0.00" /></p></td>
							<td>
								<p><c:out value="${order.strOrderStatus}" /></p>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="7" class="o-total">订单总额：<strong>&yen;<fmt:formatNumber value="${order.orderFee}" pattern="0.00" /></strong></td>
				</tr>
			</tfoot>
		</table>
		<!-- table edn -->
		<!-- orderInfo -->
		<!-- <div class="mod-orderInfo">
			<div class="item">
				<table class="table table-left noborder">
					<caption>物流信息</caption>
					<colgroup>
						<col width="300">
						<col width="300">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<td>配送方式 ：EMS速递</td>
							<td>运单号码：1500102087387</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>item end
			<div class="item">
				<ul class="deliverInfoList">
					<li>2014-12-03 21:10 上海市|到件|到上海市【浦东分拨中心】</li>
					<li>2014-12-03 21:13 上海市|发件|上海市【浦东分拨中心】，正发往【上海分拨中心】</li>
					<li>2014-12-04 01:15 上海市|到件|到上海市【上海分拨中心】</li>
					<li>2014-12-04 01:18 上海市|发件|上海市【上海分拨中心】，正发往【太原分拨中心】</li>
					<li>2014-12-05 11:15 太原市|到件|到太原市【太原分拨中心】</li>
					<li class="now">2014-12-06 17:06 大同市|签收|大同市【大同云冈路分部】，林子 已签收</li>
				</ul>
			</div>item end
		</div> -->
		<!-- orderInfo end -->
		
		<c:if test="${order.orderStatus=='3'}">
		<!-- popup -->
		<div id="mask"></div>
		<!-- popup end -->
		<script>
			$(function(){
				$("#send").click(function(){
					var idShowId = $(this).attr("name").split("_");  
					var logiComHtml="";
					
					//获取物流公司列表
					if(idShowId.length == 2){
						$.ajax({
							url  : "${ctx}/order/getLogiComs",
							type : "POST",
							async : false,
							data : {showId : idShowId[1]},
							success : function(objList) {
								$.each(objList, function( index, logisCom ) {
									if(index == 0){
										logiComHtml += '<label><input type="radio" name="logis" class="radio" checked="checked" value="'+logisCom.logisticsCompId+'"/>'+logisCom.logisticsCompName+'</label>';
									}else{
										logiComHtml += '<label><input type="radio" name="logis" class="radio" value="'+logisCom.logisticsCompId+'"/>'+logisCom.logisticsCompName+'</label>';
									}
								});
							}
						});
						
						var dialoghtml = '<div id="dialog" class="popup popup-primary popup-deliver" style="width:600px;">'+
								'<div class="hd"><h2>订单发货</h2><i class="close"></i></div>'+
								'<div class="bd">'+
									'<form class="form">'+
										'<fieldset>'+
											'<div class="form-item">'+
												'<div class="item-label"><label><em>*</em>快递公司：</label></div>'+
												'<div class="item-cont">'+logiComHtml+'</div>'+
											'</div>'+
											'<div class="form-item">'+
												'<div class="item-label"><label><em>*</em>运单号：</label></div>'+
												'<div class="item-cont">'+
													'<input id="awbNo" type="text" class="txt lg w-lgl" /><span style="color:#f00;"></span>'+
												'</div>'+
											'</div>'+
											'<div class="form-item">'+
												'<div class="item-cont">'+
													'<input id="sendGoods" type="button" class="btn btn-primary" value="确认发货" />'+
												'</div>'+
											'</div>'+
										'</fieldset>'+
									'</form>'+
								'</div>'+
							'</div>';
						var dialog$ = $(dialoghtml);	
						$(document.body).append(dialog$);
						$("#mask").addClass("mask");
						
						showPop();
						
						dialog$.find(".close").click(function(){
							dialog$.remove();
							$("#mask").removeClass("mask");
						});
						
						var awbNoFlag = false;
						
						dialog$.find("#awbNo").blur(function(){
							var awbNo$ = $(this);
							var awbNo = awbNo$.val();
							if(awbNo.length > 0){
								if(/^\d{12,15}$/.test(awbNo)){  
									awbNoFlag = true;
									awbNo$.next().text("");
								}else{
									awbNo$.next().text("运单号是12-15位数字");
									awbNo$.focus();
								}
							}else{
								awbNo$.next().text("请填写运单号码");
								awbNo$.focus();
							}
						});
						
						dialog$.find("#sendGoods").click(function(){
							var checkedRadio$ = dialog$.find("input[name='logis']:checked");
							var logisId = checkedRadio$.val();  
							var logisName = checkedRadio$.parent().text();  
							var awbNo = dialog$.find("#awbNo").val();
							
							if(awbNoFlag){
								$.ajax({
									url  : "${ctx}/order/send",
									type : "POST",
									sync : false,
									data : {
											orId:idShowId[0], 
											logiId:logisId,
											logiName:logisName,
											awbNo:awbNo
										   },
									success : function(re) {
										//成功
										if(re == 1){
											var content$ = $('<dl class="popup-doc">'+
																'<dt><i class="icon i-right"></i></dt>'+
																'<dd><h3>订单已发货 ！</h3><p>请尽快联系快递公司，安排货物的正常发出，谢谢！</p><div class="btnWrap"><input id="cont" type="button" class="btn btn-primary" value="继续发货" /><input id="view" type="button" class="btn btn-def" value="查看订单" /></div></dd>'+
															'</dl>');
											content$.find("#cont").click(function(){
												window.location.href = '${ctx}/order/sendOrder?m=4002';
											});
											content$.find("#view").click(function(){
												window.location.href = '${ctx}/order/orderDetail?m=4001&orderId='+idShowId[0];
											});
											
											dialog$.removeClass("popup-deliver");
											dialog$.find("h2").text("");
											dialog$.find(".bd").empty().append(content$);
										}else{
											var content$ = $('<dl class="popup-doc">'+
																'<dt><i class="icon i-danger"></i></dt>'+
																'<dd><h3>发货操作异常！</h3>p>请重新尝试，多次尝试失败时请联系平台客服协助解决。</p><div class="btnWrap"><input id="know" type="button" class="btn btn-primary" value="我知道了" /></div></dd>'+
															'</dl>');
											content$.find("#know").click(function(){
												dialog$.remove();
												$("#mask").removeClass("mask");
											});
											
											dialog$.removeClass("popup-deliver");
											dialog$.find("h2").text("");
											dialog$.find(".bd").empty().append(content$);
										}
									}
								});
							}else{
								dialog$.find("#awbNo").trigger("blur");
							}
						});
					}
				});
				
				$(window).resize(function() {
					if ($("#dialog").is(":visible")) {
						showPop();
					}
				});
			});
			
			function showPop() {
				var objP = $("#dialog");
				var windowWidth = document.documentElement.clientWidth;   
				var windowHeight = document.documentElement.clientHeight;   
				var popupHeight = objP.height();   
				var popupWidth = objP.width();    
				 
				objP.css({   
					"position": "absolute",   
					"top": (windowHeight-popupHeight)/2+$(document).scrollTop(),   
					"left": (windowWidth-popupWidth)/2   
				});  
			};
		</script>
		</c:if>
	</body>
</html>



