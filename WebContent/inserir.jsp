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
%>
<% session.setAttribute("origem", "enviar"); %>

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
			<div class="well full-width" style="padding-left: 200px; padding-right: 200px;">
				<form class="form-horizontal" method="post">
					<fieldset>
						<%
						String userType = (String) session.getAttribute("userType");
						if(userType.equals("guest")){
							session.setAttribute("guestAttempt","true");
							response.sendRedirect("/");
						}
						
						String cursoEscolhido = request.getParameter("selectcurso");
						
						if(cursoEscolhido == null) {
							cursoEscolhido = "Escolhe um curso...";
						%>
						<!-- Select Basic -->
						<div class="control-group">
							<label class="control-label">Curso</label>
							<div class="controls">
								<select id="selectcurso" name="selectcurso" class="input-xlarge"
								onchange="this.form.submit();">
								<option selected="selected">Escolhe um curso...</option>
								<% 
								ArrayList<String> list = DBInfo.getAllCursos();
								for(String s : list) { %>
								
								<option><%=s%></option>
								<% } %>
								</select>
							</div>
						</div>
						<% } 
						if(!cursoEscolhido.equals("Escolhe um curso...")) {
						%>
						<!-- Select Basic -->
						<div class="control-group">
							<label class="control-label">Cadeira</label>
							<div class="controls">
								<select id="selectcadeira" name="selectcadeira" class="input-xlarge">
								<option selected="selected">Escolhe uma cadeira...</option>
								<% 
								ArrayList<String> list1 = DBInfo.getAllCadeirasFromCurso(request.getParameter("selectcurso"));
								for(String s : list1) { %>
								
								<option><%=s%></option>
								
								<% } %>
								</select>
							</div>
						</div>
						<% } %>
						
						<!-- Form Name -->
						<legend>Enviar conteúdos</legend>
						
						<!-- File Button -->
						<div class="control-group">
							<label class="control-label">Link</label>
							<div class="controls">
								<input type="text" id="link" name="link" class="input-xlarge required"
								placeholder="Insira o link externo para o ficheiro.">
								<span class="add-on"><i class="icon-info"></i></span>
								<a href="http://filedropper.com" target="_blank" class="btn" id="urlinfo" data-toggle="tooltip"
								title="Utilize o FileDropper.com" data-placement="bottom">
								<i class="icon-info-sign"></i></a>	
							</div>
						</div>
						
						<!-- Title -->
						<div class="control-group">
							<label class="control-label">Título</label>
							<div class="controls">
								<input type="text" id="title" name="title" class="input-xlarge required">
							</div>
						</div>
						
						<!-- Textarea -->
						<div class="control-group">
							<label class="control-label">Descrição</label>
							<div class="controls">
								<textarea id="descricao" name="descricao" class="input-xlarge required"></textarea>
							</div>
						</div>

						<!-- Select Basic -->
						<div class="control-group">
							<label class="control-label">Ano</label>
							<div class="controls">
								<select id="selectano" name="selectano" class="input-xlarge required">
									<option>2001</option>
									<option>2002</option>
									<option>2003</option>
									<option>2004</option>
									<option>2005</option>
									<option>2006</option>
									<option>2007</option>
									<option>2008</option>
									<option>2009</option>
									<option>2010</option>
									<option>2011</option>
									<option>2012</option>
									<option>2013</option>
								</select>
							</div>
						</div>

						<!-- Radios -->
						<div class="control-group">
							<label class="control-label">Tipo</label>
							<div class="controls">
								<label class="radio"> <input type="radio" id="tipoexame" 
								onchange="radioCheck()" name="radiotipo" value="0" checked="checked"> Exame
								</label> <label class="radio"> <input type="radio" id="tipofreq" 
									onchange="radioCheck()" name="radiotipo" value="1"> Frequência
								</label> <label class="radio"> <input type="radio" id="tipoteste"
									onchange="radioCheck()" name="radiotipo" value="2"> Teste
								</label> <label class="radio"> <input type="radio"
									onchange="radioCheck()" name="radiotipo" value="3"> Trabalho
								</label> <label class="radio"> <input type="radio"
									 onchange="radioCheck()" name="radiotipo" value="4"> Explicação
								</label>
							</div>
						</div>
						
						<!-- Radios -->
						<div class="control-group">
							<label class="control-label">Época</label>
							<div class="controls">
								<label class="radio"> <input type="radio" id="1ep"
									name="radioepoca" value="0" checked="checked"> 1ª Época
								</label> <label class="radio"> <input type="radio" id="2ep"
									name="radioepoca" value="1"> 2ª Época
								</label> <label class="radio"> <input type="radio" id="eep"
									name="radioepoca" value="2"> Época Especial
								</label>
							</div>
						</div>

						<!-- Checkbox -->
						<div class="control-group">
							<label class="control-label">Resolução?</label>
							<div class="controls">
								<label class="checkbox"> <input type="checkbox"
									id="resolution" name="res">
								</label>
							</div>
						</div>

						<!-- submit button -->
						<div class="control-group">
							<div class="controls">
								<button type="submit" formaction="servlet" class="btn btn-primary span7">Submeter</button>
							</div>
						</div>

					</fieldset>
				</form>
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
				data: "focus=enviar",  
				success: function() {  
				}
			});
		}, false);
	</script>
	
</body>
</html>