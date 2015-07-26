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
			<h2>订单退货</h2>
		</div>
		<!-- mainCaption end -->
		<!-- screening -->
		<div class="screening">
			<form id="queryForm" method="post" action="${ctx}/order/returnOrder" class="form form-inline">
				<input type="hidden" name="m" value="${param.m}"/>
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
								<option value="${brandShow.brandShowId}" <c:if test="${brandShow.brandShowId==brandShowId}">selected="selected"</c:if>  ><c:out value="${brandShow.title}"/></option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-item">
						<div class="item-label">
							<label>退货时间：</label>
						</div>
						<div class="item-cont">
							<div class="txt-section">
								<input type="text" readonly="readonly" name="startDate" value="<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd" />" onClick="WdatePicker()" class="txt txt-date w-sm">
									<i>至</i>
								<input type="text" readonly="readonly" name="endDate" value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" />" onClick="WdatePicker()" class="txt txt-date w-sm">
							</div>
						</div>
					</div>
					<div class="form-item">
						<div class="item-label">
							<label>退货单号：</label>
						</div>
						<div class="item-cont">
							<input type="text" id="retOrderCode" name="retOrderCode" value="${param.retOrderCode}" class="txt w-lg">
						</div>
					</div>
				</div>
				<div class="searchBtn"><input name="query" id="query" type="submit"  class="btn btn-def" value="查&nbsp;&nbsp;询"></div>
			</form>
		</div>
		<!-- screening end -->
		<!-- table -->
		<table class="table table-line table-order">
			<colgroup>
				<col width="386">
				<col width="150">
				<col width="127">
				<col width="113">
				<col width="130">
				<col width="119">
			</colgroup>
			<thead>
				<tr>
					<td>商品</td>
					<td>商品编码</td>
					<td>交易金额</td>
					<td>退款金额</td>
					<td>状态</td>
					<td>操作</td>
				</tr>
			</thead>
		</table>
		<c:choose>
			<c:when test="${page.result!=null && fn:length(page.result)>0}">
				 <c:forEach items="${page.result}" var="returnOrder">
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
								<td colspan="7" class="o-select">
									<span>退货单号：<a href="javascript:void(0);" target="_blank">${returnOrder.retOrderCode}</a></span>
									<span>退货时间：<fmt:formatDate value="${returnOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									<span>专场ID：<a href="javascript:void(0);" target="_blank">${returnOrder.brandShowId}</a></span>
								</td>
							</tr>
						</thead>
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
											<c:out value="${spec.key}" /> : <c:out value="${spec.value}" />
										</c:forEach>
									</p>
								</td>
								<td>${returnOrderItem.orderItem.prodCode}</td>
								<td>
									<p><b>&yen;<fmt:formatNumber value="${returnOrderItem.orderItem.transPrice}" pattern="0.00" /></b></p>
								</td>
								<td><p class="warnColor"><b>&yen;<fmt:formatNumber value="${returnOrderItem.retFee}" pattern="0.00" /></b></p></td>
								<td>
								<p <c:choose><c:when test="${returnOrder.status=='4'}">class="successColor"</c:when><c:when test="${returnOrder.status=='3'}">class="warnColor"</c:when></c:choose>><c:out value="${returnOrder.sellerStatus}" /> </p>
								</td>
								<td class="td-operate">
									<p><a href="${ctx}/order/retOrderDetail?m=${param.m}&retOrderId=${returnOrder.retOrderId}">查看详情</a></p>
									<c:choose>
										<c:when test="${returnOrder.status=='1'}">
											<p><input name="agreeReturn" id="${returnOrder.retOrderId}" type="button" class="btn btn-primary sm" value="同意退货" /></p>
										</c:when>
										<c:when test="${returnOrder.status=='2'}">
											<p><input name="confirm" id="${returnOrder.retOrderId}" type="button" class="btn btn-primary sm" value="确认到货" /></p>
										</c:when>
									</c:choose>
								</td>
							</tr>
							</c:forEach>
						</tbody>
						</c:if>
					</table>
				</c:forEach>
				<pg:page name="retOrderPage" page="${page}" formId="queryForm"></pg:page>
			</c:when>
			<c:otherwise>
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
						<tbody>
							<tr class="emptyGoods">
								<td colspan="7" rowspan="3">暂无符合条件的查询结果</td>
							</tr>
						</tbody>
					</table>
			</c:otherwise>
		</c:choose>
		
		<!-- popup -->
		<div id="mask" class=""></div>
		<!-- popup end -->
		
		<script>
			$(function(){
				$(".td-operate input[name]").click(function(){
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
	</body>
</html>
				
