package UI;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;

import UI.db.DBConnection;

/**
 * Servlet implementation class DoLogin
 */
@WebServlet("/DoLogin")
public class DoLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DoLogin() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DBConnection DBConnection=new DBConnection();
		String agentid=request.getParameter("agentid");
		String extension=request.getParameter("extension");
		String password=request.getParameter("password");

		//write a method to check for valid login credintial
		String AgentName=DBConnection.CheckUSerPass(agentid, password);
		if(AgentName!=null) {
			String encryptionKey= GeneratinEncryptionKey(); //create a function to assign the unique encryption key	        
			//insert into db
			boolean UpdateResult=DBConnection.UpdateSession(agentid, encryptionKey);
			if(UpdateResult) {
				response.getWriter().println("Successful");
				HttpSession session = request.getSession(true);	    
				session.setMaxInactiveInterval(-1); //never expires
				System.out.println("session created: "+session.getId());
				session.setAttribute("agentid",agentid); 
				session.setAttribute("AgentName",AgentName); 
				session.setAttribute("extension",extension); 
				session.setAttribute("encryptionKey",encryptionKey); 
			}else {
				response.getWriter().println("Failed");
			}
			

		}else {
			response.getWriter().println("Failed");
		}
		DBConnection.CloseConnection();
	}
	
	private String GeneratinEncryptionKey() {
	    String generatedString = RandomStringUtils.randomAlphanumeric(10);
	 
	    return generatedString;
	}

}
