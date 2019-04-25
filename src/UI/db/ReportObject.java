package UI.db;

import java.sql.Date;

public class ReportObject {
	int ID; 
	String PhoneNumber;
	String Name;
	String ReportNumber;
	Date DateAdded;
	String AgentID; 					
	Date DateTime;
	String Status;
	
	public ReportObject(int iD, String phoneNumber, String name, String reportNumber, Date dateAdded,
			String agentID, Date dateTime, String status) {
		super();
		ID = iD;
		PhoneNumber = phoneNumber;
		Name = name;
		ReportNumber = reportNumber;
		DateAdded = dateAdded;
		AgentID = agentID;
		DateTime = dateTime;
		Status = status;
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getPhoneNumber() {
		return PhoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		PhoneNumber = phoneNumber;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public String getReportNumber() {
		return ReportNumber;
	}

	public void setReportNumber(String reportNumber) {
		ReportNumber = reportNumber;
	}

	public Date getDateAdded() {
		return DateAdded;
	}

	public void setDateAdded(Date dateAdded) {
		DateAdded = dateAdded;
	}

	public String getAgentID() {
		return AgentID;
	}

	public void setAgentID(String agentID) {
		AgentID = agentID;
	}

	public Date getDateTime() {
		return DateTime;
	}

	public void setDateTime(Date dateTime) {
		DateTime = dateTime;
	}

	public String getStatus() {
		return Status;
	}

	public void setStatus(String status) {
		Status = status;
	}
	


	
}
