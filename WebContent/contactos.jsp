<%@page import="Servlets.Servlet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Site.DBInfo" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
	if (session == null){
		%>
		<jsp:forward page="index.jsp"></jsp:forward>
		<%
	}
	if (session.isNew() || session.getAttribute("userType") == null || session.getAttribute("userID") == null) {
		session.setAttribute("userType", "guest");
	}

session.setAttribute("origem", "contactos"); %>

<title>ISCTEstes</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js">
      </script>
    <![endif]-->
</head>
<body>
	<!-- INCLUDE TOPBAR CODE -->
	<jsp:include page="canvas/topbar.jsp"></jsp:include>
	<div class="container">
		<!-- INCLUDE HEADER CODE -->
		<jsp:include page="canvas/header.jsp"></jsp:include>
		<div class="row-fluid">
			<div class="well full-width">
				<fieldset>						
						<form method="post" action="servlet">
						  <div class="row">
								<div class="span4" style="margin-left: 40px;">
									<label>O teu nome</label>
									<input type="text" class="input-xlarge" name="nome">
									<label>O teu email</label>
									<input type="email" class="input-xlarge" name="mail">
								</div>
								<div class="span7 pull-right" style="margin-right: 10px;">
									<label>Mensagem</label>
									<textarea name="mensagem" id="message" class="input-xlarge span12" rows="7"></textarea>
									<button type="submit" class="btn btn-primary pull-right">Enviar</button>
								</div>
							</div>
						</form>
				
				</fieldset>
			</div>
		</div>
		<!-- INCLUDE FOOTER CODE -->
		<jsp:include page="canvas/footer.jsp"></jsp:include>
	</div>

	<!-- LOGIN FORM -->
	<jsp:include page="canvas/loginform.jsp"></jsp:include>

	<!-- REGISTRATION FORM -->
	<jsp:include page="canvas/regform.jsp"></jsp:include>

	<script src="http://code.jquery.com/jquery-1.9.1.min.js"
		type="text/javascript"></script>
	<script src="js/bootstrap.js" type="text/javascript"></script>
	<script src="js/custom.js" type="text/javascript"></script>
	<script src="js/jquery.validate.js" type="text/javascript"></script>
	<script src="js/bootstrap-filestyle.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		window.addEventListener("focus", function(event) {
			$.ajax({  
				type: "POST",  
				url: "servlet",  
				data: "focus=contactos",  
				success: function() {  
				}
			});
		}, false);
	</script>
	
</body>
</html>