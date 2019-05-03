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
<html lang="en" id="login"> 


	<meta charset="utf-8">
    <title>Login</title>
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
	<script>var Encryptionkey='<% out.print(encryptionKey); %>';</script>
	<script type="text/javascript" src="js/login.js"></script>

</head>
<body>
<!--[if lte IE 9]>
            <p class="browserupgrade">OUTDATED BROWSER<br>
FOR A BETTER EXPERIENCE, KEEP YOUR BROWSER UP TO DATE. CHECK <a href="http://outdatedbrowser.com/en">HERE</a> FOR LATEST VERSIONS.</p>
        <![endif]-->
    <div class="body-wrapper">
            <section class="main-header">
                    <!-- Logo -->
                    <a href="#" class="logo">
                        <span class="logo-lg">
                            <img src="images/logo.svg" alt="Outbound Dialer"> <span class="slogan">Expintel Dialer</span>
                        </span>
                    </a>
                    <nav class="navbar">
                      
                       
                    </nav>
                </section>
        <div class="col-1-6 form">
                <div class="login-form">
                        <form class="form">
                            <div class="form-title">
                                Login
                            </div>
                            <div class="form-group">
                                <input type="text" placeholder="Agent ID/Email*" id="agentid" class="input icon" required>
                                <span class="input-icon"><img src="images/icon-user.svg" alt=""></span>
                            </div>
                            <div class="form-group">
                                    <input type="text" placeholder="Extension" id="extension" class="input icon" value="16479857249" >
                                    <span class="input-icon"><img src="images/icon-user.svg" alt=""></span>
                                </div>
                            <div class="form-group">
                                <input type="password" placeholder="Password*" id="password" class="input icon" required>
                                <span class="input-icon"><img src="images/icon-lock.svg" alt=""></span>
                            </div>     
                            <div id="messageDiv" class="messageDiv"></div>                       
                            <button  type="submit"  name="login" value="Login" class="btn btn-primary" />Login</button><br />
                            
                        </form>
                        
                    </div>
                    <div class="cp">© 2019 Expintel Inc. All rights reserved.</div>   
        </div>
        <div class="col-1-6 figure">
                <div class="inner flexcenter">
                    </div>
        </div>
    </div>
</body>
</html>