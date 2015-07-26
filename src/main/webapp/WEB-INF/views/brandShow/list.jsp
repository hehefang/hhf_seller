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

<link rel="stylesheet" href="${cssUrl}/css/product.css" />

<!-- mainCaption -->
<div class="mainCaption mc-mb">
	<h2>专场列表</h2><a href="show?m=3002" class="btn btn-def applyBrand">新建专场</a>
</div>
<!-- mainCaption end -->
<!-- screening -->
<div class="screening">
	<form class="form form-inline" method="post" action="list?m=3001" id="queryForm">
		<legend></legend>
		<div class="formGroup">
			<div class="form-item">
				<div class="item-label">
					<label>创建时间：</label>
				</div>
				<div class="item-cont">
					<div class="txt-section"><input type="text" class="txt txt-date" name="startDt" value="${cond.startDt}" onfocus="WdatePicker()"><i>到</i><input type="text" class="txt txt-date" name="endDt" value="${cond.endDt}" onfocus="WdatePicker()"></div>
				</div>
			</div>
			<div class="form-item">
				<div class="item-label">
					<label>专场名称：</label>
				</div>
				<div class="item-cont">
					<input type="text" class="txt w-lg" name="title" value="${cond.title}"/>
					<input type="submit" class="btn btn-def" value="查&nbsp;&nbsp;询">
				</div>
			</div>
		</div>
	</form>
</div>
<!-- screening end -->
<!-- table -->
<table class="table table-line table-left table-product">
	<colgroup>
		<col width="70">
		<col width="120">
		<col width="210">
		<col width="130">
		<col width="130">
		<col width="130">
		<col width="120">
		<col width="80">
	</colgroup>
	<thead>
		<tr>
			<td>专场ID</td>
			<td>品牌名称</td>
			<td>专场名称</td>
			<td>创建时间</td>
			<td>专场开始时间</td>
			<td>专场结束时间</td>
			<td>状态</td>
			<td class="table-center">操作</td>
		</tr>
	</thead>
	<tbody class="interleave-even">
		<c:forEach items="${brandShowPage.result}" var="brandShow">
			<tr>
			<td><c:out value="${brandShow.brandShowId}" /></td>
			<td><p><c:out value="${brandShow.brandName}" /></p></td>
			<td><c:out value="${brandShow.title}" /></td>
			<td><fmt:formatDate value="${brandShow.createByDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
			<td><fmt:formatDate value="${brandShow.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td><fmt:formatDate value="${brandShow.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td ${brandShow.status == '8' ? 'class="warnColor"' : ''}>
				<c:choose>
					<c:when test="${brandShow.status == '1'}">进行中</c:when>
					<c:when test="${brandShow.status == '2'}">结束</c:when>
					<c:when test="${brandShow.status == '3'}">异常终止</c:when>
					<c:when test="${brandShow.status == '4'}">编辑中</c:when>
					<c:when test="${brandShow.status == '5'}">待审核</c:when>
					<c:when test="${brandShow.status == '6'}">审核中</c:when>
					<c:when test="${brandShow.status == '7'}">等待上线</c:when>
					<c:when test="${brandShow.status == '8'}">驳回<div class="mod-tipsPop tip-lb">
										<i class="icon"></i>
										<div class="tip" style="width:200px"><c:out value="${brandShow.auditContent}"/></div>
									</div>
					</c:when>				
				</c:choose>
			</td>
			<td class="table-center td-operate"><p>
				<c:choose>
					<c:when test="${brandShow.status == '4' || brandShow.status == '8'}">
						<a href="detail?m=3001&brandShowId=${brandShow.brandShowId}">修改专场</a>
					</c:when>
					<c:otherwise>
						<a href="detailView?m=3001&brandShowId=${brandShow.brandShowId}">查看专场</a>
					</c:otherwise>			
				</c:choose>				
			</p></td>
		</tr>
		</c:forEach>		
	</tbody>
</table>
<!-- table edn -->
<!-- paging -->
<c:if test="${fn:length(brandShowPage.result) > 0}">
	<pg:page name="brandShowListPage" page="${brandShowPage}" formId="queryForm"></pg:page>
</c:if>



</body>
</html>