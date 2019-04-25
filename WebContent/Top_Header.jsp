<%@ page import="java.io.*,java.util.*" %>
<%
	String agentid=(String)request.getParameter("agentid");
%>

<section class="main-header">
        <!-- Logo -->
        <a href="#" class="logo">
            <span class="logo-lg">
                <img src="images/logo.svg" alt="Outbound Dialer"> <span class="slogan">Expintel Dialer</span>
            </span>
        </a>
        <nav class="navbar">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle">
                    <span class=""><i class="fas fa-bars"></i></span>
            </a>
            <div class="navbar-custom-menu">

                <span class="user-toggle">
                   <button class="logout" href="#" id="Logout"><i class="fas fa-sign-out-alt" alt="Logout works only when on Away, Break, Lunch and Meeting status"></i></button>
                    <img class="avatar" src="images/avatars/<% out.print(agentid); %>.png" alt="">
                    <span class="details">
                        <span class="name" id="Name"></span>
                        <span class="id" id="AgentID"></span>
                    </span>

                </span>
            </div>
        </nav>
 </section>