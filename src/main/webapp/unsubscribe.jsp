<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.google.appengine.api.datastore.*" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
  <body>
<% 
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String email = user.getEmail();
	
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key postsKey = KeyFactory.createKey("Blogpost", "default");
    Query query = new Query("email", postsKey);
    try{
    	List<Entity> emails = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
        for(Entity e : emails){
        	if(((String)e.getProperty("email")).equals(email)){
        		Key key = e.getKey();
        		datastore.delete(key);
        	}
        }    	
    } catch (Exception e){
    	e.printStackTrace();
    }
    
    
    
	response.sendRedirect("/landing.jsp");
 %>
  </body>

</html>