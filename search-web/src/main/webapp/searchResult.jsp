<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="java.util.*"%>
<%@ page import="java.util.List"%>
<%@ page import="org.yonyou.help.search.*"%>
<%@ page import="org.yonyou.help.index.*"%>
<%
	String searchWord = "";
	if (request.getAttribute("searchWord") != null)
		searchWord = (String) request.getAttribute("searchWord");
	List searchResult = (List) request.getAttribute("searchResult");
	String sLangcode = (String) request.getAttribute("langcode");

	String sDatasource = (String) request.getAttribute("datasource");

	Locale locale = Locale.SIMPLIFIED_CHINESE;
	if (sLangcode != null && sLangcode.equals("simpchn")) {
		locale = Locale.SIMPLIFIED_CHINESE;
	} else if (sLangcode != null && sLangcode.equals("english")) {
		locale = Locale.US;
	} else if (sLangcode != null && sLangcode.equals("tradchn")) {
		locale = Locale.TRADITIONAL_CHINESE;
	} else if (sLangcode != null && sLangcode.equals("french")) {
		locale = Locale.FRANCE;
	}

	//ResourceBundle messages;
	//messages = ResourceBundle.getBundle("MessagesBundle", locale);
	//String noResults = messages.getString("no_results");
	//IndexManager indexManager = new IndexManager();
	//out.println(indexManager.getDataDir());
	//out.println(indexManager.getIndexDir());
%>
<html>
<head>
<title>搜索结果</title>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<style type="text/css">
<!--
.result:link {
	font-size: 14px;
	line-height: 18px;
	text-decoration: underline;
	color: #057DC9;
}

.result:visited {
	font-size: 14px;
	line-height: 18px;
	text-decoration: underline;
	color: #551a8b;
}

.result:hover {
	font-size: 14px;
	line-height: 18px;
	color: #057DC9;
	text-decoration: underline;
}

.result:active {
	text-decoration: underline;
}
-->
</style>

<script>
	function syncWithTree(fileName) {
		top.frames["menu"].location.href = fileName;
	}
</script>
<link href="css/style.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<br>
	<table width="85%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tbody>
			<%
				int resultCount = 0;
				if (null != searchResult) {
					resultCount = searchResult.size();
				}
				if (resultCount == 0) {
			%>

			<tr>
				<td align="center" class="text16"><font color='red'> <!--%=noResults%--> 是什么？
				</font></td>
			</tr>

			<%
				}
				for (int i = 0; i < resultCount; i++) {
					SearchResultBean resultBean = (SearchResultBean) searchResult.get(i);
					String title = resultBean.getHtmlTitle();
					if (title == null || title.equals(""))
						title = "Untitled Document";
					String htmlName = resultBean.getHtmlPath();
					String htmlParent = resultBean.getHtmlParent();

					String path = "";
					if (htmlParent != null && (htmlParent.equals(" ") || htmlParent.equals("") || htmlParent.equals("si")
							|| htmlParent.equals("tr") || htmlParent.equals("fr") || htmlParent.equals("en")))
						htmlParent = "";

					if (htmlParent != null && htmlParent.trim() != "") {
						path = request.getContextPath() + "/" + sLangcode + "/" + htmlParent + "/" + htmlName;
					} else {
						path = request.getContextPath() + "/" + sLangcode + "/" + htmlName;
					}
					String content = resultBean.getHtmlContent();
					String leftPage = "/help/frames/left.jsp?langcode=" + sLangcode + "&datasource=" + sDatasource 	+ "&filename=" + htmlName;
			%>
			<tr>
				<td><span class="file"> <a href="<%=path%>"
						class="result" onclick="syncWithTree('<%=leftPage%>')"><%=title%></a>
				</span></td>
			</tr>
			<tr>
				<td><%=content%><br> <br></td>
			</tr>
			<%
				}
			%>

			<tr align="center">
				<td><jsp:include page="pagination.jsp" /></td>
			</tr>
		</tbody>
	</table>
</body>
</html>