<script>
setInterval(winreload,3000);
var wps_status = "<% CmoGetStatus("wps_push_button_result"); %>";
var next_value = "wps_back_fail.asp";

if(wps_status == "1"){
	parent.location.href = "wireless.asp";
}

if(wps_status == "2"){
	window.location.href = "wps_back_fail.asp";
}

function winreload(){
window.location.reload();
}
</script>