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
<script>var Encryptionkey='<% out.print(encryptionKey); %>';</script>
<script type="text/javascript" src="js/functions.js"></script>


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