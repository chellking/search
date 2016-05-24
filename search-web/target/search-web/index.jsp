<%@ page language="java" %>
<%@ page info="Product Query" %>

<%@page contentType="text/html; charset=UTF-8" %>
<%
	//String menujsp = "/help/frames/left.jsp?langcode="+sLangcode+"&datasource="+sDatasource+"&filename="+FileName+"&flag="+PageId;
	//String helpfile = "/help/frames/main.htm";
	//String helpfile = "/help/"+ sLangcode + "/main.htm";
	/* if(FileName != null && sLangcode !=null){
		if(FileName.endsWith(".html")){
			if(FileName.indexOf("UI_style")>=0)
			{
				helpfile = "/help/" + sLangcode + "/" + FileName;
			}
			else
			{
				helpfile = "/help/" + sLangcode + "/" + FileName.substring(0,2) + "/" + FileName;
			}
		}else{
			helpfile = "/help/" + sLangcode + "/" + FileName.substring(0,2) + "/" + FileName + ".html";
		}
	} */
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>
<%
//nc.bs.ml.NCLangResOnserver.getInstance().getString(sLangcode,"smcomm","","webpagetitle")
%></TITLE>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<script src="js/browser.js"></script>
<script src="js/func.js"></script>
<script language="javascript">
<!--
	mainurl = unescape(queryString('mainurl','frames/main.htm'));

//-->
</script>
<frameset rows="47,*" cols="*" frameborder="0" border="0" framespacing="0">
<frame name="topFrame" src="<%="/frames/top.jsp"%>" scrolling="NO" >
<frameset name=mainframe id=mainframe frameborder=0 border=0  cols="20%,*">
	<frame name="menu" scrolling="no"  marginwidth=0 marginheight=0 src="/frames/left.jsp" style="border:1px solid #7B98BE; cursor:col-resize;">
	<frame name="fmsg"  scrolling="auto"  marginwidth=0 marginheight=0  src="/main.htm"" style="border:0px solid #7B98BE;">
</frameset>
</frameset>
</html>
