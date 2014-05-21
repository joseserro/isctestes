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
	if (session.isNew() || session.getAttribute("userType") == null) {
		session.setAttribute("userType", "guest");
		session.setAttribute("guestAttempt","false");
	}

session.setAttribute("origem", "cursos"); %>

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
			<div class="full-width">
				<div class="well">
					<form name="listaCursos" action="servlet" method="post">
						<ul class="nav nav-pills nav-stacked" style="text-align: center;">
						<% 
						
						String userType = (String) session.getAttribute("userType");
						if(userType.equals("guest")){
							session.setAttribute("guestAttempt","true");
							response.sendRedirect("/");
						}
						
						ArrayList<String> list = DBInfo.getAllCursos();
						for(String s : list) { %>
							
							<li><input class="cinput" type="submit" name="cursos" value="<%=s%>"></li>
						<% } %>
						</ul>
					</form>
				</div>
			</div>
		</div>
		<!-- INCLUDE FOOTER CODE -->
		<jsp:include page="canvas/footer.jsp"></jsp:include>
	</div>

	<!-- LOGIN FORM -->
	<jsp:include page="canvas/loginform.jsp"></jsp:include>

	<!-- REGISTRATION FORM -->
	<jsp:include page="canvas/regform.jsp"></jsp:include>

	<script src="http://code.jquery.com/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.js" type="text/javascript"></script>
	<script src="js/custom.js" type="text/javascript"></script>
	<script src="js/jquery.validate.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		window.addEventListener("focus", function(event) {
			$.ajax({  
				type: "POST",  
				url: "servlet",  
				data: "focus=cursos",  
				success: function() {  
				}
			});
		}, false);
	</script>
	
</body>
</html>
