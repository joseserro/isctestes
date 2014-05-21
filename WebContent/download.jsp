<%@page import="Site.DBInfo"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Site.DBUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Downloading..</title>
</head>
<body>
<%
	String url = request.getParameter("link");
	if(url != null) {
		int id = Integer.parseInt(request.getParameter("idcont"));
		DBUtil.updateHits(id);
		response.sendRedirect(url);
	}
%>
</body>
</html>