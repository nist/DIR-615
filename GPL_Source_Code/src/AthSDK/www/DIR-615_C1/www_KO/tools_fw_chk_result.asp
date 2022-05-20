<html lang=en-US xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<script type="text/javascript" src="ko.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<LINK href="form_css.css" type=text/css rel=stylesheet>
</head>
<body>
<script language="JavaScript">
	var result = "<% CmoGetStatus("online_firmware_check"); %>";
	if(result =="LATEST"){
		//alert("This firmware is the latest version");
		//alert(which_lang[tf_intro_FWU1]);
parent.document.getElementById("check_result").innerHTML = which_lang[TEXT045];
	}else if(result.length > 0 && result !="ERROR"){
		parent.document.getElementById("check_now_result").style.display ="";
		
		var fm_info = result.split("+");
		parent.document.getElementById("latest_version").innerHTML = fm_info[0] //new firmware
		parent.document.getElementById("latest_date").innerHTML = fm_info[1] //new date
	
		var site = fm_info[2].split(",");
		var site_url = fm_info[3].split(",");
		var obj = parent.document.getElementById("sel_site");
		var count = 0;
		
		for (var i = 0; i < site.length; i++){			
			var ooption = parent.document.createElement("option");						
			ooption.text = site[i];
			ooption.value = site_url[i];				
			obj.options[count++] = ooption;      		
		}
	}else{
		//alert("Error contacting the server, please check the Internet connecting status");
		//alert(which_lang[GW_FW_NOTIFY_FIRMWARE_ERROR]);
parent.document.getElementById("check_result").innerHTML = which_lang[TEXT045];
	}
	parent.document.getElementById("check_now_b").disabled = false;
</script>
</body>
</html>
