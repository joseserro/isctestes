<!-- TOPBAR HTML STYLE CODE -->
<%@page import="Servlets.Servlet"%>
<title>ISCTestes</title>
<div class="navbar navbar-fixed-top navbar-inverse">
	<div class="navbar-inner">
		<div class="container">
			<a class="brand" href="<%="/"%>"> <b> ISCTEstes </b>
			</a>
			<ul class="nav pull-right">
				<li class="divider-vertical"></li>
				<li>
					<%
					System.out.println(session.getAttribute("userType"));
					if(session.getAttribute("userType") != null){
						if(session.getAttribute("userType").equals("guest")) { 
						%>
							<a href="#" id="loginForm" data-toggle="popover"
							data-placement="bottom" data-content="Teste"><b>
							<%	
								if(session.getAttribute("guestAttempt") != null){
									if(session.getAttribute("guestAttempt").equals("true")){ %>
										<font color="red">Login</font>
									<% } else { %>
										Login
									<% }
								} else { %>
									Login
								<% } %>
							</b></a>
							<li class="divider-vertical"></li>
							<li><a href="#signupModal" data-toggle="modal"> <b>Registar</b> </a></li>
						<%	} else if(session.getAttribute("userType").equals("registered")) { %>
						
						<li><a href="<%="/" %>profile.jsp"> Bem-vindo, <b><%= session.getAttribute("fullName") %></b> </a></li>
						<li class="divider-vertical"></li>
						
						<!-- HIDDEN FORM PARA FAZER COMUNICACAO COM O SERVLET -->
						<li><form name="doLogout" action="servlet" method="post">
						<input type="hidden" name="sessao" value="logout"></form></li>
						<li><a href="#" onclick="document.doLogout.submit()"> <b>Logout</b> </a></li>
						<% } else if(session.getAttribute("userType").equals("admin")) { %>
						
						<li><a href="<%="/" %>profile.jsp"> Bem-vindo, <b><%= session.getAttribute("fullName") %></b> </a></li>
						<li class="divider-vertical"></li>
						<li><a href="/admin.jsp"> <b>Admin</b> </a></li>
						<li class="divider-vertical"></li>
						<!-- HIDDEN FORM PARA FAZER COMUNICACAO COM O SERVLET -->
						<li><form name="doLogout" action="servlet" method="post">
						<input type="hidden" name="sessao" value="logout"></form></li>
						<li><a href="#" onclick="document.doLogout.submit()"> <b>Logout</b> </a></li>
						<% }
					}
					%>
				<li class="divider-vertical"></li>
			</ul>
		</div>
	</div>
</div>