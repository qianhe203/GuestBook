// http://1-dot-tutorial1-1201.appspot.com/ofyguestbook.jsp

package guestbook;

 

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;
import static com.googlecode.objectify.ObjectifyService.ofy;



import java.io.IOException;
import java.util.Date;


import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 

public class OfySignGuestbookServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {
    	ObjectifyService.register(Greeting.class);

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();

        // We have one entity group per Guestbook with all Greetings residing

        // in the same entity group as the Guestbook to which they belong.

        // This lets us run a transactional ancestor query to retrieve all

        // Greetings for a given Guestbook.  However, the write rate to each

        // Guestbook should be limited to ~1/second.

        String content = req.getParameter("content");

        Greeting greeting = new Greeting(user, content);

        ofy().save().entity(greeting).now();
        
 

        resp.sendRedirect("/ofyguestbook.jsp?");

    }

}