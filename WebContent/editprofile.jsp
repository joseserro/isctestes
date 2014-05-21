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

session.setAttribute("origem", "editprofile"); %>

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
			<form class="form-horizontal" method="post" action="servlet">
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
			
			String fullName = DBInfo.getUserName(id);
			String userCurso = DBInfo.getCursoName(DBInfo.getUserCursoID(id));
			int userAno = DBInfo.getUserAno(id);
			String imgLink = DBInfo.getUserImage(id);
			String desc = DBInfo.getUserDesc(id);
			int nLikes = DBInfo.getNumberLikes(id);
			int nComments = DBInfo.getNumberComments(id);
			//int filesSubmitted = DBInfo.getSubmittedFilesFromID(id);
			
			%>
				<li><h5><b><%= fullName %></b></h5></li>
			</ul>
			</div>
				<hr>
				<div class="row-fluid" style="margin-top: 10px;">
					<div class="full-width">
					
						<div class="control-group">
							<label class="control-label">* Password actual</label>
							<div class="controls">
								<input type="password" required="required" name="passactual">
									<p class="help-block">Necessário para quaisquer modificações</p>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">Alterar password</label>
							<div class="controls">
								<input type="password" id="passnova" name="passnova" min="6" max="32"
								onfocus="deletePass2()" onchange="deletePass2()">
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">Confirmar password</label>
							<div class="controls">
								<input type="password" id="passnova2" name="passnova2" min="6" max="32"
								onchange="checkPass()">
							</div>
						</div>
					
						<div class="control-group">
							<div class="controls">
							 <img id="imgid" src="<%= imgLink %>" alt=""
								width="150" height="150" align="bottom">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Link da imagem</label>
							<div class="controls">
								<input type="text" id="imglink" name="imglink" class="input-xlarge required"
								placeholder="<%= imgLink %>" onchange="changeImage()">
								<a href="http://imgur.com" target="_blank" class="btn" id="urlinfo" data-toggle="tooltip"
								title="Utilize o ImgUr.com" data-placement="bottom">
								<i class="icon-picture"></i></a>	
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Curso</label>
							<div class="controls">
								<select id="selectcurso" name="selectcurso" class="input-xlarge">
								<% 
								
								ArrayList<String> list = DBInfo.getAllCursos();
								for(String s : list) { %>
								
								<option><%=s%></option>
								<% } %>
								</select>
								
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Ano</label>
							<div class="controls">
								<select id="selectano" name="selectano" class="input-xlarge required">
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
								</select>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Descrição</label>
							<div class="controls">
								<textarea rows="5" class="span5" name="desc"><%= desc %></textarea>
							</div>
						</div>
						
						
						<hr>
						
						
						<div class="control-group">
							<div class="controls">
								<a href="editprofile.jsp">
								<button type="submit" class="btn btn-info">&nbsp;Gravar modificações&nbsp;</button>
								</a>			
							</div>
						</div>
						
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
		
		document.getElementById("selectcurso").selectedIndex = <%= DBInfo.getCursoID(userCurso) - 1%>;
		document.getElementById("selectano").value = <%= DBInfo.getUserAno(Integer.parseInt((String) session.getAttribute("userID")))%>
		
		function changeImage() {
			var link = document.getElementById("imglink").value;
			document.getElementById("imgid").setAttribute("src", link);
		}
		
		function checkPass() {
			var passnova = document.getElementById("passnova").value;
			var passnova2 = document.getElementById("passnova2").value;
			
			if(passnova2!=passnova) {
				alert("As passwords não correspondem. Tente novamente!");
				document.getElementById("passnova").value = "";
			}
		}
		
		function deletePass2() {
			document.getElementById("passnova2").value = "";
		}
	
		window.addEventListener("focus", function(event) {
			$.ajax({  
				type: "POST",  
				url: "servlet",  
				data: "focus=editprofile",  
				success: function() {  
				}
			});
		}, false);
	</script>
	
</body>
</html>