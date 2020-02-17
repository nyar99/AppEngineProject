<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobKey" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
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
		
		<a href="/unsubscribe.jsp">Unsubscribe</a>
		<a href="/subscribe.jsp">Subscribe</a>
		<p> 
			<a href="/createPost.jsp">Click here to create a Post</a>
		
			<a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Logout</a>
			
		</p>
		<%		
	}
	else{
		%>
		<a href='/login'>Login</a>
		<%
	}

%>
	

<% 	
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key postsKey = KeyFactory.createKey("Blogpost", "default");
    Query query = new Query("post", postsKey).addSort("date", Query.SortDirection.DESCENDING);
    List<Entity> recipes = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(3));
   	for(Entity r : recipes){
   		pageContext.setAttribute("r",r);
   		pageContext.setAttribute("recipe", r.getProperty("title"));
   		pageContext.setAttribute("instructions", r.getProperty("content"));
   		%>
   		<blockquote>${recipe}</blockquote>
   		<p>${instructions}<p>
   		<% if(r.getProperty("image")!=null){
   			pageContext.setAttribute("image",r.getProperty("image"));
   			%> <img src=${image}}> <%
   		} %>
   		<%
   	}
 %>
 	<a href='allfiles.jsp'>Click here to view all recipes</a>
  </body>

</html>