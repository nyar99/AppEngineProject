import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
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
    private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException,IOException{
		String title=req.getParameter("title");
		String content=req.getParameter("content");
		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
        List<BlobKey> blobKeys = blobs.get("food");
		Date date = new Date();
		Key postKey = KeyFactory.createKey("Blogpost","default");
		Entity post = new Entity("post",postKey);
		post.setProperty("title", title);
		post.setProperty("content", content);
		post.setProperty("date", date);
		if(!blobKeys.isEmpty()) {
        	String blobToServe = blobKeys.get(0).getKeyString();
        	post.setProperty("blob-key", blobToServe);
        }
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(post);
		resp.sendRedirect("/landing.jsp");
	}
}
