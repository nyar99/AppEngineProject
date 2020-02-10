import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(
	    name = "posting",
	    urlPatterns = {"/posting"}
	)

public class posting extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException{
	}
}
