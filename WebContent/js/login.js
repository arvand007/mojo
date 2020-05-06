
  $(function() {
		$("form").submit(function() {
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
							$("#messageDiv").html('Inavlid login credintials. Please Try Again.');
							
							
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
  