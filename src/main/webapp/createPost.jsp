<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<html>
	<%BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();%>
	<head>
	
	</head>
	<body>
		<form action="<%= blobstoreService.createUploadUrl("/store")%>" method="post" enctype="multipart/form-data">
			<div><textarea name="title" rows="1" cols="60"></textarea></div>
			<div><textarea name="content" rows="3" cols="60"></textarea></div>
			<div><input type="file" name="food"></div>
			<div><input type="submit" value="Post Recipe" ></div>
		</form>
		<a href="/landing.jsp">Cancel Post</a>
	</body>
</html>