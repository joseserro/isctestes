<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="Site.DBInfo"%>
<%@page import="Site.DBUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	if (session.isNew()) {
		session.setAttribute("userType", "guest");
	}
%>
<title>ISCTEstes</title>
<link href="../../css/bootstrap.css" rel="stylesheet">
<link href="../../css/bootstrap-responsive.css" rel="stylesheet">
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js">
      </script>
    <![endif]-->
</head>
<body>

	<!-- INCLUDE TOPBAR CODE -->
	<jsp:include page="../../canvas/topbar.jsp"></jsp:include>
	<div class="container">
		<!-- INCLUDE HEADER CODE -->
		<jsp:include page="../../canvas/header.jsp"></jsp:include>
		<%
			String confirm = request.getParameter("confirm");
			boolean success = DBUtil.confirmEmail(confirm);
		%>
		
		<div class="row-fluid">
			<div class="full-width">
				<% if(success){ 
					session.setAttribute("userType", "registered");
				%>
				<div align="center" class="alert alert-info alert-block">
					<h4>Confirmaste o teu registo com sucesso!</h4><br>
					Estás agora confirmado como um aluno do ISCTE!<br>
					Já estás apto a utilizar todos recursos do site.<br>
					Sê muito bem-vindo! <br><br>
					Se tiveres alguma dúvida, consulta a <a href="/faq.jsp">FAQ</a>, ou então <a href="/contactos.jsp">contacta-nos</a>.
					<br>Obrigado!
				</div>
				<% } else { %>
				<div align="center" class="alert alert-error alert-block">
					<h4>A confirmação falhou!</h4><br>
					Alguma coisa correu mal!<br><br>
					Se tiveres alguma dúvida, consulta a <a href="/faq.jsp">FAQ</a>, ou então <a href="/contactos.jsp">contacta-nos</a>.
					<br>Obrigado!
				</div>
				<% } %>
			</div>
		</div>
		<!-- INCLUDE FOOTER CODE -->
		<jsp:include page="../../canvas/footer.jsp"></jsp:include>
	</div>

	<!-- LOGIN FORM -->
	<jsp:include page="../../canvas/loginform.jsp"></jsp:include>

	<!-- REGISTRATION FORM -->
	<jsp:include page="../../canvas/regform.jsp"></jsp:include>

	<script src="http://code.jquery.com/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="../../js/bootstrap.js" type="text/javascript"></script>
	<script src="../../js/custom.js" type="text/javascript"></script>
	<script src="../../js/jquery.validate.js" type="text/javascript"></script>

</body>
</html>