<%@ page import="java.io.*,java.util.*" %>
<%
if(session.getAttribute("agentid")==null){
	response.sendRedirect("index.jsp");
}
String agentid=(String)session.getAttribute("agentid");
String extension=(String)session.getAttribute("extension");
String encryptionKey=(String)session.getAttribute("encryptionKey");
String AgentName=(String)session.getAttribute("AgentName");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GetCrashReport</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
  $( function() {
    $( "#date_box").datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#date_box").datepicker('setDate', new Date());
  } );
  
  $(document).ready(function(){
	  $("#date_box").change(function(){
		  var Date= $("#date_box").val();
			var data = 'Queue=DialingList&Date='+Date;
			$.ajax({
				type : "POST",
				url : "/OutboundDialerDesktop/CallsinQReport",
				data : data,
				beforeSend : function(html) { // this happen before actual call
					$("#QueueReportStatus").show();
					$("#QueueReportStatus").html('Populating Results...');
								
				},
				success : function(html) { // this happen after we get result	
					var res = html.split(",");
					$("#QueueReportStatus").html('');
					$("#QueueReportTable").html('');
					$("#QueueReportTable").append(html);
				}
		  } )
	  });
	});
  
  $( function() {
	    var Date= $("#date_box").val();
		var data = 'Queue=DialingList&Date='+Date;
		$.ajax({
			type : "POST",
			url : "/OutboundDialerDesktop/CallsinQReport",
			data : data,
			beforeSend : function(html) { // this happen before actual call
				$("#QueueReportStatus").show();
				$("#QueueReportStatus").html('Populating Results...');			
			},
			success : function(html) { // this happen after we get result	
				var res = html.split(",");
				$("#QueueReportStatus").html('');
				$("#QueueReportTable").html('');
				$("#QueueReportTable").append(html);
			}
	  } )
  });	
  
  var CallsinQ = setInterval(function() {
		
		var Date= $("#date_box").val();
	
		var data = 'Queue=DialingList&Date='+Date;
		$.ajax({
			type : "POST",
			url : "/OutboundDialerDesktop/CallsinQ",
			data : data,
			beforeSend : function(html) { // this happen before actual call
							
			},
			success : function(html) { // this happen after we get result	
				var res = html.split(",");
				document.getElementById("Total Records").innerHTML=res[0];		
				document.getElementById("Called").innerHTML=res[1];	
				document.getElementById("Remaining").innerHTML=res[2];	
			}
		});
	}, 5000);
  
 
  
</script>

</head>
<body>
<b>Start Date:</b> <input type="text" name="date" id="date_box" class='date_box' value=""/></br>
<b>Total Records:</b> <div id="Total Records">0</div>
<b>Called:</b> <div id="Called">0</div>
<b>Remaining:</b> <div id="Remaining">0</div>
<div id="QueueReportStatus"></div>
<div id="QueueReportTable"></div>
</body>
</html>