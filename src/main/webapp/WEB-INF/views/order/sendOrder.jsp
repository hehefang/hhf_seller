<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>订单管理-禾合坊</title>
	</head>
	<body>
		<script type="text/javascript" src="${jsDomain}/datePicker/WdatePicker.js?dt=2015021"></script>
		<!-- mainCaption -->
		<div class="mainCaption mc-mb">
			<h2>我的订单</h2>
		</div>
		<!-- mainCaption end -->
		<!-- screening -->
		<div class="screening">
			<form id="queryForm" method="post" action="${ctx}/order/sendOrder?m=4002" class="form form-inline">
				<legend></legend>
				<div class="formGroup">
					<div class="form-item">
						<div class="item-label">
							<label>特卖专场：</label>
						</div>
						<div class="item-cont">
							<select name="brandShowId" id="brandShowId" class="select w-sm">
								<option value="">全部专场</option>
								<c:forEach items="${brandShows}" var="brandShow" varStatus="status">
								<option value="${brandShow.brandShowId}" <c:if test="${brandShow.brandShowId==orderCondition.brandShowId}">selected="selected"</c:if>  ><c:out value="${brandShow.title}"/></option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-item">
						<div class="item-label">
							<label>下单时间：</label>
						</div>
						<div class="item-cont">
							<div class="txt-section">
								<input type="text" readonly="readonly" name="startDate" value="<fmt:formatDate value="${orderCondition.startDate}" pattern="yyyy-MM-dd" />" onClick="WdatePicker()" class="txt txt-date w-sm">
									<i>至</i>
								<input type="text" readonly="readonly" name="endDate" value="<fmt:formatDate value="${orderCondition.endDate}" pattern="yyyy-MM-dd" />" onClick="WdatePicker()" class="txt txt-date w-sm">
							</div>
						</div>
					</div>
					<div class="form-item">
						<div class="item-label">
							<label>订单编号：</label>
						</div>
						<div class="item-cont">
							<input type="text" id="orderCode" name="orderCode" value="${orderCondition.orderCode}" class="txt w-lg">
						</div>
					</div>
				</div>
				<div class="searchBtn"><input name="query" id="query" type="submit" class="btn btn-def" value="查&nbsp;&nbsp;询"></div>
			</form>
		</div>
		<!-- screening end -->
		<div class="mod-tips tips-order"><i class="icon i-horn"></i><b>系统提醒：</b>发货前请与买家确认发货信息及购买信息，确认无误后再执行发货处理。</div>
		<!-- table -->
		<table class="table table-line table-order">
			<colgroup>
				<col width="366">
				<col width="140">
				<col width="107">
				<col width="93">
				<!-- <col width="104"> -->
				<col width="96">
				<col width="119">
			</colgroup>
			<thead>
				<tr>
					<td>商品</td>
					<td>商品编码</td>
					<td>单价</td>
					<td>数量</td>
					<!-- <td>维权 <i class="textMark">/</i> 售后</td> -->
					<td>实付款</td>
					<td>状态</td>
				</tr>
			</thead>
		</table>
		
		<c:choose>
			<c:when test="${page.result!=null && fn:length(page.result)>0}">
				 <c:forEach items="${page.result}" var="order">
					<table class="table table-line table-order">
						<colgroup>
							<!-- <col width="86"> -->
							<col width="280">
							<col width="140">
							<col width="107">
							<col width="93">
							<!-- <col width="104"> -->
							<col width="95">
							<col width="118">
						</colgroup>
						<thead>
							<tr>
								<td colspan="8" class="o-select">
									<span>订单编号：<a href="javascript:void(0);" target="_blank">${order.orderCode}</a></span>
									<span>订单提交时间：<fmt:formatDate value="${order.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									<span>专场ID：<a href="#" target="_blank">${order.brandShowId}</a></span>
								</td>
							</tr>
						</thead>
						<c:if test="${order.orderItems!=null && fn:length(order.orderItems)>0}">
						<tbody>
							<c:forEach items="${order.orderItems}" var="orderItem" varStatus="status">
							<tr>
								<td>
									<div class="order-img">
										<img src="${my:random(imgGetUrl)}?rid=${orderItem.prodImg}&op=s2_w40_h40">
									</div>
								</td>
								<td class="o-product">
									<p><a href="#"><c:out value="${orderItem.prodTitle}" /></a></p>
									<p class="lightColor">
										<c:forEach items="${orderItem.specNames}" var="spec">
											<c:out value="${spec.key}" /> : <c:out value="${spec.value}" />
										</c:forEach>
									</p>
								</td>
								<td>${orderItem.prodCode}</td>
								<td>
									<p><b>&yen;<fmt:formatNumber value="${orderItem.transPrice}" pattern="0.00" /></b></p>
								</td>
								<td>${orderItem.number}</td>
								<!-- <td class="borderL"><p class="warnColor">已退款</p></td> -->
								<c:if test="${status.first}">
									<td rowspan="${fn:length(order.orderItems)}" class="borderL">
										<p><b>&yen;<fmt:formatNumber value="${order.orderFee}" pattern="0.00" /></b></p>
										<p class="lightColor">（免运费）</p>
									</td>
									<td rowspan="${fn:length(order.orderItems)}" class="borderL td-operate">
										<p class="warnColor">等待发货</p>
										<p><a href="${ctx}/order/orderDetail?m=4002&orderId=${order.orderId}">订单详情</a></p>
										<p><input name="send" id="${order.orderId}_${order.brandShowId}" type="button" class="btn btn-primary sm" value="发货" /></p>
									</td>
								</c:if>
							</tr>
							</c:forEach>
						</tbody>
						</c:if>
					</table>
				</c:forEach>
				<pg:page name="orderPage" page="${page}" formId="queryForm"></pg:page>
			</c:when>
			<c:otherwise>
				<table class="table table-line table-order">
						<colgroup>
							<!-- <col width="86"> -->
							<col width="280">
							<col width="140">
							<col width="107">
							<col width="93">
							<!-- <col width="104"> -->
							<col width="95">
							<col width="118">
						</colgroup>
						<tbody>
							<tr class="emptyGoods">
									<td colspan="6" rowspan="3">暂无符合条件的查询结果</td>
							</tr>
						</tbody>
					</table>
			</c:otherwise>
		</c:choose>
		
		<!-- popup -->
		<div id="mask"></div>
		<!-- popup end -->
		
		<script>
			$(function(){
				$("input[name='send']").click(function(){
					var idShowId = $(this).attr("id").split("_");  
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
	</body>
</html>
				
