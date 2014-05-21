<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Site.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>mail test</title>
</head>
<body>
<%

String[] headers = new String[1];
headers[0] = "oi.";
DBUtil.sendMail("admin@isctestes.com",
				"zpankr@gmail.com",
				"test subject",
				"this is a body and it has lots of words.",
				headers);

%>
</body>
</html>