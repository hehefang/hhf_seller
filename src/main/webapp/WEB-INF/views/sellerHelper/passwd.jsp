<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>卖家|保证金</title>
</head>
<body>
	<link rel="stylesheet" href="${cssUrl}/css/helper.css" />
	<div class="wrapper wrap-helper">
		<!-- container -->
		<div id="container">
			<!-- main -->
			<div id="main">
				<!-- mainCaption -->
				<div class="mainCaption">
					<h2>我的密码</h2>
				</div>
				<!-- mainCaption end -->
				<div class="section">
					<!-- form -->
					<form class="form form-helper">
						<fieldset>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>旧密码：</label></div>
								<div class="item-cont">
									<input type="password" name="oldPwd" id="oldPwd" class="txt lg w-lgl" /><span class="note errTxt"></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>新密码：</label></div>
								<div class="item-cont">
									<input type="password" name="newPwd" id="newPwd" class="txt lg w-lgl" /><span class="note">6-20字符，请使用英文加数字或符号组合密码，不能单独使用英文，数字或符号</span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-label"><label><em>*</em>再次输入新密码：</label></div>
								<div class="item-cont">
									<input type="password" name="repeatNewPwd" id="repeatNewPwd"  class="txt lg w-lgl" /><span class="note errTxt"></span>
								</div>
							</div>
							<div class="form-item">
								<div class="item-cont">
									<input type="button" value="保 存" id="save" class="btn btn-primary lg p-xl">
								</div>
							</div>
						</fieldset>
					</form>
				<!-- form end -->
				</div>
			</div>
			<!-- main end -->
		</div>
		<!-- container end -->
	</div>
	<!-- popup -->
	<div id="mask"></div>
	<!-- popup end -->
	<script type="text/javascript" src="${jsUrl}/g.js?t=20150311"></script>
	<script type="text/javascript">
		$(function(){
			var oldPwdFlag=false,newPwdFlag=false,repeatNewPwdFlag=false;
			
			$("#oldPwd").blur(function(){
				var oldPwd = $.trim($(this).val());
				if(oldPwd.length > 0){
					oldPwdFlag = true;
					$(this).next().text("");
				}else{
					$(this).focus().next().text("请输入旧密码");
				}
			});
			$("#newPwd").blur(function(){
				var newPwd = $.trim($(this).val());
				if(newPwd.length > 0){
					if(CheckUtil.checkPassword(newPwd)) {
						newPwdFlag = true;
						$(this).next().removeClass("errTxt").text("6-20字符，请使用英文加数字或符号组合密码，不能单独使用英文，数字或符号");
					}else{
						$(this).select().next().addClass("errTxt").text("密码位数不足或格式有误，请输入6-20位登录密码");
					}
				}else{
					$(this).focus().next().addClass("errTxt").text("密码位数不足或格式有误，请输入6-20位登录密码");
				}
			});
			$("#repeatNewPwd").blur(function(){
				var pwd = $.trim($("#newPwd").val());
				var repPwd = $.trim($(this).val());
				if(repPwd.length > 0){
					if(repPwd === pwd){
						repeatNewPwdFlag = true;
						$(this).next().text("");
					}else{
						$(this).focus().next().text("两次输入密码不一致");
					}
				}else{
					$(this).focus().next().text("请再次输入新密码");
				}
			});
			
			$("#save").click(function(){
				var oldPwd,newPwd,repeatNewPwd;
				
				if(oldPwdFlag){
					oldPwd = $.trim($("#oldPwd").val());
				}else{
					$("#oldPwd").focus().next().text("请输入旧密码");
					return;
				}
				
				if(newPwdFlag){
					newPwd = $.trim($("#newPwd").val());
				}else{
					$("#newPwd").focus().next().text("请输入新密码");
					return;
				}
				
				if(repeatNewPwdFlag){
					repeatNewPwd = $.trim($("#repeatNewPwd").val());
				}else{
					$("#repeatNewPwd").focus().next().text("请再次输入新密码");
					return;
				}
				 
				$.ajax({
					url  : "${ctx}/helper/savePasswd",
					type : "POST",
					data : {
							oldPwd : oldPwd,
							newPwd	 : newPwd,
							repeatNewPwd : repeatNewPwd
						   },
					success : function(re) {
						var h3,cls="i-danger";
						
						if(re == 1){
							cls="i-right";
							h3 = "修改密码成功";
							$("#repeatNewPwd,#newPwd,#oldPwd").val("");
						}else if(re == -1){
							h3 = "旧密码不正确";
						}else if(re == 0){
							h3 = "修改密码失败";
						}else if(re == -2){
							h3 = "两次输入的新密码不一致";
						}else if(re == -3){
							h3 = "密码不能为空";
						}
						
						var dialoghtml = '<div id="dialog" class="popup popup-primary" style="width:500px;">'+
											'<div class="hd"><h2>修改密码</h2><i class="close"></i></div>'+
											'<div class="bd">'+
												'<dl class="popup-doc">'+
													'<dt><i class="icon '+cls+'"></i></dt>'+
													'<dd><h3>'+h3+'</h3></p><div class="btnWrap"><input id="confirm" type="button" class="btn btn-primary" value="确认" /></div></dd>'+
												'</dl>'+
											'</div>'+
										'</div>';
						var dialog$ = $(dialoghtml);	
						$(document.body).append(dialog$);
						$("#mask").addClass("mask");
						
						showPop();
						
						dialog$.find(".close,#confirm").click(function(){
							dialog$.remove();
							$("#mask").removeClass("mask");
						});
					}
				});
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