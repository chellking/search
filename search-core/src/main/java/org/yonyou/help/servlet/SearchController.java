package org.yonyou.help.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.yonyou.help.search.SearchManager;
import org.yonyou.help.search.SearchResultBean;
import org.yonyou.help.tool.HelpLogs;

import net.sf.json.JSONObject;

public class SearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// String searchWord = new
		// String(request.getParameter("searchWord").getBytes("ISO-8859-1"),
		// "UTF-8");
		String searchWord = new String(request.getParameter("searchWord"));

		JSONObject json = null;
		if (false == true) {
			// 后台cookie处理

			// Cookie cookie = new Cookie("iuapusername",
			// java.net.URLEncoder.encode(name, "utf-8"));
			// cookie.setPath("/");
			// cookie.setMaxAge(-1);
			// response.addCookie(cookie);

			json = JSONObject.fromObject("{'status':'1'}");

		} else {
			json = JSONObject.fromObject("{'status':'0'}");

		}
		
		String callback = request.getParameter("jsoncallback");
		response.getWriter().write(callback + "(" + json + ")"); // 参数为json格式

		if (true == true) {
			List searchResult = null;
			HelpLogs.writerFile("\r\n" + "开始查询" + "\r\n");
			int start = 0;
			int total = 0;
			String str = request.getParameter("start");
			if (str != null) {
				start = new Integer(str).intValue();
			}
			String langcode = request.getParameter("langcode");
			if ((langcode == null) || (langcode.equals(""))) {
				langcode = "simpchn";
			}
			String datasource = request.getParameter("datasource");

			if ((searchWord != null) && (!searchWord.equals(""))) {
				SearchManager searchManager = new SearchManager(searchWord, langcode);
				HelpLogs.writerFile("查询分词" + searchWord + "\r\n");
				searchResult = searchManager.search(start);
				if ((searchResult != null) && (searchResult.size() != 0)) {
					total = searchManager.getTotal();
				}
			}
			HelpLogs.writerFile("查询结果total=" + total + "\n 查询结果start=" + start + "\r\n");
			for (int i = 0; i < searchResult.size(); i++) {
				SearchResultBean bean = (SearchResultBean) searchResult.get(i);
				HelpLogs.writerFile("查询结果searchResultBEAN.getHtmlPath=" + bean.getHtmlPath() + "\r\n");
				HelpLogs.writerFile("查询结果searchResultBEAN.getHtmlParent=" + bean.getHtmlParent() + "\r\n");
				HelpLogs.writerFile("查询结果searchResultBEAN.getHtmlContent=" + bean.getHtmlContent() + "\r\n");
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("/searchResult.jsp");
			request.setAttribute("searchWord", searchWord);
			request.setAttribute("searchResult", searchResult);
			request.setAttribute("total", new Integer(total));
			request.setAttribute("start", new Integer(start));
			request.setAttribute("langcode", langcode);
			request.setAttribute("datasource", datasource);
			dispatcher.forward(request, response);
		}

	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}

}
