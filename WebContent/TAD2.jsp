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

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Expintel Dialer - Agent Desktop</title>
    <meta name="description" content="Outbound Dialer">
    <meta name="keywords" content="Outbound Dialer">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
    <meta name="copyright" content="2019">
    <meta name="HandheldFriendly" content="true">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <!-- <link rel="icon" type="image/png" href="images/favicon-16x16.png" sizes="16x16">
    <link rel="icon" type="image/png" href="images/favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="images/favicon-96x96.png" sizes="96x96">
    <link rel="apple-touch-icon" sizes="180x180" href="images/touch-icon-iphone.png">
    <link rel="apple-touch-icon" sizes="76x76" href="images/touch-icon-ipad.png">
    <link rel="apple-touch-icon" sizes="120x120" href="images/touch-icon-iphone-retina.png">
    <link rel="apple-touch-icon" sizes="152x152" href="images/touch-icon-ipad-retina.png">
    <link rel="shortcut icon" href="images/favicon.ico">
    <meta property="og:image" content="images/logo.png"> -->

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
        integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <script type="text/javascript" src="js/TAD.js"></script>    
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<body  onload="SetAgentID2(<% out.print(agentid); %>,'<% out.print(AgentName); %>','<% out.print(encryptionKey); %>', '<% out.print(extension); %>');openConnection()">
    <!--[if lte IE 9]>
            <p class="browserupgrade">OUTDATED BROWSER<br>
FOR A BETTER EXPERIENCE, KEEP YOUR BROWSER UP TO DATE. CHECK <a href="http://outdatedbrowser.com/en">HERE</a> FOR LATEST VERSIONS.</p>
        <![endif]-->
	<div class="body-wrapper">        
		<!-- TOP Header -->
		<jsp:include page="Top_Header.jsp">			
			<jsp:param name="agentid" value="<%=agentid%>" />
		</jsp:include>
		
		
	    <!-- Left side column. contains the logo and sidebar -->    
	 	<jsp:include page="main-sidebar.jsp">
	 		<jsp:param name="Page" value="TAD" />
	 	</jsp:include>
	    
	    <div class="content-wrapper">
	        <div class="top-bar col-1-12">
	            <div class="col-1-4">
	                <div class="ext">
	                    Extenstion: <b><span id="Extension"></span></b>
	                </div>
	                <div class="session">
	                    SessionID: <b><span id="SessionID"></span></span></b>
	                </div>
	            </div>
	            <div class="col-1-4">
	                <div class="ciq">
	                    <span class="ciq-title">Calls in Q:</span>
	                    <span class="ciq-num" id="CallsinQ">...</span>
	                </div>
	            </div>
	            <div class="col-1-4 status-col">
	                <div class="status fright">
	                    <span class="offline" id="State2"><i class="far fa-dot-circle"></i><span> </span><span class="offline" id="State"></span></span>
	                    <span class="time" id="TimeinState"></span>
	                </div>
	                <div class="select-status fright">
	                    <div class="form-group">
	                        <select class="form-control" id="SelectStates" onchange="ChangeState(this.value)">
	                            <option value="Away">Away</option>
							    <option value="Ready">Ready</option>  
							    <option value="Break">Break</option>
							    <option value="Lunch">Lunch</option>
							    <option value="Meeting">Meeting</option>
	                        </select>
	                    </div>
	                </div>                
	            </div>
	        </div>
	        <div class="var-bar">
	            <div class="col-1-12 marquee">
	                    <span class="inner" id="CallNotification">No notifications...
	                        </span>
	            </div>
	            <div class="col-1-12">
	                <div class="col-1-4">
	                    <div class="inner var1">
	                        <span class="var">Customer Name</span>
	                        <span class="value" id="CustomerName">Empty</span>
	                    </div>
	                </div>
	                <div class="col-1-4">
	                    <div class="inner var2">
	                        <span class="var">Customer Phone</span>
	                        <span class="value" id="CustomerPhone">Empty</span>
	                    </div>
	                </div>
	                <div class="col-1-4">
	                    <div class="inner var3">
	                        <span class="var">Var3</span>
	                        <span class="value">Empty</span>
	                    </div>
	                </div>
	                <div class="col-1-4">
	                    <div class="inner var4">
	                        <span class="var">Var4</span>
	                        <span class="value">Empty</span>
	                    </div>
	                </div>
	                <div class="col-1-4">
	                    <div class="inner var5">
	                        <span class="var">Var5</span>
	                        <span class="value">Empty</span>
	                    </div>
	                </div>
	                <div class="col-1-4">
	                    <div class="inner var6">
	                        <span class="var">Var6</span>
	                        <span class="value">Empty</span>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <div class="iframe">
	            <div class="iframe-box">
	                <iframe src="" frameborder="0" id="screenpop" ></iframe>
	            </div>
	        </div>
	    </div>
	</div>
</body>