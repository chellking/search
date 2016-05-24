function expandCollapse(tarObj,imgObj){
      	var target=document.getElementById(tarObj);
		var image = document.getElementById(imgObj);
//	var clicktext="";
            if (target.style.display=="block" || target.style.display==""){
                image.src="../../images/b.gif";
				target.style.display="none";
//                clicktext.innerText="点击查看详细信息";

            } else {
				image.src="../../images/a.gif";
                target.style.display="block";
//                clicktext.innerText='关闭详细信息信息';
            }
}

function expandCollapse_pub(tarObj,imgObj){
      	var target=document.getElementById(tarObj);
		var image = document.getElementById(imgObj);
//	var clicktext="";
            if (target.style.display=="block" || target.style.display==""){
                image.src="../images/b.gif";
				target.style.display="none";
//                clicktext.innerText="点击查看详细信息";

            } else {
				image.src="../images/a.gif";
                target.style.display="block";
//                clicktext.innerText='关闭详细信息信息';
            }
}

function expandAllCollapse(expandFlag){ 
	var target = document.all.tags("div");
	if(expandFlag == "open")
	{
		
		for(i = 0; i < target.length;i++)
		{		   
			var imgId = "img_" + target[i].id;
			var image = document.getElementById(imgId);		
			if(image != null) {
				image.src = "../../images/a.gif"
				target[i].style.display="block";
			}
	   	}

	 }else if(expandFlag == "close")
	{

		for(i = 0; i < target.length;i++)
		{     
			var imgId = "img_" + target[i].id;
			var image = document.getElementById(imgId);	
			if(image != null) {
				image.src = "../../images/b.gif"
				target[i].style.display="none";
			}
	   	}		
	}
}

function expandAllCollapse_pub(expandFlag){ 
	var target = document.all.tags("div");
	if(expandFlag == "open")
	{
		
		for(i = 0; i < target.length;i++)
		{		   
			var imgId = "img_" + target[i].id;
			var image = document.getElementById(imgId);		
			if(image != null) {
				image.src = "../images/a.gif"
				target[i].style.display="block";
			}
	   	}

	 }else if(expandFlag == "close")
	{

		for(i = 0; i < target.length;i++)
		{     
			var imgId = "img_" + target[i].id;
			var image = document.getElementById(imgId);	
			if(image != null) {
				image.src = "../images/b.gif"
				target[i].style.display="none";
			}
	   	}		
	}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function initHrefHot(){
	var url = document.location.href;
	var oldid = "";
	var oldcolor = "";
	if(url.indexOf("#")>0){
		oldid = url.substr(url.indexOf("#")+1);
    	oldcolor = $("#"+oldid).css("color");
    	$("#"+oldid).css("background-color","yellow");
	}
	$("a").bind('click', function(event) {
		var hrefstr = $(this).attr("href");
    	if(hrefstr.indexOf("#")==0){
			if(oldid !=null){
				$("#"+oldid).css("color",oldcolor);
			}
    		oldid = hrefstr.substr(1);
    		oldcolor = $("#"+oldid).css("color");
    		$("#"+oldid).css("background-color","yellow");
    	}
  	});
}
