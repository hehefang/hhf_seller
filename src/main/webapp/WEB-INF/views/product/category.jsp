<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>卖家|发布商品-添加类目</title>
</head>
<body>
	<link rel="stylesheet" href="${cssUrl}/css/product.css" />
	<div class="wrapper product">
		<!-- container -->
		<div id="container">
			<!-- main -->
			<div id="main">
				<!-- mainCaption -->
				<div class="mainCaption">
					<h2>发布新商品</h2>
				</div>
				<!-- mainCaption end -->
				<!-- addCategory -->
				<div class="addCategory">
					<form class="form">
						<fieldset>
							<div class="legend">选择一个类目添加商品</div>
							<div class="formGroup categoryList">
								<div class="cl-item">
									<ul id="first_list">
							 		<c:forEach items="${bcList }" var="bc">
										<li onclick="product.loadBcCategory('#second_list',${bc.bcId});"><span>&gt;</span><c:out value="${bc.bcName }"></c:out> </li>
									</c:forEach>
									</ul>
								</div>
								<div class="cl-item">
									<ul id="second_list">
									</ul>
								</div>
								<div class="cl-item">
									<ul id="third_list">
									</ul>
								</div>
							</div>
							<div class="formGroup">
								<div class="mod-tips">
									<p><b>您当前选的类目是：</b><span id='fc' ></span></p>
								</div>
							</div>
							<div class="btnWrap">
								<input type="hidden" name="bcId" value="" >
								<input type="button" id="publishBtn" value="我选好了，去发布商品" class="btn btn-primary lg p-lg" >
							</div>
						</fieldset>
					</form>
				</div>
				<!-- addCategory end  -->
			</div>
			<!-- main end -->
		</div>
		<!-- container end -->
	</div>
<script type="text/javascript" src="${jsUrl}/popWindown.js?t=20150210"></script>	
<script type="text/javascript" src="${jsUrl}/product.js?t=20150210"></script>	
<script type="text/javascript">
$(function(){
	product = new product();
	
	product.loadBcCategory('#first_list',0);
	
	$(document).on("click", "#first_list > li", function() {
		sel$ = $(this);
		$('#first_list > li').removeClass('curr');
		sel$.addClass('curr');
		$('#fc').nextAll().empty();		
		$("<i>"+sel$.text()+"</i><span id='sc'>&gt;</span>").insertAfter("#fc");
		product.loadBcCategory('#second_list',sel$.attr('id'));
		$('input[name="bcId"]').val('');
	});
	
	$(document).on("click", "#second_list > li", function() {
		sel$ = $(this);
		$('#second_list > li').removeClass('curr');
		sel$.addClass('curr');
		$('#sc').nextAll().empty();
		$("<i>"+sel$.text()+"</i><span id='tc'>&gt;</span>").insertAfter("#sc");
		product.loadBcCategory('#third_list',sel$.attr('id'));
		$('input[name="bcId"]').val('');
	});
	
	$(document).on("click", "#third_list > li", function() {
		sel$ = $(this);
		$('#third_list > li').removeClass('curr');
		sel$.addClass('curr');
		$('#tc').nextAll().empty();
		$("<i>"+sel$.text()+"</i>").insertAfter("#tc");
		$('input[name="bcId"]').val(sel$.attr('id'));
	
	});
	
	$(document).on("click", "#publishBtn", function() {
		bcId = $('input[name="bcId"]').val();
		if(bcId > 0){
			window.location.href = "${ctx}/product/publish?bcId="+bcId+"&m=2001";
		}else{
			popWindown("商品类目必选 ！","issue:发布新商品，类目必须选到第三级 ！","","1");

		}
	});
	
	var pathId = '${pathId}';
 	if(!!pathId){
 		var	bcId = pathId.split('|');
		 $('#'+bcId[0]).trigger('click'); 
		 $('#'+bcId[1]).trigger('click'); 
		 $('#'+bcId[2]).trigger('click'); 
	} 
	
});

</script>
</body>
</html>