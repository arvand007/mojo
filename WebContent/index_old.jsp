<%@ page import="java.io.*,java.util.*" %>
<%
if(session.getAttribute("encryptionKey")!=null){
	response.sendRedirect("TAD.jsp");
}
String agentid=(String)session.getAttribute("agentid");
String extension=(String)session.getAttribute("extension");
String encryptionKey=(String)session.getAttribute("encryptionKey");
String AgentName=(String)session.getAttribute("AgentName");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Login</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>var Encryptionkey='<% out.print(encryptionKey); %>';</script>
<script type="text/javascript" src="js/login.js"></script>

</head>
<body>
			
		<div id="Login">				
			Agent ID: <input type="text" name="agentid" id="agentid" class="agentid_box" />
			Extension: <input type="text" name="extension" id="extension" class="extension_box" value="16479857249" />
			Password: <input type="password" name="password" id="password" class="password_box" />
			<button name="login" value="Login" class="login_button" />Login</button><br />		
		</div>
		 <div id="messageDiv" style="display:none;"></div>
	
	
</body>
</html>