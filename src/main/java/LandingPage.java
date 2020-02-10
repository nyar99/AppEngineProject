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
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
	throws IOException{
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		resp.getWriter().write("<p>" + title + "</p>");
		resp.getWriter().write("<p>" + title + "</p>");
	}
}
