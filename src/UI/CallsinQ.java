package UI;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import UI.db.DBConnection;

/**
 * Servlet implementation class CallsinQ
 */
@WebServlet("/CallsinQ")
public class CallsinQ extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = LogManager.getLogger(CallsinQ.class);  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CallsinQ() {
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
		try {
					
			String Queue=request.getParameter("Queue");	
			String Date=request.getParameter("Date");
			String EncryptionKey=request.getParameter("Encryptionkey");
			HttpSession session = request.getSession(true);	   
			String SessionEncryptionKey=(String) session.getAttribute("encryptionKey");				
			logger.info("Queue: "+Queue +" Date: "+Date+" EncryptionKey: "+EncryptionKey+" SessionEncryptionKey: "+SessionEncryptionKey );
			if(EncryptionKey!=null&&SessionEncryptionKey!=null&&EncryptionKey.equals(SessionEncryptionKey)) {
				DBConnection DBConnection=new DBConnection();	
				int QueueStat[]=DBConnection.CallsinQ(Queue, Date);
				logger.info(QueueStat[0]+","+QueueStat[1]+","+QueueStat[2]);
				response.getWriter().println(QueueStat[0]+","+QueueStat[1]+","+QueueStat[2]);
				DBConnection.CloseConnection();
			}else {
				logger.info("Encryptionkeh error");
				int QueueStat[]=new int[3];
				QueueStat[0]=-1;
				QueueStat[1]=-1;
				QueueStat[2]=-1;
				response.getWriter().println(QueueStat[0]+","+QueueStat[1]+","+QueueStat[2]);
			}
		}catch(Exception e){
			e.printStackTrace();
			int QueueStat[]=new int[3];
			QueueStat[0]=0;
			QueueStat[1]=0;
			QueueStat[2]=0;
			response.getWriter().println(QueueStat[0]+","+QueueStat[1]+","+QueueStat[2]);
		}
	
	}

}
