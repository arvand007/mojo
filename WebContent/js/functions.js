
  $( function() {
    $( "#date_box").datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#date_box").datepicker('setDate', new Date());
  } );
  
  $(document).ready(function(){	  
	  $("#date_box").change(function(){
		  
		  var Date= $("#date_box").val();
			var data = 'Queue=DialingList&Date='+Date+'&Encryptionkey='+Encryptionkey;
			$.ajax({
				type : "POST",
				url : "./CallsinQReport",
				data : data,
				beforeSend : function(html) { // this happen before actual call
					$("#QueueReportStatus").show();
					$("#QueueReportStatus").html('Populating Results...');
								
				},
				success : function(html) { // this happen after we get result	
					var res = html.split(",");
					$("#QueueReportStatus").html('');
					$("#QueueReportTable").html('');
					$("#QueueReportTable").append(html);
				}
		  } )
	  });
	});
  
  $(document).ready(function(){	
	  $( function() {
		   console.log('Encryptionkey='+Encryptionkey);
		    var Date= $("#date_box").val();
			var data = 'Queue=DialingList&Date='+Date+'&Encryptionkey='+Encryptionkey;
			$.ajax({
				type : "POST",
				url : "./CallsinQReport",
				data : data,
				beforeSend : function(html) { // this happen before actual call
					$("#QueueReportStatus").show();
					$("#QueueReportStatus").html('Populating Results...');			
				},
				success : function(html) { // this happen after we get result	
					var res = html.split(",");
					$("#QueueReportStatus").html('');
					$("#QueueReportTable").html('');
					$("#QueueReportTable").append(html);
				}
		  } )
	  });
  });
  
  var CallsinQ = setInterval(function() {
		
		var Date= $("#date_box").val();
	
		var data = 'Queue=DialingList&Date='+Date+'&Encryptionkey='+Encryptionkey;
		$.ajax({
			type : "POST",
			url : "./CallsinQ",
			data : data,
			beforeSend : function(html) { // this happen before actual call
							
			},
			success : function(html) { // this happen after we get result	
				var res = html.split(",");
				document.getElementById("Total Records").innerHTML=res[0];		
				document.getElementById("Called").innerHTML=res[1];	
				document.getElementById("Remaining").innerHTML=res[2];	
			}
		});
	}, 5000);
  
  function SetKey(key) {			
	    Encryptionkey=key;	
  }
  
  $(function() {
		$(".login_button").click(function() {
			// hetting the value that user typed
			var agentid = $("#agentid").val();
			var extension = $("#extension").val();
			var password = $("#password").val();
		
			// forming the queryString
			var data = 'agentid=' + agentid + '&extension='+extension+ '&password='+password;

			// if agentid and password are not empty
			if (password&&agentid) {
				// ajax call
				$.ajax({
					type : "POST",
					url : "./DoLogin",
					data : data,
					beforeSend : function(html) { // this happen before actual call
						$("#messageDiv").html('Please Wait...');					
					},
					success : function(html) { // this happen after we get result
						$("#messageDiv").html('');
						$("#messageDiv").show();
						//$("#messageDiv").append(html);
					
						if(html.includes("Successful")){						
							$(location).attr('href','TAD.jsp');
						}else if(html.includes("Failed")){						
							$("#messageDiv").html('');
							$("#messageDiv").show();
							$("#messageDiv").append(html);
						}
					}
				});
			}else{				
				$("#messageDiv").show();
				$("#messageDiv").html('Error: Agent ID and Password are required');	
			}
			return false;
		});
	});
  