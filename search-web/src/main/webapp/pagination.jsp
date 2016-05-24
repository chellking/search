<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder, java.util.*,java.net.*"%>
<%
	String searchWord = "";
	if (request.getAttribute("searchWord") != null)
		searchWord = (String) request.getAttribute("searchWord");
	String sDatasource = (String) request.getAttribute("datasource");
	//int total = 334;//结果总数
	int total = 0;
	if (request.getAttribute("total") != null)
		total = ((Integer) request.getAttribute("total")).intValue();

	int start = 0;
	if (request.getAttribute("start") != null)
		start = ((Integer) request.getAttribute("start")).intValue(); //起始位置

	int rowsPerPage = 10;//设置一页显示的页码数目

	int maxPage = ((total % rowsPerPage) == 0) ? total / rowsPerPage : (total / rowsPerPage + 1);//最大的页码
	int curPage = start / rowsPerPage + 1;//当前页

	if (curPage > 1) {
		out.println("<a href='?searchWord=" + searchWord + "&datasource=" + sDatasource + "&start=0");
		out.println("'>第一页</a>");
		out.println("<a href='?searchWord=" + searchWord + "&datasource=" + sDatasource + "&start=" + (start - rowsPerPage));
		out.println("'>上一页</a>");
	}

	if (maxPage > 10) {
		int totalShow = curPage + 9;
		int startPage = 0;
		if (totalShow > maxPage) {
			totalShow = maxPage;
		}
		if (maxPage > 11 && curPage > 11) {
			startPage = curPage - 11;
		}

		for (int i = startPage; i < totalShow; i++) {
			if (i + 1 == curPage) {
%>&nbsp;[<%=i + 1%>]&nbsp;<%
	} else {
%><a
	href="?searchWord=<%=searchWord%>&datasource=<%=sDatasource%>&start=<%=i * rowsPerPage%>">&nbsp;<%=i + 1%>&nbsp;
</a>
<%
	}
		}

	} else {
		for (int i = 0; i < maxPage; i++) {
			if (i + 1 == curPage) {
%>&nbsp;[<%=i + 1%>]&nbsp;<%
	} else {
%><a
	href="?searchWord=<%=searchWord%>&datasource=<%=sDatasource%>&start=<%=i * rowsPerPage%>">&nbsp;<%=i + 1%>&nbsp;
</a>
<%
	}
		}
	}

	if (curPage < maxPage) {
		out.println("<a href='?searchWord=" + searchWord + "&datasource=" + sDatasource + "&start=" + curPage * rowsPerPage);
		out.println("'>下一页</a>");
		out.println("<a href='?searchWord=" + searchWord + "&datasource=" + sDatasource + "&start=" + (maxPage - 1) * rowsPerPage);
		out.println("'>最后一页</a>");
	}
%>