package com.hhf.seller.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.hhf.common.mybatis.Page;

public class PageTag extends TagSupport {
	private static final long serialVersionUID = 6349370307595637390L;
	
	private Page<?> page;
	private String name;
	private String formId;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFormId() {
		return formId;
	}

	public void setFormId(String formId) {
		this.formId = formId;
	}

	public Page<?> getPage() {
		return page;
	}

	public void setPage(Page<?> page) {
		this.page = page;
	}

	@Override
	public int doStartTag() throws JspException {
		//获取分页bean
		JspWriter out = this.pageContext.getOut();
		
		//分页的html代码
		StringBuffer pageHtml = new StringBuffer();
		
		pageHtml.append("<div class=\"paging\">");
		pageHtml.append("	<div class=\"pagingWrap\">");
		pageHtml.append("		<div class=\"pagAll\">");
		pageHtml.append("			共");
		pageHtml.append("			<span>"+page.getTotalRecord()+"</span>");
		pageHtml.append("			条记录");
		pageHtml.append("		</div>");
		if(page.getCurrentPageNo() == 1){
			pageHtml.append("		<div class=\"pageup disable\">");
		}else{
			pageHtml.append("		<div class=\"pageup\" onclick=\""+this.name+"("+page.getPrevPageNo()+");\">");
		}
		pageHtml.append("			<i class=\"ico\"></i>");
		pageHtml.append("			<span>上一页</span>");
		pageHtml.append("		</div>");
		pageHtml.append("		<ul>");
		//页数小于7页
		if(page.getTotalPage() <=7){
			for(int i=0;i<page.getTotalPage();i++){
				if(page.getCurrentPageNo() == (i+1)){
					pageHtml.append("<li><span class=\"on\">"+(i+1)+"</span></li>");
				}else{
					pageHtml.append("<li><a href=\"javascript:;\" onclick=\""+this.name+"("+(i+1)+");\">"+(i+1)+"</a></li>");
				}
			}
		}
		//页数大于7页
		else{
			if(page.getCurrentPageNo() == 1){
				pageHtml.append("<li><span class=\"on\">1</span></li>");
			}else{
				pageHtml.append("<li><a href=\"javascript:;\" onclick=\""+this.name+"(1);\">1</a></li>");
			}
			
			if((page.getCurrentPageNo()-1 > 3) && (page.getLastPageNo() - page.getCurrentPageNo() > 3)){
				pageHtml.append("<li><b>...</b></li>");
				pageHtml.append("<li><a href=\"javascript:;\" onclick=\""+this.name+"("+(page.getCurrentPageNo()-2)+");\">"+(page.getCurrentPageNo()-2)+"</a></li>");
				pageHtml.append("<li><a href=\"javascript:;\" onclick=\""+this.name+"("+(page.getCurrentPageNo()-1)+");\">"+(page.getCurrentPageNo()-1)+"</a></li>");
				pageHtml.append("<li><span class=\"on\">"+page.getCurrentPageNo()+"</span></li>");
				pageHtml.append("<li><a href=\"javascript:;\" onclick=\""+this.name+"("+(page.getCurrentPageNo()+1)+");\">"+(page.getCurrentPageNo()+1)+"</a></li>");
				pageHtml.append("<li><a href=\"javascript:;\" onclick=\""+this.name+"("+(page.getCurrentPageNo()+2)+");\">"+(page.getCurrentPageNo()+2)+"</a></li>");
				pageHtml.append("<li><b>...</b></li>");
			}else if(page.getLastPageNo() - page.getCurrentPageNo() <= 3){
				pageHtml.append("<li><b>...</b></li>");
				for(int i=5;i>0;i--){
					if(page.getCurrentPageNo() == (page.getLastPageNo()-i)){
						pageHtml.append("<li><span class=\"on\">"+(page.getLastPageNo()-i)+"</span></li>");
					}else{
						pageHtml.append("<li><a href=\"javascript:;\" onclick=\""+this.name+"("+(page.getLastPageNo()-i)+");\">"+(page.getLastPageNo()-i)+"</a></li>");
					}
					
				}
			}else if(page.getCurrentPageNo()-1 <= 3){
				for(int i=2;i<7;i++){
					if(page.getCurrentPageNo() == i){
						pageHtml.append("<li><span class=\"on\">"+i+"</span></li>");
					}else{
						pageHtml.append("<li><a href=\"javascript:;\" onclick=\""+this.name+"("+i+");\">"+i+"</a></li>");
					}
				}
				pageHtml.append("<li><b>...</b></li>");
			}
			if(page.getCurrentPageNo() == page.getLastPageNo()){
				pageHtml.append("<li><span class=\"active\">"+page.getLastPageNo()+"</span></li>");
			}else{
				pageHtml.append("<li><a href=\"javascript:;\" onclick=\""+this.name+"("+page.getLastPageNo()+");\">"+page.getLastPageNo()+"</a></li>");
			}
			
		}
		pageHtml.append("		</ul>");
		if(page.getCurrentPageNo() == page.getLastPageNo()){
			pageHtml.append("		<div class=\"pagedown disabled\">");
		}else{
			pageHtml.append("		<div class=\"pagedown\" onclick=\""+this.name+"("+page.getNextPageNo()+");\">");
		}
		
		pageHtml.append("			<span>下一页</span>");
		pageHtml.append("			<i class=\"ico\"></i>");
		pageHtml.append("		</div>");
		pageHtml.append("		<div class=\"goto\"><span>到第</span>");
		pageHtml.append("		<input name=\""+this.name+"page-num\" />");
		pageHtml.append("		<span>页</span>");
		pageHtml.append("		<button class=\"btn\" onclick=\""+this.name+"Skip()\" type=\"button\">确定</button>");
		pageHtml.append("		</div>");
		pageHtml.append("	</div>");
		pageHtml.append("</div>");
		
		
		pageHtml.append("<script>");
		pageHtml.append("function "+this.name+"(selectPageNo){");
		pageHtml.append("$(\"#"+this.formId+"\").append('<input type=\"hidden\" name=\"currentPageNo\" value=\"'+selectPageNo+'\" />');");
		pageHtml.append("$(\"#"+this.formId+"\").submit();");
		
		pageHtml.append("}");
		pageHtml.append("function "+this.name+"Skip(){");
		pageHtml.append("var selectPageNo = $(\"input[name="+this.name+"page-num]\").val();");
		pageHtml.append("if(!selectPageNo){");
		pageHtml.append("	alert(\"请输入页码！\");return;");
		pageHtml.append("}else{");
		pageHtml.append("	if(!/^\\d+$/.exec(selectPageNo)){");
		pageHtml.append("		alert(\"页码不正确！\");return;");
		pageHtml.append("	}");
		pageHtml.append("	if(selectPageNo <= 0 || selectPageNo > "+this.page.getLastPageNo()+"){");
		pageHtml.append("		alert(\"该页码不存在！\");return;");
		pageHtml.append("	}");
		pageHtml.append("}");
		pageHtml.append(this.name+"(selectPageNo)");
		pageHtml.append("}");
		pageHtml.append("</script>");
		try {
			out.print(pageHtml.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return super.doStartTag();
	}
	
	@Override
	public int doEndTag() throws JspException {
		return super.doEndTag();
	}
}
