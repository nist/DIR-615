<script>
var wps_status = "<% CmoGetStatus("wps_push_button_result"); %>";
var next_value = "wps_back_fail.asp";
if(wps_status == "1"){
	next_value = "wireless.asp";
}

window.location.href = next_value;
</script>