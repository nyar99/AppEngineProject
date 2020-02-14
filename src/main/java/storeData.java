import java.io.IOException;
import java.util.Date;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@WebServlet(
	    name = "storeData",
	    urlPatterns = {"/store"}
	)

public class storeData extends HttpServlet{
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException{
		String title=req.getParameter("title");
		String content=req.getParameter("content");
		Date date = new Date();
		Key postKey = KeyFactory.createKey("Blogpost","default");
		Entity post = new Entity("post",postKey);
		post.setProperty("title", title);
		post.setProperty("content", content);
		post.setProperty("date", date);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(post);
		resp.sendRedirect("/landing.jsp");
	}
}
