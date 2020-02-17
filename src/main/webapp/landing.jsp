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
<head><link rel = "stylesheet" type="text/css" href="style.css"></head>

  <body>
	<h1>Chris and Naveen's Cooking Blog</h1>
	<%

	if(user!=null){
		%>
		<div class="button-container">
			<a class="button" href="/subscribe.jsp">Subscribe</a>
			<a class="button" href="/unsubscribe.jsp" class = "link">Unsubscribe</a>
			<a class="button" href="<%=userService.createLogoutURL(request.getRequestURI())%>">Logout</a>
		</div>
		<br>
		<div class="button-container"><a class="button" href="/createPost.jsp">Post a Recipe!</a></div>
		<%		
	}
	else{
		%>
		<div class="button-container">
			<a class="button" href='/login'>Login</a>
		</div>
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
   		pageContext.setAttribute("date",r.getProperty("date"));
   		pageContext.setAttribute("author",r.getProperty("user"));
   		//pageContext.setAttribute("instructions", r.getProperty("content"));
   		%>
   		<br>
   		<div class="post-styling">
			<h3>${recipe}</h3>
			<span>Posted on ${date} by ${author}</span>
			<hr style="width:50%;">
			<div class="flex-parent">
				<div class="ingredients">
					<ul><%String[] lines2 = ((String)r.getProperty("ingredients")).split("\n"); 
						for (String line : lines2){
							if(line.length() >=2){
								pageContext.setAttribute("line",line);
								%>
								<li style="text-align:left;"> ${line} </li>
								<%
							}
						}
					%></ul>
				</div>
				<% if(r.getProperty("image")!=null){
						pageContext.setAttribute("image",r.getProperty("image"));
						%> 
						<div class="img-container"><img src=${image}></div> <%
					} %>
			</div>
			<div>
			<ol><%String[] lines = ((String)r.getProperty("content")).split("\n"); 
				for (String line : lines){
					if(line.length() >=2){
						pageContext.setAttribute("line",line);
						%>
						<li style="text-align:left;"> ${line} </li>
						<%
					}
				}
			
			%></ol>
			</div>
   		</div>
   		<hr class="separator">
   		<%
   	}
 %>
 	<br>
 	<br>
 	<div style="text-align: center"><a href='allfiles.jsp'>View All Recipes</a></div>
  </body>

</html>