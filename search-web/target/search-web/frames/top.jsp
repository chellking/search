<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>

<%
	//zhangna added for I18N
	String sLangcode = "";
	//request.getParameter("langcode");	
	//String sDatasource = 
	//request.getParameter("datasource");
	//System.out.println("sLangcode=" + sLangcode);
	Locale locale = Locale.SIMPLIFIED_CHINESE;

	ResourceBundle messages;
	//messages = ResourceBundle.getBundle("MessagesBundle", locale);
	//System.out.println(messages.getString("online_help"));
	//System.out.println("nc.server.location=" + System.getProperty("nc.server.location"));

	String mainPage = "/help/" + sLangcode + "/main.htm";
	String helpguide = "/help/" + sLangcode + "/help_guidance.html";
	String maintitle = "首页";
	String helptitle = "帮助导航";
	String closetitle = "关闭菜单";
	String CloseMenu = "关闭菜单";
	String OpenMenu = "打开菜单";
	if (sLangcode != null && sLangcode.equals("english")) {
		maintitle = "Home";
		helptitle = "Help Guide";
		closetitle = "Close Menu";
		CloseMenu = "Close Menu";
		OpenMenu = "Open Menu";
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><style type="text/css">
<!--
body {
	background-color: #FFFFFF;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.top_Bg {
	background-image: url(../images/top_02.jpg);
	background-repeat: no-repeat;
}
.textfile {
	font-size: 12px;
	color: #666666;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
}
-->
</style>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
<!--
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

var openStatus;
function resetFrameset(){
  var fs = parent.document.getElementById("mainframe");
  if(openStatus == "closed"){
	  fs.cols = "20%,*";
	  openStatus = "opened";
  	  document.getElementById("menuSwitch").title="<%=CloseMenu%>";
  }else{
	  fs.cols = "0,*";
	  openStatus = "closed";
      document.getElementById("menuSwitch").title="<%=OpenMenu%>";
  }
}

//-->
</script>
<style type="text/css">
<!--
.STYLE1 {color: #FFFFFF}
-->
</style>
</head>

<body
	onLoad="MM_preloadImages('../images/home-over.png','../images/seacher1.png','../images/help-2.png','../images/close_1.png')" scroll=no>
	<form id=searchForm action="/SearchController" target="fmsg">
		<table width="100%" height="41" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td height="41" background="../images/top_bg.png"><table  width="200" border="0" cellpadding="1" cellspacing="0">
						<tr>

							<%
								String searchWord = "";
								if (request.getAttribute("searchWord") != null)
									searchWord = (String) request.getAttribute("searchWord");
							%>
							
							<td>
								<table width="183" height="41" border="0" cellpadding="1"
									cellspacing="1">
									<tr>
										<td width="1">&nbsp;</td>
										<td width="202"><table width="175" border="0"	cellpadding="0" cellspacing="0">
												<tr>
													<td width="4"><div align="right">
															<img src="../images/textflie-left.png">
														</div></td>
													<td width="168" background="../images/textflie-middle.png">
													     <table width="65%" border="0" cellpadding="0" cellspacing="0">
															<tr>
																<td width="78%"><input name="searchWord" type="text" value="<%=searchWord%>" class="textfile" id="1" size="25"></td>
																<td width="22%"><input type="image"	src="../images/seacher.png"></td>
															</tr>
														</table> <label></label></td>
													<td width="10"><img src="../images/textflie-right.png"></td>
												</tr>
											</table></td>
										<td><input name="langcode" type="hidden" value="<%=sLangcode%>"></td>
									</tr>
								</table>
							</td>
							<td><img src="../images/line.png"></td>
							<td><a href="<%=mainPage%>" title="<%=maintitle%>"
								target="fmsg" onMouseOut="MM_swapImgRestore()"
								onMouseOver="MM_swapImage('Image5','','../images/home-over.png',1)"><img
									src="../images/home.png" name="Image5" width="39" height="39"
									border="0" usemap="#home"></a></td>
							<td><a href="<%=helpguide%>" target="fmsg"
								title="<%=helptitle%>" onMouseOut="MM_swapImgRestore()"
								onMouseOver="MM_swapImage('Image10','','../images/help-2.png',1)"><img
									src="../images/help-1.png" name="Image10" width="39"
									height="39" border="0"></a></td>
							<td><a id="menuSwitch" href="#" title="<%=closetitle%>"
								onClick="resetFrameset()"><img src="../images/close.png"
									name="Image9" width="39" height="39" border="0"></a></td>
						</tr>
					</table> <a href="#" onMouseOut="MM_swapImgRestore()"
					onMouseOver="MM_swapImage('Image10','','../images/help-2.png',1)"></a></td>
				<td height="47" background="../images/top_bg.png"><table
						width="200" border="0" align="right" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="128"><div align="right">
									<img src="../images/zaixian3.png" name="w12" id="w12">
								</div></td>
							<td nowrap><div align="right">
									<a href="http://help.ufida.com" target="blank" class="link133">
										<!-- %=messages.getString("online_help")%> --> online_help
									</a>
								</div></td>
							<td width="1" nowrap><img src="../images/kong.gif" width="5"
								height="1"></td>
						</tr>
					</table></td>
			</tr>
		</table>
	</form>
</body>
</html>

