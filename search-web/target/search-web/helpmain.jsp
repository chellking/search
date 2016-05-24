<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" %>
<%@ page info="Product Query" %>
<%String PageId = request.getParameter("flag");%>
<%String FileName = request.getParameter("filename");%>
<%String sDatasource = request.getParameter("datasource");%>
<%String sLangcode = request.getParameter("langcode");%>
<%@page contentType="text/html; charset=UTF-8" %>
<%
	String helpjsp = "/help/index.jsp?langcode="+sLangcode+"&datasource="+sDatasource;
	if(FileName != null){
		helpjsp += "&filename="+FileName;
	}	
	if(PageId != null){
		helpjsp += "&flag="+PageId;
	}
%>
<script>
	window.location.href="<%=helpjsp%>";
</script>
