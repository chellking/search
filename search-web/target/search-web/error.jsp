<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.io.*" isErrorPage="true"%>
<%! boolean showexception=false;%>
<html>
	<head>
		<title>页面出错啦！</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	</head>
	<body>


		<div align="center">
			抱歉，您请求的页面出错啦！
		</div>
		<div align="center">
			<font style="BACKGROUND-COLOR: #fffffd" color="#0000ff" size="4"></font>
		</div>
		<% 					
      	if("true".equals(request.getParameter("showexception"))) {
      		showexception = true;
			} else if("false".equals(request.getParameter("showexception"))) {
      			showexception = false;
			}			
			if (showexception) {
				exception.printStackTrace(new PrintWriter(out)); 
			}
	%>


		<table>
			<tbody>
				<tr>
					<td>

						<hr>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
					</TD>
				</TR>
				<TD>
					<HR>
				</TD>
				</TR>
			</TBODY>
		</TABLE>

		<table>
			<tbody>
				<tr>
					<td>

						<hr>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
					</TD>
				</TR>
				<TD>
					<HR>
				</TD>
				</TR>
			</TBODY>
		</TABLE>
	</body>
</html>