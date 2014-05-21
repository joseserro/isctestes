<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
			int reason = Integer.parseInt(request.getParameter("r"));
		%>
		
		<div class="row-fluid">
			<div class="full-width">
				<div align="center" class="alert alert-error alert-block">
					<h4>Registo falhou!</h4><br>
					
					<% switch(reason){
					case 1:
					%>
						O enderço de email que introduziste já existe na nossa base de dados!<br>
					<% break;
					case 2:
					%>
						O primeiro e segundo nome não podem estar vazios!<br>
					<% break;
					case 3:
					%>
						A password tem de ter pelo menos 6 caracteres!<br>
					<% break;
					case 4:
					%>
						Esse curso não existe!<br>
					<% break;
					case 5:
					%>
						O ano tem de ser um número entre 1 e 5!<br>
					<% break;
					case 6:
					%>
						O email tem de ser @iscte-iul.pt!<br>
					<% break;
					} %>
					Tenta novamente, usando o botão '<b>Registar</b>' acima. <br><br>
					Se tiveres alguma dúvida, consulta a <a href="/faq.jsp">FAQ</a>, ou então <a href="/contactos.jsp">contacta-nos</a>.
					<br>Obrigado!
				</div>
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