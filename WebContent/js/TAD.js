	var countDownDate=new Date().getTime();; //used to display time elapsed on the desktop
	var connection=null;
	var SessiondId='';
	var State='';
	var Extension='';
	var Name='';
	var ErrorMsg='';
	var CallID='';
	var EverConnected=0;
	var Encryptionkey='';
	function ChangeState(str) {	
		
		sendMessage("State:"+str);
		document.getElementById("State").innerHTML = str;
		if(str=="Break" || str=="Ready" || str=="Lunch" || str=="Meeting" ){
			document.getElementById("screenpop").src = 'http://localhost:7020/GetCrashReports/?RP=';	
			document.getElementById("CustomerName").innerHTML = "Empty";	
			document.getElementById("CustomerPhone").innerHTML = "Empty";
		}	
		if(str=="Ready"){
			console.log("disbaling the logout button");
			document.getElementById("Logout").disabled = true;
			document.getElementById("State").className="online";
			document.getElementById("State2").className="online";
		}else{
			document.getElementById("Logout").disabled = false;
			document.getElementById("State").className="notready";
			document.getElementById("State2").className="notready";
		}
		
		// Set the date we're counting down to
		countDownDate =  new Date().getTime();			
	}

	function  openConnection() {
		console.log('openning connection....');
        if ("WebSocket" in window) { 
			console.log('WebSocket is supported by your browser.');
		 
			connection = new WebSocket('ws://192.168.0.23:9091');
			document.getElementById("State").innerHTML="Connecting";	
			connection.onopen = function () {
				console.log('Connected!');
				sendMessage('Ping'); // Send the message 'Ping' to the server
				SetAgentID(); //send the AgentID to the server to update the state database
				document.getElementById("State").innerHTML="Online";	
				document.getElementById("State").className="online";
				document.getElementById("State2").className="online";
				document.getElementById("SelectStates").disabled = false;
			};

			// Log errors
			connection.onerror = function (error) {
				console.log('WebSocket Error ' + error);
				document.getElementById("SelectStates").disabled = true;
				document.getElementById("State").innerHTML = "Offline";	
				document.getElementById("State").className="offline";
				document.getElementById("State2").className="offline";
				document.getElementById("CallNotification").innerHTML = "Connection Error...";
			};

			// Log messages from the server
			connection.onmessage = function (e) {
				console.log('Server: ' + e.data);
				if((e.data).includes("SessionID:")){
					SessiondId=e.data.substring(10);
					document.getElementById("SessionID").innerHTML = SessiondId;
				}else if((e.data).includes("State:")){
					State=e.data.substring(6);
					document.getElementById("State").innerHTML = State;
					if(State=="Break" || State=="Ready" || State=="Lunch" || State=="Meeting" ){
						document.getElementById("screenpop").src = 'http://localhost:7020/GetCrashReports/?RP=';
						document.getElementById("CustomerName").innerHTML = "Empty";	
						document.getElementById("CustomerPhone").innerHTML = "Empty";						
					}	
					if(State=="Reserved"){
						document.getElementById("SelectStates").disabled = true;
						document.getElementById("Logout").disabled = true;
					}	
				}else if((e.data).includes("Extension:")){
					Extension=e.data.substring(10);
					document.getElementById("Extension").innerHTML = Extension;	
					
				}else if((e.data).includes("Name:")){
					Name=e.data.substring(5);
					document.getElementById("Name").innerHTML = Name;
					
				}else if((e.data).includes("NewCall:")){
					CallID=e.data.substring(8);
					document.getElementById("CallNotification").innerHTML = 'New Call arriving From: '+CallID;
					document.getElementById("CustomerPhone").innerHTML = CallID;
					
				}else if((e.data).includes("Customer:")){
					CallID=e.data.substring(9);					
					document.getElementById("CustomerName").innerHTML = CallID;
					
				}else if((e.data).includes("NewCallinitiated:")){
					CallID=e.data.substring(17);
					document.getElementById("CallNotification").innerHTML = 'Ringing: '+CallID;	
					
				}else if((e.data).includes("NewCallanswered:")){
					CallID=e.data.substring(17);
					document.getElementById("CallNotification").innerHTML = 'Talking to '+CallID;	
				
				}else if((e.data).includes("NewCallReportNumber:")){
					CallID=e.data.substring(20);
					document.getElementById("screenpop").src = 'http://localhost:7020/GetCrashReports/?RP='+CallID;	
				
				}else if((e.data).includes("NewCallcompleted:")){
					CallID=e.data.substring(19);
					document.getElementById("CallNotification").innerHTML = 'No notifications...';	
					document.getElementById("SelectStates").disabled = false;
					document.getElementById("Logout").disabled = false;
					document.getElementById("SelectStates").value = 'Away';					
				}else if((e.data).includes("Error:")){
					ErrorMsg=e.data.substring(6);
					document.getElementById("CallNotification").innerHTML = ErrorMsg;
				}		
			};
		}
	}
	
	function closeConnection() {
		connection.close();
		document.getElementById("ErrorNotification").innerHTML="";
		document.getElementById("CallNotification").innerHTML="";
		document.getElementById("State").innerHTML="Offline";	
		document.getElementById("State").className="offline";
		document.getElementById("State2").className="offline";
    }

    function sendMessage(msg) {    
		connection.send(Encryptionkey+"|"+msg);
    }
	

function SetAgentID2(AgentID,AgentName,key,Ext) {			
		Encryptionkey=key;		
		document.getElementById("AgentID").innerHTML = AgentID;
		document.getElementById("Name").innerHTML = AgentName;
		var State=document.getElementById("State").innerHTML;	
		Extension=Ext;
		console.log("Extension:"+Extension);
}
	
function SetAgentID() {			
		var AgentID =document.getElementById("AgentID").innerHTML;		
		var State=document.getElementById("State").innerHTML;
		if(connection.readyState==1){
			sendMessage("AgentID:"+AgentID);
			console.log('Sending AgentID:'+AgentID+' to the Server');
			
			console.log('Sending Extension:'+Extension+' to the Server');	
			sendMessage("Extension:"+Extension);
			
			sendMessage("State:"+State);
			console.log('Sending State:'+State+' to the Server');	
			EverConnected=1;	
			//document.getElementById("ConnectionStatus").innerHTML="Online";				
		}
		
	}
	
	function getParameterByName(name, url) {
		if (!url) url = window.location.href;
		name = name.replace(/[\[\]]/g, "\\$&");
		var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
			results = regex.exec(url);
		if (!results) return null;
		if (!results[2]) return '';
		return decodeURIComponent(results[2].replace(/\+/g, " "));
	}
	
	
	$(function logout() {
		$(".logout").click(function() {
			connection.close();
			var SessionID = document.getElementById("SessionID").innerHTML;
			var data = 'SessionID=' + SessionID;
			$.ajax({
				type : "POST",
				url : "/OutboundDialerDesktop/DoLogout",
				data : data,
				beforeSend : function(html) { // this happen before actual call
								
				},
				success : function(html) { // this happen after we get result									
					$(location).attr('href','logout.jsp');					
				}
			});
		});
	});
	
	// Update the count down every 1 second
	var x = setInterval(function() {
	// Get todays date and time
		var now = new Date().getTime();
		
		// Find the distance between now an the count down date
		var distance =  now-countDownDate;
		
		// Time calculations for days, hours, minutes and seconds
		var days = Math.floor(distance / (1000 * 60 * 60 * 24));
		var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
		var seconds = Math.floor((distance % (1000 * 60)) / 1000);
		
		// Output the result in an element with id="TimeinState"
		document.getElementById("TimeinState").innerHTML ="[" + days + ":" + hours + ":"
		+ minutes + ":" + seconds + "]";     
		if(seconds==59&&State=="Reserved"){ //if stuck at the reserved state for more than  60 sec, automatically go to away
			ChangeState("Away");	
			document.getElementById("SelectStates").disabled = false;	
			document.getElementById("SelectStates").selectedIndex=0;
			document.getElementById("Logout").disabled = false;
		}	
	}, 1000);
	
	var isConnectionAlive = setInterval(function() {
		if(connection.readyState!=1){
			document.getElementById("SelectStates").disabled = true;
			document.getElementById("State").innerHTML = "Offline";
			document.getElementById("State").className="offline";
			document.getElementById("State2").className="offline";
			if(EverConnected==1){
				document.getElementById("CallNotification").innerHTML="Lost connection to the server!";
			}else{
				document.getElementById("CallNotification").innerHTML="Failed to connect to the server!";					
			}
			document.getElementById("State").innerHTML="Offline";
			document.getElementById("State").className="offline";
			document.getElementById("State2").className="offline";
			//document.getElementById("CallNotification").innerHTML = '';				
		}	
	}, 10000);
	
	var CallsinQ = setInterval(function() {
		
		var today = new Date();
		var dd = String(today.getDate()).padStart(2, '0');
		var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		var yyyy = today.getFullYear();
		var data = 'Queue=DialingList&Date='+yyyy + '-' + mm + '-' + dd+'&Encryptionkey='+Encryptionkey;
		$.ajax({
			type : "POST",
			url : "/OutboundDialerDesktop/CallsinQ",
			data : data,
			beforeSend : function(html) { // this happen before actual call
							
			},
			success : function(html) { // this happen after we get result	
				var res = html.split(",");
				document.getElementById("CallsinQ").innerHTML=res[2];					
			}
		});
	}, 5000);

	
	
	
	
  
