<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/common/common.jsp"%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>品牌管理-禾合坊</title>
</head>
<body>
	<link rel="stylesheet" href="${cssUrl}/css/product.css?t=20150129" />
	<!-- mainCaption -->
	<div class="mainCaption mc-mb">
		<h2>品牌列表</h2><a href="${ctx}/product/brandPage?m=2004" class="btn btn-def applyBrand">申请新品牌</a>
	</div>
	<!-- mainCaption end -->
	<!-- table -->
	<table class="table table-line table-left table-product">
		<colgroup>
			<col width="100">
			<col width="110">
			<col width="384">
			<col width="140">
			<col width="86">
			<col width="100">
			<col width="100">
		</colgroup>
		<thead>
			<tr>
				<td>品牌LOGO</td>
				<td>品牌名称</td>
				<td>品牌描述</td>
				<td>分类</td>
				<td>申请时间</td>
				<td>状态</td>
				<td>操作</td>
			</tr>
		</thead>
		<tbody class="interleave-even">
			<c:if test="${empty(brands)}">
				<tr><td colspan="7">目前暂无可用品牌！</td></tr>
			</c:if>
			
			<c:forEach items="${brands}" var="brand">
				<tr>
					<td>
						<div class="brand-img">
							<img src="${my:random(imgGetUrl)}?rid=${brand.logoUrl}&op=s2_w80_h80" alt="" />
						</div>
					</td>
					<td><c:out value="${brand.showName}"/></td>
					<td><p><c:out value="${brand.brandAbbr}"/></p></td>
					<td><c:out value="${brand.categories}"/></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${brand.submitDate}" /> </td>
					<td>
						<c:choose>
							<c:when test="${brand.status == '1'}">正常</c:when>
							<c:when test="${brand.status == '2'}">待审核</c:when>
							<c:when test="${brand.status == '3'}">驳回</c:when>
						</c:choose>
					</td>
					<td class="td-operate"><c:if test="${brand.status == '3'}"><p><a href="${ctx}/product/brandPage?sellerBrandId=${brand.sellerBrandId}&m=2004">修改</a></p></c:if>
					</td>
				</tr>
			</c:forEach>				
		</tbody>
	</table>
	<!-- table edn -->
	
</body>
</html>