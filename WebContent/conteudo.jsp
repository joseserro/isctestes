<%@page import="Servlets.Servlet"%>
<%@page import="Site.DBInfo"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Site.DBUtil" %>
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
		System.out.println("oh noooo");
		session.setAttribute("userType", "guest");
		session.setAttribute("guestAttempt","true");
		
		%>
		<jsp:forward page="index.jsp"></jsp:forward>
		<%
	}

session.setAttribute("origem", "conteudo"); %>

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
			<div class="well span3">
				<ul class="nav nav-list nav-stacked">

					<%
						String userType = (String) session.getAttribute("userType");
						
						//System.out.println("omg "+session.getAttribute("userID")+" and "+userType);
					
						if(userType.equals("guest") || session.getAttribute("userID") == null){
							session.setAttribute("guestAttempt","true");
							%>
								<jsp:forward page="index.jsp"></jsp:forward>
							<%
						}
						String cadeira = (String) session.getAttribute("cadeira");
						//System.out.println("cadeira uh: "+cadeira);
						
						
						int idComment = 0;
						String cid = request.getParameter("cid");
						if(cid != null && !cid.equals("")){
							idComment = Integer.parseInt(cid);
							cadeira = DBInfo.getCadeiraName(Integer.parseInt(DBUtil.getContent(idComment).get(1)));
						}
						System.out.println(idComment);
						
						int cd;
						if(cadeira == null){
							cadeira = "";
						}
						if(cadeira.isEmpty()){
							String tempCd = request.getParameter("cadeira");
							if(!("".equals(tempCd)) && tempCd != null){
								cd = Integer.parseInt(tempCd);
								cadeira = DBInfo.getCadeiraName(cd);
								session.setAttribute("cadeira", cadeira);
							} else {
								cd = 0;
							}
						} else {
							int temp = DBInfo.getCadeiraID(cadeira);
							String tempCd = request.getParameter("cadeira");
							if(!("".equals(tempCd)) && tempCd != null){
								if(Integer.parseInt(tempCd) != temp){
									cd = Integer.parseInt(tempCd); // dar prioridade ao do topo.
									cadeira = DBInfo.getCadeiraName(cd);
									session.setAttribute("cadeira", cadeira);
								} else {
									cd = DBInfo.getCadeiraID(cadeira);
								}
							} else {
								cd = DBInfo.getCadeiraID(cadeira);
							}
						}
						String tipo,selectedAno;
						if(idComment > 0){
							ArrayList<String> tempCont = DBUtil.getContent(idComment);
							tipo = tempCont.get(6);
							selectedAno = tempCont.get(5);
						} else {
							tipo = request.getParameter("tipo");
							selectedAno = request.getParameter("ano");
						}
						

						String sorig = " class=\"active\"";
						String[] s = new String[5], sa = new String[13];
						if (tipo != null) {
							s[Integer.parseInt(tipo)] = sorig;
						}
						if (selectedAno != null){
							
							sa[Integer.parseInt(selectedAno)-2001] = sorig;
					%>
						<li class="nav-header"><%=cadeira%></li>
						<li <%=s[0]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=0&ano=<%=selectedAno%>">Exames</a></li>
						<li <%=s[1]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=1&ano=<%=selectedAno%>">Frequências</a></li>
						<li <%=s[2]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=2&ano=<%=selectedAno%>">Testes</a></li>
						<li <%=s[3]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=3&ano=<%=selectedAno%>">Trabalhos</a></li>
						<li <%=s[4]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=4&ano=<%=selectedAno%>">Explicações</a></li>
					</ul>
					<hr style="margin-bottom: 10px;">
					<ul class="nav nav-list nav-stacked">
						<li class="nav-header">Ano</li>
						<li <%=sa[0]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2001">2001</a></li>
						<li <%=sa[1]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2002">2002</a></li>
						<li <%=sa[2]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2003">2003</a></li>
						<li <%=sa[3]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2004">2004</a></li>
						<li <%=sa[4]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2005">2005</a></li>
						<li <%=sa[5]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2006">2006</a></li>
						<li <%=sa[6]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2007">2007</a></li>
						<li <%=sa[7]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2008">2008</a></li>
						<li <%=sa[8]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2009">2009</a></li>
						<li <%=sa[9]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2010">2010</a></li>
						<li <%=sa[10]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2011">2011</a></li>
						<li <%=sa[11]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2012">2012</a></li>
						<li <%=sa[12]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=<%=tipo%>&ano=2013">2013</a></li>
					<%
						} else {
					%>
						<li class="nav-header"><%=cadeira%></li>
						<li <%=s[0]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=0">Exames</a></li>
						<li <%=s[1]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=1">Frequências</a></li>
						<li <%=s[2]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=2">Testes</a></li>
						<li <%=s[3]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=3">Trabalhos</a></li>
						<li <%=s[4]%>><a href="conteudo.jsp?cadeira=<%=cd%>&tipo=4">Explicações</a></li>
					
					<%	
						}
					%>
					</ul>
			</div>
			<div class="span9">

				<%
					if (cd <= 0 && idComment <= 0) {
						response.sendRedirect("/cursos.jsp");
					} else if (tipo == null && idComment <= 0) {
				%>
				<div class="well">
					<div style="margin-top: -10px; margin-bottom: -20px;">
						<h6 align="center">
							Por favor selecciona um dos itens do menu à esquerda.
						</h6>
					</div>
				</div>

				<%
					} else if (selectedAno == null && idComment <= 0) {
				%>

				<div class="well">
					<div style="margin-top: -10px; margin-bottom: -20px;"
						align="center">
						<h6>Selecciona o ano que pretendes pesquisar:</h6>
						<select id="ano" name="ano" class="input-small"
							onchange="anoSubmit()">
							<option selected="selected">- Ano -</option>
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

				<%
					} else {
						
						if(idComment > 0){
							
							ArrayList<String> listIn = DBUtil.getContent(idComment);
							
							%>
						<div class="well">
							<div style="margin-top: -10px; margin-bottom: -20px;">
							<ul class="inline">
								<li><h5><b><%=DBUtil.getStringFromTipo(listIn.get(6))%> <%=listIn.get(5)%></b></h5></li>
											
								<% if((listIn.get(7).equals("0")) && (listIn.get(6).equals("0") || listIn.get(6).equals("1"))) { %>
								<li><span class="label label-inverse"><%=DBUtil.getStringFromEpoca(listIn.get(7))%></span></li>
								<% } else if((listIn.get(7).equals("1")) && (listIn.get(6).equals("0") || listIn.get(6).equals("1"))) { %>
								<li><span class="label label-success"><%=DBUtil.getStringFromEpoca(listIn.get(7))%></span></li>
								<% } else if((listIn.get(7).equals("2")) && (listIn.get(6).equals("0") || listIn.get(6).equals("1"))) { %>
								<li><span class="label label-warning"><%=DBUtil.getStringFromEpoca(listIn.get(7))%></span></li>
								<% } %>
									
								<li class="pull-right">
									<form action="/servlet" method="POST">
									<div class="btn-group" style="margin-top: 7px;">
									
									<% if(listIn.get(8).equals("1")) { %>
									<a id="resinfo" class="btn btn-success btn-mini disabled" data-toggle="tooltip"
									title="Contém resolução" data-placement="bottom">
									<i class="icon-white icon-ok-circle"></i></a>
									<% }
									
									if(DBUtil.hasLiked(Integer.parseInt(listIn.get(0)), Integer.parseInt((String) session.getAttribute("userID")))){ %>
									<a id="likedButton<%=listIn.get(0) %>" class="btn btn-success
										 btn-mini" onclick="decreaseLikes(<%=listIn.get(0) %>)"><i class="icon-white icon-thumbs-up"></i>&nbsp;Like</a>
									<%} else { %>
									<a id="likedButton<%=listIn.get(0) %>" class="btn btn-inverse
										 btn-mini" onclick="increaseLikes(<%=listIn.get(0) %>)"><i class="icon-white icon-thumbs-up"></i>&nbsp;Like</a>
									<% }
									
									if(DBUtil.hasReported(Integer.parseInt(listIn.get(0)), Integer.parseInt((String) session.getAttribute("userID")))){ %>
									<button id="reportedButton<%=listIn.get(0) %>" class="btn btn-danger
										 btn-mini" disabled="disabled"><i class="icon-white icon-flag"></i>&nbsp;Reportar</button>
									<%} else { %>
									<a id="reportedButton<%=listIn.get(0) %>" class="btn btn-inverse
										 btn-mini" onclick="increaseReports(<%=listIn.get(0) %>)"><i class="icon-white icon-flag"></i>&nbsp;Reportar</a>
									<% } 
									if(userType.equals("admin")){
									%>
									<button type="submit" class="btn btn-mini btn-danger" name="deleteContent" value="<%=listIn.get(0)%>"><i class="icon-warning-sign icon-white"></i>&nbsp;Eliminar</button>
									<% } %>
									</div>
									</form>
								</li>
							</ul>
						</div>
						<hr>
						<h5><%=listIn.get(2)%></h5>
						<div class="row-fluid">
							<div class="span2">
								<a href="#" class="thumbnail"> <img
									src="http://placehold.it/250x250" alt="">
								</a>
							</div>
							<div class="span9">
								<p><%=listIn.get(4)%></p>
							</div>
						</div>
						<hr style="margin-bottom: 15px;">
						<i class="icon-user"></i> <font size="2"><a href="/profile.jsp?id=<%=listIn.get(12)%>"> <%=DBUtil.getFullNameFromID(listIn.get(12))%> </a></font> | <i
							class="icon-thumbs-up"></i> <a><font id="numLikes<%=listIn.get(0) %>" size="2"> <%=listIn.get(9)%> </font></a> | <i
							class="icon-share"></i> <a><font id="numDown<%=listIn.get(0) %>" size="2"> <%=listIn.get(11)%> </font></a>
						<form name="download" action="download.jsp" method="post" target="_blank">
							<input type="hidden" name="link" value="<%=listIn.get(3)%>">
							<input type="hidden" name="idcont" value="<%=listIn.get(0) %>">
							<input type="hidden" id="download" name="download" value="download">
							<button type="submit" style="margin-top: -25px;" class="btn btn-success pull-right" onclick="increaseDl(<%=listIn.get(0) %>)">
							<i class="icon-chevron-down"></i>&nbsp;Download</button>
						</form>
						
						<div class="well" style="background-color: rgb(220, 220, 220);margin-bottom: 0px;">
							<div style="margin-top: -10px;">
								<h4>Comentários</h4>
							</div>
							<%
							ArrayList<ArrayList<String>> comments = DBUtil.getComments(Integer.parseInt(listIn.get(0)));
							//System.out.println("comments: "+comments);
							for(ArrayList<String> comment : comments){
								%>
									<i class="icon-user"></i> <font size="2"><a href="/profile.jsp?id=<%=comment.get(1)%>"> <%=DBUtil.getFullNameFromID(comment.get(1))%> </a></font><font size="1"> a <%=comment.get(3)%></font>
									<%
									if(userType.equals("admin")){
									%>
									<a href="" onclick="deleteComment(<%=comment.get(0)%>)"><img class="pull-right" src="/img/delete.png"></a>
									<%
									}
									%>
									<div>
										<h6><%=DBUtil.encodeHTML(comment.get(2))%></h6>
									</div>
									<hr style="margin-top: 10px;margin-bottom: 10px;">
								<%
							}
							%>
							<div class="row-fluid">
								<fieldset>						
									<form method="post" action="servlet">
										<div class="full-width" style="margin-bottom: -20px">
											<label>Dá a tua opinião</label>
											<textarea name="comment" id="commentBox" class="input-xlarge span12" rows="4" onkeypress="limitText(187)"></textarea>
											<div class="row-fluid"><h4 style="margin-top: 0px;" id="numChars" class="pull-left"></h4>
											<input type="hidden" name="cid" value="<%=listIn.get(0) %>">
											<button type="submit" class="btn btn-primary pull-right">Comentar</button>
											</div>
										</div>
									</form>
								</fieldset>
							</div>
							
						</div>
					</div> <%
							
						} else {
							int tipoInt = Integer.parseInt((String) tipo);
							int anoInt = Integer.parseInt((String) selectedAno);
							ArrayList<ArrayList<String>> listOut = DBUtil.getContentByAnoTipoCadeira(anoInt, tipoInt, cd);
							if(listOut.size() == 0){
								%>
								<div class="well">
									<div style="margin-top: -10px; margin-bottom: -20px;">
										<h6 align="center">
											Nenhum conteúdo encontrado nesta secção! Tenta outro ano no menu à esquerda.
										</h6>
									</div>
								</div>
								<%
							}
						for (ArrayList<String> listIn : listOut) {
				%>
				<div class="well">
					<div style="margin-top: -10px; margin-bottom: -20px;">
					<ul class="inline">
						<li><h5><b><%=DBUtil.getStringFromTipo(listIn.get(6))%> <%=listIn.get(5)%></b></h5></li>
									
						<% if((listIn.get(7).equals("0")) && (tipo.equals("0") || tipo.equals("1"))) { %>
						<li><span class="label label-inverse"><%=DBUtil.getStringFromEpoca(listIn.get(7))%></span></li>
						<% } else if((listIn.get(7).equals("1")) && (tipo.equals("0") || tipo.equals("1"))) { %>
						<li><span class="label label-success"><%=DBUtil.getStringFromEpoca(listIn.get(7))%></span></li>
						<% } else if((listIn.get(7).equals("2")) && (tipo.equals("0") || tipo.equals("1"))) { %>
						<li><span class="label label-warning"><%=DBUtil.getStringFromEpoca(listIn.get(7))%></span></li>
						<% } %>
							
						<li class="pull-right">
							<div class="btn-group" style="margin-top: 7px;">
							
							<% if(listIn.get(8).equals("1")) { %>
							<a id="resinfo" class="btn btn-success btn-mini disabled" data-toggle="tooltip"
							title="Contém resolução" data-placement="bottom">
							<i class="icon-white icon-ok-circle"></i></a>
							<% }
							
							if(DBUtil.hasLiked(Integer.parseInt(listIn.get(0)), Integer.parseInt((String) session.getAttribute("userID")))){ %>
							<a id="likedButton<%=listIn.get(0) %>" class="btn btn-success
								 btn-mini" onclick="decreaseLikes(<%=listIn.get(0) %>)"><i class="icon-white icon-thumbs-up"></i>&nbsp;Like</a>
							<%} else { %>
							<a id="likedButton<%=listIn.get(0) %>" class="btn btn-inverse
								 btn-mini" onclick="increaseLikes(<%=listIn.get(0) %>)"><i class="icon-white icon-thumbs-up"></i>&nbsp;Like</a>
							<% }
							
							if(DBUtil.hasReported(Integer.parseInt(listIn.get(0)), Integer.parseInt((String) session.getAttribute("userID")))){ %>
							<button id="reportedButton<%=listIn.get(0) %>" class="btn btn-danger
								 btn-mini" disabled="disabled"><i class="icon-white icon-flag"></i>&nbsp;Reportar</button>
							<%} else { %>
							<a id="reportedButton<%=listIn.get(0) %>" class="btn btn-inverse
								 btn-mini" onclick="increaseReports(<%=listIn.get(0) %>)"><i class="icon-white icon-flag"></i>&nbsp;Reportar</a>
							<% }
							if(userType.equals("admin")){
							%>
							<button type="submit" class="btn btn-mini btn-danger" name="deleteContent" value="<%=listIn.get(0)%>"><i class="icon-warning-sign icon-white"></i>&nbsp;Eliminar</button>
							<% } %>
							</div>
						</li>
					</ul>
				</div>
				<hr>
				<h5><%=listIn.get(2)%></h5>
				<div class="row-fluid">
					<div class="span2">
						<a href="/conteudo.jsp?cid=<%=listIn.get(0)%>" class="thumbnail"> <img
							src="http://placehold.it/250x250" alt="">
						</a>
					</div>
					<div class="span9">
						<p><%=listIn.get(4)%></p>
					</div>
				</div>
				<hr style="margin-bottom: 15px;">
				<i class="icon-user"></i> <font size="2"><a href="/profile.jsp?id=<%=listIn.get(12)%>"> <%=DBUtil.getFullNameFromID(listIn.get(12))%> </a></font> | <i
					class="icon-thumbs-up"></i> <a><font id="numLikes<%=listIn.get(0) %>" size="2"> <%=listIn.get(9)%> </font></a> | <i
					class="icon-comment"></i> <a href="/conteudo.jsp?cid=<%=listIn.get(0)%>"><font size="2"> Comentários: <%=DBUtil.getNumberComments(Integer.parseInt(listIn.get(0))) %></font></a> | <i
					class="icon-share"></i> <a><font id="numDown<%=listIn.get(0) %>" size="2"> <%=listIn.get(11)%> </font></a>
				<form name="download" action="download.jsp" method="post" target="_blank">
					<input type="hidden" name="link" value="<%=listIn.get(3)%>">
					<input type="hidden" name="idcont" value="<%=listIn.get(0) %>">
					<input type="hidden" id="download" name="download" value="download">
					<button type="submit" style="margin-top: -20px;" class="btn btn-success pull-right" onclick="increaseDl(<%=listIn.get(0) %>)">
					<i class="icon-chevron-down"></i>&nbsp;Download</button>
				</form>
				</div>

				<%
						}
					}
				}
				%>
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
	<!-- FUNCAO QUE METE O PARAMETRO ANO NO URL -->
	<script type="text/javascript">
	
	function anoSubmit() {
		var ano = $('#ano').val();
		var url = "conteudo.jsp?cadeira="+<%="\"" + cd + "\""%>+"&tipo="+<%="\"" + tipo + "\""%>+"&ano="+ano;
		window.location.replace(url);
	}
	
	function increaseDl(id){
		var prevNum = parseInt(document.getElementById("numDown"+id).innerHTML);
		document.getElementById("numDown"+id).innerHTML = (prevNum + 1);
	}
	
	function increaseLikes(id){
		document.getElementById("likedButton"+id).setAttribute("disabled", "disabled");
		var delay = 2000;
		setTimeout(function(){
			document.getElementById("likedButton"+id).removeAttribute("disabled");
		}, delay);
		$.ajax({  
			type: "POST",  
			url: "servlet",  
			data: "idcont="+id,  
			success: function() {
				var prevNum = parseInt(document.getElementById("numLikes"+id).innerHTML);
				document.getElementById("numLikes"+id).innerHTML = (prevNum + 1);
				$('#likedButton'+id).removeClass('btn-inverse').addClass('btn-success');
				document.getElementById("likedButton"+id).setAttribute("onclick", "decreaseLikes("+id+")");
			}
		}); 
	}
	
	function decreaseLikes(id){
		document.getElementById("likedButton"+id).setAttribute("disabled", "disabled");
		var delay = 2000;
		setTimeout(function(){
			document.getElementById("likedButton"+id).removeAttribute("disabled");
		}, delay);
		$.ajax({  
			type: "POST",  
			url: "servlet",  
			data: "iddec="+id,  
			success: function() {  
				var prevNum = parseInt(document.getElementById("numLikes"+id).innerHTML);
				document.getElementById("numLikes"+id).innerHTML = (prevNum - 1);
				$('#likedButton'+id).removeClass('btn-success').addClass('btn-inverse');
				document.getElementById("likedButton"+id).setAttribute("onclick", "increaseLikes("+id+")");
			}
		}); 
	}
	
	function increaseReports(id){
		$.ajax({  
			type: "POST",  
			url: "servlet",  
			data: "idrep="+id,  
			success: function() {  
				$('#reportedButton'+id).removeClass('btn-inverse').addClass('btn-danger');
				document.getElementById("reportedButton"+id).setAttribute("disabled", "disabled");
			}
		}); 
	}
	
	function deleteComment(id){
		$.ajax({  
			type: "POST",  
			url: "servlet",  
			data: "cidel="+id,  
			success: function() {  
				alert("Comentario apagado. Macacos.");
			}
		}); 
	}

	function limitText( maxChar){
	    var ref = $('#commentBox'),
	        val = ref.val();
	    if ( val.length >= maxChar ){
	        ref.val(function() {
	            return val.substr(0, maxChar-1);       
	        });
	    }
	    var num = maxChar - val.length;
	    document.getElementById("numChars").innerHTML = num;
	}
	</script>
	
	<script type="text/javascript">
		window.addEventListener("focus", function(event) {
			$.ajax({  
				type: "POST",  
				url: "servlet",  
				data: "focus=conteudo",  
				success: function() {  
				}
			});
		}, false);
	</script>

</body>
</html>