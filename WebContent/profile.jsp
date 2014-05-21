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
		session.setAttribute("guestAttempt","true");
		
		%>
		<jsp:forward page="index.jsp"></jsp:forward>
		<%
	}

session.setAttribute("origem", "perfil"); %>

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
						
			<div style="margin-top: -10px; margin-bottom: -20px;">
			<ul class="inline">
			
			<% 
			int id = 0;
			if(request.getParameter("id") == null) {
				id = Integer.parseInt((String)session.getAttribute("userID"));
			} else {
				id = Integer.parseInt(request.getParameter("id"));
			}
			
			String userType = (String) session.getAttribute("userType");
			String fullName = DBInfo.getUserName(id);
			int cursoid = DBInfo.getUserCursoID(id);
			String userCurso = DBInfo.getCursoName(cursoid);
			int userAno = DBInfo.getUserAno(id);
			String imgLink = DBInfo.getUserImage(id);
			String desc = DBInfo.getUserDesc(id);
			int nLikes = DBInfo.getNumberLikes(id);
			int nComments = DBInfo.getNumberComments(id);
			int filesSubmitted = DBInfo.getNumberFilesUser(id);
			
			%>
				<li><h5><b><%= fullName %></b></h5></li>
			</ul>
			</div>
				<hr>
				<div class="row-fluid" style="margin-top: 10px;">
					<div class="span2">
						<a class="thumbnail"> <img
							src="<%= imgLink %>" alt="">
						</a>
					</div>
					<div class="span9">
						<p><b>Curso:</b> <%= userCurso %>&nbsp; &nbsp; &nbsp;<b>Ano:</b> <%= userAno %>º ano 
						<p><b>Descrição pessoal:</b></p>
						<p><%= desc %></p>
					</div>
				</div>
				<div class="row-fluid" style="margin-top: 10px;">
					<span class="label label-success">&nbsp;<%= nLikes %> likes efectuados&nbsp;</span>&nbsp;
					<span class="label label-warning">&nbsp;<%= nComments %> comentários&nbsp;</span>&nbsp;
					<span class="label label-inverse">&nbsp;<%= filesSubmitted %> ficheiros enviados&nbsp;</span>
					<% if(session.getAttribute("userID").equals(""+id)) { %>
						<a href="editprofile.jsp">
						<button class="btn btn-info pull-right">&nbsp;Editar perfil&nbsp;</button>
						</a>
					<% } else if(userType.equals("admin")) { %>
					<form action="/servlet" method="post">	
						<div class="btn-group pull-right">
							<button type="submit" name="delUser" value="<%=id%>" class="btn btn-warning">&nbsp;Eliminar utilizador&nbsp;</button>
							<a href="editprofile.jsp" class="btn btn-info">&nbsp;Editar perfil&nbsp;</a>
						</div>
					</form>
					<% } %>
				</div>
				
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
				data: "focus=perfil",  
				success: function() {  
				}
			});
		}, false);
	</script>
	
</body>
</html>