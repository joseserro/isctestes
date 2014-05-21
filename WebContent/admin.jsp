<%@page import="Servlets.Servlet"%>
<%@page import="Site.*"%>
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

session.setAttribute("origem", "admin"); %>

<title>ISCTEstes Admin</title>
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
			<div class="row-fluid">
				<%
				String userType = (String) session.getAttribute("userType");
				if(!"admin".equals(userType)){
					response.sendRedirect("/");
				}
				
				int uid,cid,mid;
				if(!("".equals(request.getParameter("mid")) || request.getParameter("mid")==null)){
					mid = Integer.parseInt(request.getParameter("mid"));
					ArrayList<String>mss = DBInfo.getMessage(mid);
					DBUtil.readMessage(mid);
					%>
						<div class="well">
							<form action="/servlet" method="POST">
								<div class="btn-group">
									<a href="/admin.jsp" class="btn btn-small"><i class="icon-arrow-left"></i>&nbsp;Back</a>
									<button type="submit" class="btn btn-small btn-danger" name="deleteMessage" value="<%=mid%>"><i class="icon-warning-sign"></i>&nbsp;Eliminar</button>
								</div>
							</form>
							<h4>Mensagem de <%=mss.get(2) %> (<%=mss.get(3) %>):</h4>
							<p><%=mss.get(4) %></p>
						</div>
					<%
				} else {
				%>
				<div class="well span4">
					<ul class="nav nav-list nav-stacked">
						<li class="nav-header">Utilizadores</li>
						<%
						for(ArrayList<String> listIn : DBInfo.getAllUsers()){
							int id = Integer.parseInt(listIn.get(3));
						%>
							
							<li><a href="profile.jsp?id=<%=id%>"><%=DBInfo.getUserName(id)%></a></li>
						<% } %>
					</ul>
				</div>
				<div class="well span4">
					<ul class="nav nav-list nav-stacked">
						<li class="nav-header">Reports de Conteúdo</li>
						<% 
						for(ArrayList<String> listIn : DBInfo.getAllReported()){
							int id = Integer.parseInt(listIn.get(0));
						%>
							<li><a href="conteudo.jsp?cid=<%=id%>"><%=listIn.get(2)%></a></li>
						<% } %>
					</ul>
				</div>
				<div class="well span4">
					<ul class="nav nav-list nav-stacked">
						<li class="nav-header">Mensagens</li>
						<% 
						for(ArrayList<String> listIn : DBInfo.getAllMessages()){
							int id = Integer.parseInt(listIn.get(0));
							
						%>
							<li <% if(listIn.get(5).equals("0")){out.println(" class=\"active\"");} %>><a href="admin.jsp?mid=<%=id%>">Mensagem de <%=listIn.get(2)%></a></li>
						<% } %>
					</ul>
				</div>
				<% } %>
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
				data: "focus=admin",  
				success: function() {  
				}
			});
		}, false);
	</script>
	
</body>
</html>