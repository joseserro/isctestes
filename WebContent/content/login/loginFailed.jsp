<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ISCTE Exercicios</title>
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
		<div class="row-fluid">
			<div class="full-width">
				<div align="center" class="alert alert-error alert-block">
					<h4>Login falhado!</h4><br>
					Username e/ou password errados. Tenta novamente!<br><br>
					Se ainda não tens uma conta, <a href="#signupModal" data-toggle="modal">regista-te aqui</a>.<br>
					Se não tem lembras da password, <a href="#">clica aqui</a>.
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