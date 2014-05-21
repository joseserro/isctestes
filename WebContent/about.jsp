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
	if (session.isNew() || session.getAttribute("userType") == null || session.getAttribute("userID") == null) {
		session.setAttribute("userType", "guest");
	}

session.setAttribute("origem", "acerca"); %>

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
			<p align="center"><b>Acerca</b></p><br>
			<p>Este website � um projecto que foi desenvolvido para a cadeira de Programa��o em Rede
			do curso de Engenharia Inform�tica do ISCTE. Trata-se de uma aplica��o que cont�m recursos
			�teis para os estudantes do ISCTE, pois cont�m enunciados de exames, frequ�ncias, trabalhos,
			testes e as suas respectivas resolu��es, de todas as cadeiras existentes no ISCTE.</p>
			<p>Todos os conte�dos aqui publicados s�o de inteira exclusividade dos estudantes do ISCTE.</p> 
			</div>
			<div class="well full-width">
				<fieldset>
						
			<div style="margin-top: -10px; margin-bottom: -20px;">
			<ul class="inline">
			
				<li><h5><b>Ant�nio Raimundo</b></h5></li>
			</ul>
			</div>
				<hr>
				<div class="row-fluid" style="margin-top: 10px;">
					<div class="span2">
						<a class="thumbnail"> <img
							src="https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-ash3/535118_3173163416522_612179189_n.jpg" alt="">
						</a>
					</div>
					<div class="span9">
						<p><b>Curso:</b> Engenharia inform�tica&nbsp; &nbsp; &nbsp;<b>Ano:</b> 2� ano 
						<p><b>Descri��o pessoal:</b></p>
						<p>Boas a todos!<br>O meu nome � Ant�nio Raimundo, tenho 21 anos e 
						sou de Santar�m. Sou estudante universit�rio do Instituto Superior
						 de Ci�ncias do Trabalho e Empresas (ISCTE). Sou amante da noite, 
						 da m�sica electr�nica e da bebida ;)</p><p><b>Cita��o favorita:</b> 
						 "<i>� toda a noite!</i>" </p>
					</div>
				</div>
				
				</fieldset>
				<br>
				<fieldset>
						
			<div style="margin-top: -10px; margin-bottom: -20px;">
			<ul class="inline">
			
				<li><h5><b>Jos� Serro</b></h5></li>
			</ul>
			</div>
				<hr>
				<div class="row-fluid" style="margin-top: 10px;">
					<div class="span2">
						<a class="thumbnail"> <img
							src="https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-frc1/377503_2458303932833_969841648_n.jpg" alt="">
						</a>
					</div>
					<div class="span9">
						<p><b>Curso:</b> Engenharia inform�tica&nbsp; &nbsp; &nbsp;<b>Ano:</b> 2� ano 
						<p><b>Descri��o pessoal:</b></p>
						<p>Boas!<br>Chamo-me Jos� Serro, tenho 19 anos e 
						sou de Lagos. Sou tamb�m um estudante universit�rio do Instituto Superior
						 de Ci�ncias do Trabalho e Empresas (ISCTE). Gosto de tudo o que seja
						 relacionado com o espa�o, e por isso, fui o primeiro portugu�s a 
						 candidatar-se para uma viagem a Marte.</p>
						<p><b>Cita��o favorita:</b> "<i>Quero ir para o Algarve!</i>"</p>
					</div>
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