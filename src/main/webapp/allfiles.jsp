<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
  <body>
<h1> All Recipes </h1>
<% 
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key postsKey = KeyFactory.createKey("Blogpost", "default");
    Query query = new Query("post", postsKey).addSort("date", Query.SortDirection.DESCENDING);
    List<Entity> recipes = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
   	for(Entity r : recipes){
   		pageContext.setAttribute("recipe", r.getProperty("title"));
   		pageContext.setAttribute("instructions", r.getProperty("content"));
   		%>
   		<div>
	   		<h3>${recipe}</h3>
	   		<p>${instructions}</p>
   		</div>
   		<%
   	}
 %>
 	<a href="/landing.jsp">Click here to return to the main page</a>
  </body>

</html>