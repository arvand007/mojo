package UI.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.sql.Date;
import java.sql.PreparedStatement;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

public class DBConnection {
	Logger logger = LogManager.getLogger(DBConnection.class);
	private JdbcConnection JdbcConnection;

	public DBConnection() {
		
		JdbcConnection = new JdbcConnection();
	}
	//**********************change everything to use prepare statement*************
	
	public String CheckUSerPass(String AgentID, String pass) {
		String Name=null;
				
		String Query="SELECT * FROM public.\"Agents\" where \"AgentID\" ='"+AgentID+"' AND \"pin\"='"+pass+"'";
		logger.info(Query); 
		
		ResultSet RS=JdbcConnection.ExecuteQuery(Query);
		try {
			if (RS.next()) {
				String  FistName= RS.getString("FistName");				
				String  LastName= RS.getString("LastName");
				Name=FistName+" "+LastName;
			}
				
		} catch (SQLException e) {
			
			logger.error(e.toString());
			e.printStackTrace();
			
		}
		return Name;
	}
	
	public boolean Logout(String SessionID) {
		boolean returnData=true;
		String Query="DELETE FROM public.\"Sessions\" WHERE \"SessionID\"='"+SessionID+"'";
		logger.info(Query); 
		returnData=JdbcConnection.executeUpdate(Query); 
		return returnData;
	}
	
	public int[] CallsinQ(String Queue, String localDateTime) {
		DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd");
		DateTime dt = formatter.parseDateTime(localDateTime);
		logger.info("CallsinQueue since date: "+dt.toString()); 
		int Queuestat[]=new int[3];
		int TotalRecords=0;
		int RecordsCalled=0;
		int RecordsRemaining=0;
		if("DialingList".equals(Queue)) {
			try {
				String Query="SELECT count(\"ID\") as Counter FROM public.\"DialingList\" WHERE \"DateAdded\" >='"+localDateTime+"'";
				logger.info(Query); 
				ResultSet RS=JdbcConnection.ExecuteQuery(Query); 	
				RS.next();
				TotalRecords= RS.getInt("Counter");
				
				Query="SELECT count(\"ID\") as Counter FROM public.\"DialingList\" WHERE \"DateAdded\" >='"+localDateTime+"' and \"Status\" is not null";
				logger.info(Query); 
				RS=JdbcConnection.ExecuteQuery(Query); 	
				RS.next();
				RecordsCalled= RS.getInt("Counter");
				RecordsRemaining=TotalRecords-RecordsCalled;
				Queuestat[0]=TotalRecords;
				Queuestat[1]=RecordsCalled;
				Queuestat[2]=RecordsRemaining;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return Queuestat;
	}
	
	
	public Vector<ReportObject> CallsinQTable(String Queue, String localDateTime) {
		DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd");
		DateTime dt = formatter.parseDateTime(localDateTime);
		logger.info("CallsinQueue since date: "+dt.toString()); 
		
		Vector<ReportObject> Reports=new Vector<ReportObject>();
		if("DialingList".equals(Queue)) {
			try {
				String Query="SELECT * FROM public.\"DialingList\" WHERE \"DateAdded\" >='"+localDateTime+"'";
				logger.info(Query); 
				ResultSet RS=JdbcConnection.ExecuteQuery(Query); 
				
				while(RS.next()) {
					int ID= RS.getInt("ID");
					String PhoneNumber= RS.getString("PhoneNumber");
					String Name= RS.getString("Name");
					String ReportNumber= RS.getString("ReportNumber");
					Date DateAdded= RS.getDate("DateAdded");
					String AgentID= RS.getString("AgentID");					
					Date DateTime= RS.getDate("DateTime");
					String Status= RS.getString("Status");
					ReportObject ReportObject=new ReportObject(ID,PhoneNumber,Name,ReportNumber,DateAdded,AgentID,DateTime,Status);
					Reports.add(ReportObject);
				}	
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return Reports;
	}
	
	
	
	//change everything to use prepare statement
	public boolean UpdateSession(String AgentID, String encryptionKey) {
		boolean returnData=true;
		
		DateTime localDateTime = new DateTime();
		DateTimeZone dtz = DateTimeZone.forID("America/New_York");
		logger.info("localDateTime : " + localDateTime.toString());
		
		//Delete old session first
		String Query="DELETE FROM public.\"Sessions\" WHERE \"AgentID\"='"+AgentID+"'";
		logger.info(Query); 
		returnData=JdbcConnection.executeUpdate(Query);
					
		Query="INSERT INTO public.\"Sessions\"(\"EncryptedKey\", \"AgentID\", \"DateTime\", \"IP\") VALUES ('"+encryptionKey+"','"+AgentID+"','"+localDateTime.toString()+"','"+null+"')";
		logger.info(Query); 
		returnData=JdbcConnection.executeUpdate(Query); 
		
		return returnData;
	}
	
	public boolean UpdateAgentState(String AgentID, String State) {
		boolean returnData=true;
		DateTime localDateTime = new DateTime();
		DateTimeZone dtz = DateTimeZone.forID("America/New_York");
		logger.info("localDateTime : " + localDateTime.toString());
		
		//Delete old session first
		String Query="DELETE FROM public.\"AgentStates\" WHERE \"AgentID\"='"+AgentID+"'";
		logger.info(Query); 
		returnData=JdbcConnection.executeUpdate(Query);
		
		Query="INSERT INTO public.\"AgentStates\"(\"AgentID\", \"State\", \"DateTime\") VALUES ('"+AgentID+"','"+State+"','"+localDateTime.toString()+"')";
		logger.info(Query); 
		returnData=JdbcConnection.executeUpdate(Query); 
		
		return returnData;
	}
	
	public String[] GetNameAndExt(String AgentID) {
		String[] Result=new String[2];
		String Query="SELECT * FROM public.\"Agents\" where \"AgentID\" ='"+AgentID+"';";
		logger.info(Query); 
		ResultSet RS=JdbcConnection.ExecuteQuery(Query);
		try {
			if (RS.next()) {
				String  FistName= RS.getString("FistName");
				
				String  LastName= RS.getString("LastName");
				Result[0]=FistName+" "+LastName;
				
				String  EXT= RS.getString("EXT");
				Result[1]=EXT;
				
			}	
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error(e.toString());
			e.printStackTrace();
		}
		return Result;
	}
	
	public String[] NextNumberToDial(String AgentID) {//need to modify those who have statuses such as answering, not pickup etc
		String Result[]=new String[4];
		boolean ReserveResult=false;
		String Query="SELECT * FROM public.\"DialingList\" where \"Status\" is NULL ORDER BY \"DateTime\" ASC LIMIT 1";
		logger.info(Query); 
		ResultSet RS=JdbcConnection.ExecuteQuery(Query);
		try {
			if (RS.next()) {
				String PhoneNumber= RS.getString("PhoneNumber");
				String DialingListID= RS.getString("ID");
				String ReportNumber= RS.getString("ReportNumber");
				String CustomerName= RS.getString("Name");
				Result[0]=PhoneNumber;
				Result[1]=ReportNumber;
				Result[2]=DialingListID;
				Result[3]=CustomerName;
				ReserveResult=ReserveAgentAndNumber(AgentID,DialingListID);
				logger.info(ReserveResult); 
			}	
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error(e.toString());
			e.printStackTrace();
		}
		if(ReserveResult) {
			return Result;
		}else {
			return null;
		}
	}
	
	private boolean ReserveAgentAndNumber(String AgentID, String DialingListID) {	
		boolean returnData1=true;
		boolean returnData2=true;
		DateTime localDateTime = new DateTime();
		DateTimeZone dtz = DateTimeZone.forID("America/New_York");
		logger.info("localDateTime : " + localDateTime.toString());
		String Query="UPDATE public.\"DialingList\" SET \"AgentID\"='"+AgentID+"', \"Status\"='Reserved', \"DateTime\"='"+localDateTime.toString()+"' WHERE \"ID\"="+DialingListID;
		logger.info(Query); 
		returnData1=JdbcConnection.executeUpdate(Query);
		returnData2=UpdateAgentState(AgentID, "Reserved");		
		if(returnData1&&returnData2) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean UpdateDialingListStatus(String DialingListID,String AgentID, String State) {	
		boolean returnData1=true;
		boolean returnData2=true;
		DateTime localDateTime = new DateTime();
		DateTimeZone dtz = DateTimeZone.forID("America/New_York");
		logger.info("localDateTime : " + localDateTime.toString());
		String Query="UPDATE public.\"DialingList\" SET \"Status\"='"+State+"', \"DateTime\"='"+localDateTime.toString()+"' WHERE \"ID\"="+DialingListID;
		logger.info(Query); 
		returnData1=JdbcConnection.executeUpdate(Query);
		returnData2=UpdateAgentState(AgentID, State);		
		if(returnData1&&returnData2) {
			return true;
		}else {
			return false;
		}
	}
	
		
	public boolean CloseConnection() {
		return JdbcConnection.CloseConnection();
	}
	
	
}
