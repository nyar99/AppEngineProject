<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 <%
 	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser(); 
%>

<html>
  <body>
<h1>Chris and Naveen's Cooking Blog</h1>
<%
	if(user!=null){
		%>
		<p> Hello, ${fn:escapeXml(user.getNickname())}! You are logged in. 
		<a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Logout</a></p>
		<%		
	}
	else{
		%>
		<a href='/login'>Login</a>
		<%
	}
%>

 

  </body>

</html>