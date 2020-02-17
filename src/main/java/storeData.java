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
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.appengine.api.images.ServingUrlOptions;

@WebServlet(
	    name = "storeData",
	    urlPatterns = {"/store"}
	)

public class storeData extends HttpServlet{
	final String Bucket = "cookingwithchris.appspot.com";
    private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    private ImagesService imageService = ImagesServiceFactory.getImagesService();
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException,IOException{
		String title=req.getParameter("title");
		String content=req.getParameter("content");
		Date date = new Date();
		Key postKey = KeyFactory.createKey("Blogpost","default");
		Entity post = new Entity("post",postKey);
		post.setProperty("title", title);
		post.setProperty("content", content);
		post.setProperty("date", date);
		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
        List<BlobKey> blobKeys = blobs.get("food");
        if(!blobKeys.isEmpty()) {
        	ServingUrlOptions servingUrlOptions = ServingUrlOptions.Builder.withBlobKey(blobKeys.get(0));
        	String image_url = imageService.getServingUrl(servingUrlOptions);
        	post.setProperty("image", image_url);
        }
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(post);
		resp.sendRedirect("/landing.jsp");
	}
}
