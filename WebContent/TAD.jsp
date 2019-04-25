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
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="js/TAD.js"></script>

</head>
<body onload="SetAgentID2(<% out.print(agentid); %>,'<% out.print(AgentName); %>','<% out.print(encryptionKey); %>', '<% out.print(extension); %>');openConnection()">
<button name="logout" value="logout" id="Logout" class="logout_button" />Logout</button><br />
<b>Calls in Q:</b> <div id="CallsinQ">...</div>
<b>AgentID:</b> <div id="AgentID"></div>
<b>Status:</b> <div id="State">Away</div>

<select id="SelectStates" onchange="ChangeState(this.value)">
  <option value="Away">Away</option>
  <option value="Ready">Ready</option>  
  <option value="Break">Break</option>
  <option value="Lunch">Lunch</option>
  <option value="Meeting">Meeting</option>
</select><br>
<b>TimeinState:</b> <div id="TimeinState">0:0:0:0</div>
<b>SessionID:</b> <div id="SessionID"></div>
<b>Agent Name:</b> <div id="Name"></div>
<b>Extension:</b> <div id="Extension"></div>
<b>ConnectionStatus:</b> <div id="ConnectionStatus"></div>
<b>Call Notification:</b> <div id="CallNotification"></div>
<b>Error Notification:</b> <div id="ErrorNotification"></div>
<b>Customer Name:</b> <div id="CustomerName"></div>
<b>Customer Phone:</b> <div id="CustomerPhone"></div>
<b>Report Info:</b> <div id="iframe"><iframe id="screenpop" width="800" height="1000" src=""><p>Your browser does not support iframes.</p></div>
</iframe>
</body>