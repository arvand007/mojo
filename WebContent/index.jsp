
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Login</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
  $( function() {
    $( "#date_box").datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#date_box_end").datepicker({ dateFormat: 'yy-mm-dd' });
  } );
</script>
<script type="text/javascript">
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
					url : "/OutboundDialerDesktop/DoLogin",
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
</script>

</head>
<body>
			
		<div id="Login">				
			Agent ID: <input type="text" name="agentid" id="agentid" class="agentid_box" />
			Extension: <input type="text" name="extension" id="extension" class="extension_box" value="16479857249" />
			Password: <input type="password" name="password" id="password" class="password_box" />
			<button name="login" value="Login" class="login_button" />Login</button><br />		
		</div>
		 <div id="messageDiv" style="display:none;"></div>
	
	
</body>
</html>