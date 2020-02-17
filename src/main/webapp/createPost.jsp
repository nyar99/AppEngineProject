<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<html>
	<%BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();%>
	<head>
		<link rel = "stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<div class="form-styling">
			<form action="<%= blobstoreService.createUploadUrl("/store")%>" method="post" enctype="multipart/form-data">
				<h3>Title</h3>
				<div><textarea name="title" rows="1" cols="60"></textarea></div>
				<h3>Ingredients</h3>
				<div><textarea name="ingredients" rows="3" cols="60"></textarea></div>
				<h3>Instructions</h3>
				<div><textarea name="content" rows="5" cols="60"></textarea></div>
				<h3>Select a picture</h3>
				<div><input type="file" name="food"></div>
				<div><input type="submit" value="Post Recipe" ></div>
			</form>
			<a class="button" href="/landing.jsp">Cancel Post</a>
		</div>
	</body>
</html>