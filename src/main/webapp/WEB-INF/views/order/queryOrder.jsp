<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>订单管理-禾合坊</title>
	</head>
	<body>
		<script type="text/javascript" src="${jsDomain}/datePicker/WdatePicker.js?dt=2015021"></script>
		<script>
			$(function(){
				$("#query").click(function(){
					var orderId = $("#orderCode").val();
					if(!!orderId){
						if(!/^\d+$/.exec(orderId)){
							tipsWindown("提示信息","issue:订单编号必须是数字型！","","1");
							$("#orderCode").select();
							return;
						}
					}
					$("#queryForm").submit();
				}); 
				
			});
		</script>
		<!-- mainCaption -->
		<div class="mainCaption mc-mb">
			<h2>我的订单</h2>
		</div>
		<!-- mainCaption end -->
		<!-- screening -->
		<div class="screening">
			<form id="queryForm" method="post" action="${ctx}/order/queryOrder?m=4001" class="form form-inline">
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
					<div class="form-item">
						<div class="item-label">
							<label>状态：</label>
						</div>
						<div class="item-cont">
							<select name="orderStatus" id="orderStatus" class="select w-sm">
								<option value="">全部状态</option>
			            		<option <c:if test="${orderCondition.orderStatus == '2'}">selected="selected"</c:if> value="2">等待付款</option>
			            		<option <c:if test="${orderCondition.orderStatus == '3'}">selected="selected"</c:if> value="3">买家已付款</option>
			            		<option <c:if test="${orderCondition.orderStatus == '4'}">selected="selected"</c:if> value="4">交易取消</option>
			            		<option <c:if test="${orderCondition.orderStatus == '5'}">selected="selected"</c:if> value="5">商家已发货</option>
			            		<option <c:if test="${orderCondition.orderStatus == '8'}">selected="selected"</c:if> value="8">交易完成</option>
							</select>
						</div>
					</div>
				</div>
				<div class="searchBtn"><input name="query" id="query" type="button" class="btn btn-def" value="查&nbsp;&nbsp;询"></div>
			</form>
		</div>
		<!-- screening end -->
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
							<col width="86">
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
									<span>订单编号：<a href="${ctx}/order/orderDetail?m=4001&orderId=${order.orderId}" target="_blank">${order.orderCode}</a></span>
									<span>订单提交时间：<fmt:formatDate value="${order.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									<span>专场ID：<a href="${ctx}/brandShow/detailView?m=3001&brandShowId=${order.brandShowId}" target="_blank">${order.brandShowId}</a></span>
								</td>
							</tr>
						</thead>
						<c:if test="${order.orderItems!=null && fn:length(order.orderItems)>0}">
						<tbody>
							<c:forEach items="${order.orderItems}" var="orderItem" varStatus="status">
							<tr>
								<td>
									<div class="order-img">
										<img src="${my:random(imgGetUrl)}?rid=${orderItem.prodImg}&op=s2_w64_h64">
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
										<p <c:choose><c:when test="${order.orderStatus=='3'}">class="warnColor"</c:when><c:when test="${order.orderStatus=='8'}">class="successColor"</c:when></c:choose>><c:out value="${order.strOrderStatus}" /></p>
										<p><a href="${ctx}/order/orderDetail?m=4001&orderId=${order.orderId}">订单详情</a></p>
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
							<col width="86">
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
								<td colspan="7" rowspan="3">暂无符合条件的查询结果</td>
							</tr>
						</tbody>
					</table>
			</c:otherwise>
		</c:choose>
	</body>
</html>
				
