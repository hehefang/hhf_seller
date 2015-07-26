<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>订单管理-禾合坊</title>
	</head>
	<body>
		<!-- mainCaption -->
		<div class="mainCaption mc-mb">
			<h2>订单退货</h2>
		</div>
		<!-- mainCaption end -->
		<!-- message -->
		<div class="mod-message">
			<div class="hd">
				<h3 class="title">当前订单状态：<span class="warnColor"><c:out value="${returnOrder.sellerStatus}" /></span>
					<c:choose>
						<c:when test="${returnOrder.status=='1'}">
							<input name="agreeReturn" id="${returnOrder.retOrderId}" type="button" class="btn btn-primary sm" value="同意退货" />
						</c:when>
						<c:when test="${returnOrder.status=='2'}">
							<input name="confirm" id="${returnOrder.retOrderId}" type="button" class="btn btn-primary sm" value="确认到货" />
						</c:when>
					</c:choose>
				</h3>
			</div>
			<div class="bd">
				<div class="msg-text"><i class="icon i-horn"></i><b>系统提醒</b>：请与买家沟通并核实退货原因及申请信息后，再执行后续退货服务。</div>
			</div>
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
							<td>退货单号：${returnOrder.retOrderCode}</td>
							<td>退货原因：<c:out value="${returnOrder.returnReason}" /></td>
							<td>申请时间：<fmt:formatDate value="${returnOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
						<tr>
							<td>退货说明：<c:out value="${returnOrder.remarks}" /></td>
						</tr>
						<tr>
							<td colspan="2"><div class="form-item">
									<div class="item-label"><label>退货凭证：</label></div>
									<div class="item-cont">
										<div class="uploadImg">
											<ul>
												<c:forEach items="${returnOrder.evidencePics}" var="pic">
													<li>
														<a href="${my:random(imgGetUrl)}?rid=${pic}" target="_blank"><img src="${my:random(imgGetUrl)}?rid=${pic}&op=s2_w40_h40" ></a>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div><!-- item end -->
			<div class="item">
				<table class="table table-left noborder">
					<caption>退货信息</caption>
					<colgroup>
						<col>
					</colgroup>
					<tbody>
						<tr>
							<td>
							<c:if test="${not empty retAddr}">
								<c:out value="${retAddr.provinceName}"></c:out>
								<c:out value="${retAddr.cityName}"></c:out>
								<c:out value="${retAddr.districtName}"></c:out>
								<c:out value="${retAddr.townName}"></c:out>
								<c:out value="${retAddr.addr}"></c:out>，     收件人：<c:out value="${retAddr.receiver}" />，     手机：
								<c:choose>
									<c:when test="${not empty retAddr.mobile and not empty retAddr.tel}">
										<span>${retAddr.mobile}</span>/<span>${order.tel}</span>
									</c:when>
									<c:when test="${not empty retAddr.mobile}">
										<span>${retAddr.mobile}</span>
									</c:when>
									<c:otherwise>
										<span>${retAddr.tel}</span>
									</c:otherwise>
								</c:choose>
							</c:if>
							</td> 
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
				<col width="110">
				<col width="100">
				<col width="100">
				<col width="100">
				<col width="100">
				<col width="129">
			</colgroup>
			<thead>
				<tr>
					<td colspan="2">商品</td>
					<td>商品编码</td>
					<td>单价</td>
					<td>数量</td>
					<td>交易金额</td>
					<td>退款金额</td>
					<td>状态</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${returnOrder.retOrderItems!=null && fn:length(returnOrder.retOrderItems)>0}">
					<tbody>
						<c:forEach items="${returnOrder.retOrderItems}" var="returnOrderItem">
						<tr>
							<td>
								<div class="order-img">
									<img src="${my:random(imgGetUrl)}?rid=${returnOrderItem.orderItem.prodImg}&op=s2_w40_h40">
								</div>
							</td>
							<td class="o-product">
								<p><a href="javascript:void(0);"><c:out value="${returnOrderItem.orderItem.prodTitle}" /></a></p>
								<p class="lightColor">
									<c:forEach items="${returnOrderItem.orderItem.specNames}" var="spec">
										<span><c:out value="${spec.key}" />：<c:out value="${spec.value}" /></span>
									</c:forEach>
								</p>
							</td>
							<td>${returnOrderItem.orderItem.prodCode}</td>
							<td><b>&yen;<fmt:formatNumber value="${returnOrderItem.orderItem.salePrice}" pattern="0.00" /></b></td>
							<td>${returnOrderItem.returnNumber}</td>
							<td><b>&yen;<fmt:formatNumber value="${returnOrderItem.orderItem.transPrice}" pattern="0.00" /></b></td>
							<td><p class="warnColor"><b>&yen;<fmt:formatNumber value="${returnOrderItem.retFee}" pattern="0.00" /></b></p></td>
							<td>
								<p <c:choose><c:when test="${returnOrder.status=='4'}">class="successColor"</c:when><c:when test="${returnOrder.status=='3'}">class="warnColor"</c:when></c:choose>><c:out value="${returnOrder.sellerStatus}" /> </p>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</c:if>
			</tbody>
		</table>
		<!-- table edn -->
		
		<c:if test="${returnOrder.status=='1' or returnOrder.status=='2'}">
		<!-- popup -->
		<div id="mask"></div>
		<!-- popup end -->
		<script>
			$(function(){
				$(".title input[name]").click(function(){
					var retOrId = $(this).attr("id");  
					var name = $(this).attr("name");
					
					var retOrderStatus = 0;
					
					var succh3,succp,confh3,confp,h2,btnValue;
					if(name == "agreeReturn"){
						retOrderStatus = 2;
						succh3 = "您已同意退货 ！";
						succp = "请等待买家发回退货！";
						confh3 = "确认已与买家沟通，并同意退货？";
						confp = "请与买家详细沟通并核实退货原因及申请信息后，再进行后续退货服务。";
						h2 = "退货确认";
						btnValue = "同意退货";
					}else if(name == "confirm"){
						retOrderStatus = 3;
						succh3 = "您已确认收到买家退回的货品，请等待平台退款！";
						succp = "平台将在3-5个工作日内为买家办理退款，如有疑问，请与平台客服中心联系！";
						h2 = "退货确认";
						confh3 = "请收到退货商品后，再确认收货 ！";
						confp = "在您确认收货后，平台将为买家办理退款事宜如未收到退货请点击“取消”。";
						btnValue = "确认收到退货";
					}
					
					if(retOrId > 0){
						var dialoghtml = '<div id="dialog" class="popup popup-primary" style="width:600px;">'+
								'<div class="hd"><h2>'+h2+'</h2><i class="close"></i></div>'+
								'<div class="bd">'+
									'<dl class="popup-doc">'+
										'<dt><i class="icon i-danger"></i></dt>'+
										'<dd><h3>'+confh3+'</h3><p>'+confp+'</p><div class="btnWrap"><input id="retOrder" type="button" class="btn btn-primary" value="'+btnValue+'" /><input id="cancel" type="button" class="btn btn-def" value="取消" /></div></dd>'+
									'</dl>'+
								'</div>'+
							'</div>';
						var dialog$ = $(dialoghtml);	
						$(document.body).append(dialog$);
						$("#mask").addClass("mask");
						
						showPop();
						
						dialog$.find(".close,#cancel").click(function(){
							dialog$.remove();
							$("#mask").removeClass("mask");
						});
						
						dialog$.find("#retOrder").click(function(){
							$.ajax({
								url  : "${ctx}/order/modRetOrder",
								type : "POST",
								data : {retOrderId:retOrId,status:retOrderStatus},
								success : function(re) {
									//成功
									if(re == 1){
										var content$ = $('<dl class="popup-doc">'+
															'<dt><i class="icon i-right"></i></dt>'+
															'<dd><h3>'+succh3+'</h3><p>'+succp+'</p><div class="btnWrap"><input id="view" type="button" class="btn btn-primary" value="查看退货单" /></div></dd>'+
														'</dl>');
										content$.find("#view").click(function(){
											window.location.href = '${ctx}/order/retOrderDetail?m=${param.m}&retOrderId='+retOrId;
										});
										
										dialog$.find("h2").text("");
										dialog$.find(".bd").empty().append(content$);
									}else if(re == 0){
										var content$ = $('<dl class="popup-doc">'+
															'<dt><i class="icon i-danger"></i></dt>'+
															'<dd><h3>退货确认异常！</h3>p>请重新尝试，多次尝试失败时请联系平台客服协助解决。</p><div class="btnWrap"><input id="know" type="button" class="btn btn-primary" value="我知道了" /></div></dd>'+
														'</dl>');
										content$.find("#know").click(function(){
											dialog$.remove();
											$("#mask").removeClass("mask");
										});
										
										dialog$.find("h2").text("");
										dialog$.find(".bd").empty().append(content$);
									}
								}
							});
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



