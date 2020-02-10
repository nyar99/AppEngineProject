import java.io.IOException;
import javax.servlet.http.*;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import javax.servlet.annotation.WebServlet;


@WebServlet(
	    name = "login",
	    urlPatterns = {"/login"}
	)


public class login extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if(user != null) {
			resp.sendRedirect("/landing.jsp");
		}
		else {
			resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
		}

	}
}
