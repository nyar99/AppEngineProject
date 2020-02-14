import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(
	    name = "landing",
	    urlPatterns = {"/"}
	)

public class LandingPage extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException{
		resp.sendRedirect("/landing.jsp");
	}
}
