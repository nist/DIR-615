﻿<html lang=en-US xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head><title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript">
	function onPageLoad(){
		var upink = "<% CmoGetStatus("if_measuring_uplink_now"); %>";
		get_by_id("html_response_page").value = get_by_id("html_response_return_page").value;
		
		if(upink == "1"){
			get_by_id("please_wait").style.display = "";			
			do_count_down();
		}else{			
			back();
		}
	}
	
	function do_count_down(){		
		if (count == 0) {
				window.location.href = "please_wait_2.asp";	
		}			
		if (count > 0) {
	        count--;	        
	        setTimeout('do_count_down()',1000);
	    }	   
	}

	function back(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="index.asp";
		}else{
			//alert(get_by_id("html_response_page").value);
			if(get_by_id("html_response_page").value)
			window.location.href = get_by_id("html_response_page").value;
			else
				window.location.href ="index.asp";	
		}
		
	}
</script>
</head>
<body align="center">
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="<% CmoGetCfg("html_response_page","none"); %>">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
<input type="hidden" id="reboot_type" name="reboot_type" value="none">
</form>
<div id="please_wait" align=center style="display:none">
<H3><script>show_words(which_lang[wt_title])</script>...</H3>
<P>
	<script>show_words(which_lang[wt_p_1])</script><BR>
	<script>show_words(which_lang[wt_p_2])</script><BR>
	<script>show_words(which_lang[wt_p_3])</script>
</P>
</div>
</BODY>
<script>
	var count = 10;
	onPageLoad();
</script>
</html>
