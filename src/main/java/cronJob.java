import java.io.IOException;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.*;
import javax.activation.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import java.util.*;
import com.google.appengine.api.datastore.FetchOptions;

@WebServlet(
	    name = "cron",
	    urlPatterns = {"/cronJob"}
	)

public class cronJob extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException{
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    Key postsKey = KeyFactory.createKey("Blogpost", "default");
	    Query query = new Query("email", postsKey);
	    List<Entity> emails = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
		
		
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
		
		for(Entity e : emails) {
			try {
				Message msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress("nyar99@gmail.com"));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress((String)e.getProperty("email")));
				msg.setSubject("title");
				msg.setText("test");
				Transport.send(msg);
			}
			catch(Exception ex) {
				ex.printStackTrace();
			}
		}
		
		/*
		String from = "nyar99@gmail.com";
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    Key postsKey = KeyFactory.createKey("Blogpost", "default");
	    Query query = new Query("email", postsKey);
	    List<Entity> emails = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
	   	for(Entity e : emails){
	   		
	   	}
	   	*/
	   		
	}

}
