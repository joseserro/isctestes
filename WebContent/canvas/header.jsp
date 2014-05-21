<!-- HEADER HTML STYLE CODE COM UMA BTN-GROUP INVISIVEL PARA ESPACEJAMENTO -->
<%@page import="Site.*"%>
<%@page import="Servlets.Servlet"%>
<div class="btn-group"></div>
<div class="well well-small">
	<div>
		<%
			System.out.println("Session.. "+session);
			int studentNumber = DBInfo.getNumUsers();
				%>
		<h1 align="center">ISCTEstes</h1>
		<p align="center">
			A fonte de estudo de 
			<%=studentNumber%>
			estudantes do ISCTE.
		</p>
	</div>
</div>
<% 
String userType = (String)session.getAttribute("userType");
if(!userType.equals("guest")){ %>
<div class="btn-toolbar">
	<div class="btn-group row-fluid">
		<% 
			String origem = (String) session.getAttribute("origem");
			if(origem == null){
				origem = "";
			}
		   if(origem.equals("homepage")) { %>
		<a class="btn btn-inverse span3" href="/index.jsp"> <i class="icon-home icon-white"></i><b>&nbsp;Homepage</b></a>
		<% } else { %>
		<a class="btn btn-default span3" href="/index.jsp"> <i class="icon-home"></i>&nbsp;Homepage</a>
		<% } %>
		
		<% if(origem.equals("cursos")) { %>
		<a class="btn btn-inverse span3" href="/cursos.jsp"> <i class="icon-th-list icon-white"></i><b>&nbsp;Cursos</b></a>
		<% } else { %>
		<a class="btn btn-default span3" href="/cursos.jsp"> <i class="icon-th-list"></i>&nbsp;Cursos</a>
		<% } %>
		
		<% if(origem.equals("enviar")) { %>
		<a class="btn btn-inverse span3" href="/inserir.jsp"> <i class="icon-file icon-white"></i><b>&nbsp;Enviar</b></a>
		<% } else { %>
		<a class="btn btn-default span3" href="/inserir.jsp"> <i class="icon-file"></i>&nbsp;Enviar</a>
		<% } %>
		
		<% if(origem.equals("cadeiras") && !(request.getParameter("cursoid") == null)) { %>
		<a class="btn btn-inverse span3" href="/cadeiras.jsp?cursoid=<%=DBInfo.getUserCursoID(Integer.parseInt((String)session.getAttribute("userID")))%>"> <i class="icon-info-sign icon-white"></i><b>&nbsp;Minhas Cadeiras</b></a>
		<% } else { %>
		<a class="btn btn-default span3" href="/cadeiras.jsp?cursoid=<%=DBInfo.getUserCursoID(Integer.parseInt((String)session.getAttribute("userID")))%>"> <i class="icon-info-sign"></i>&nbsp;Minhas Cadeiras</a>
		<% } %>
		
		<% if(origem.equals("perfil")) { %>
		<a class="btn btn-warning" style="width: 50px;" href="/profile.jsp"> <i class="icon-user icon-white"></i><b>&nbsp;Perfil</b></a>
		<% } else { %>
		<a class="btn btn-info" style="width: 50px;" href="/profile.jsp"> <i class="icon-user icon-white"></i>&nbsp;Perfil</a>
		<% } %>
	</div>
</div>
<% } %>