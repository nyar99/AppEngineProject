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
<head><link rel = "stylesheet" type="text/css" href="style.css"></head>
  <body>
<h1> All Recipes </h1>
<% 
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key postsKey = KeyFactory.createKey("Blogpost", "default");
    Query query = new Query("post", postsKey).addSort("date", Query.SortDirection.DESCENDING);
    List<Entity> recipes = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
    try{
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
    } catch(Exception e){
    	e.printStackTrace();
    }
 %>
 	<a href="/landing.jsp">Return to the main page</a>
  </body>

</html>