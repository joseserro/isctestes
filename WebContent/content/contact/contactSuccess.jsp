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
		<div class="row-fluid">
			<div class="full-width">
				<div align="center" class="alert alert-info alert-block">
					<h4>Mensagem enviada com sucesso!</h4><br>
					A tua mensagem foi enviada com sucesso.<br>
					Geralmente, respondemos às mensagens entre 24 e 48 horas após o envio.<br>
					Por favor, aguarda pacientemente pela nossa resposta. Serás contactado posteriormente por email.<br><br>
					Obrigado!
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