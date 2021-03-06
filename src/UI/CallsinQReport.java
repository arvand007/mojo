package UI;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import UI.db.DBConnection;
import UI.db.ReportObject;

/**
 * Servlet implementation class CallsinQReport
 */
@WebServlet("/CallsinQReport")
public class CallsinQReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = LogManager.getLogger(CallsinQReport.class);    
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CallsinQReport() {
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
		String Queue=request.getParameter("Queue");			
		String Date=request.getParameter("Date");
		String EncryptionKey=request.getParameter("Encryptionkey");
		HttpSession session = request.getSession(true);	   
		String SessionEncryptionKey=(String) session.getAttribute("encryptionKey");				
		logger.info("Queue: "+Queue +" Date: "+Date+" EncryptionKey: "+EncryptionKey+" SessionEncryptionKey: "+SessionEncryptionKey );
		if(EncryptionKey!=null&&SessionEncryptionKey!=null&&EncryptionKey.equals(SessionEncryptionKey)) {
			try {
				Vector<ReportObject> Reports=DBConnection.CallsinQTable(Queue, Date);
				logger.info("There are "+Reports.size()+" in the table "+Queue);
	
				for (int i=0; i<Reports.size(); i++) {
					response.getWriter().println(Reports.get(i).getID()+"|"+Reports.get(i).getPhoneNumber()+"|"+Reports.get(i).getName()+"|"+Reports.get(i).getReportNumber()+"|"+Reports.get(i).getDateAdded()
							+"|"+Reports.get(i).getAgentID()+"|"+Reports.get(i).getDateTime()+"|"+Reports.get(i).getStatus());
				}
	
	
				DBConnection.CloseConnection();
			}catch(Exception e){
				e.printStackTrace();
	
				response.getWriter().println("Error: Could not obtain the list for: "+Queue);
			}
		}else {
			response.getWriter().println("Encryption Error: Could not obtain the list for: "+Queue);
		}
	}
	
	/**
     * Convert a result set into a XML List
     * @param resultSet
     * @return a XML String with list elements
     * @throws Exception if something happens
     */
   

}
