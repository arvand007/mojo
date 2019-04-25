
<%@ page import="java.io.*,java.util.*" %>
<%
	String Page=(String)request.getParameter("Page");
	String TADClass="";
	String CallsinQClass="";
	String AdminClass="";
	if(Page.equals("TAD")){
		TADClass="active";
	}else if(Page.equals("CallsinQ")){
		CallsinQClass="active";
	}else if(Page.equals("Admin")){
		AdminClass="active";
	}
%>
<aside class="main-sidebar">
        <div class="menu-sidebar">
            <ul>
                <li class="<% out.print(TADClass); %>"><a href="#"><i class="fas fa-phone-square"></i><span>Agent Desktop</span></a></li>
                <li><a href="#" class="<% out.print(CallsinQClass); %>"><i class="fas fa-users"></i></i><span>Calls in Q</span></a></li>
                <li><a href="#" class="<% out.print(AdminClass); %>"><i class="fas fa-cog"></i><span>Admin</span></a></li>                
            </ul>
        </div>
 </aside>