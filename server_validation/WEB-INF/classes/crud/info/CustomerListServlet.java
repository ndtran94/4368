// save as "<TOMCAT_HOME>\webapps\a4\WEB-INF\classes\crud\info\CustomerListServlet.java"
package crud.info;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.regex.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import crud.business.Customer;

@WebServlet("/customerList")
public class CustomerListServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
			String url = "/index.html"; //initialize url value (used for logic below)
        
        // get current action
        String action = request.getParameter("action");
        if (action == null) {
            action = "join";  // default action
        }

        // perform action and set URL to appropriate page
        if (action.equals("join")) {
            url = "/index.jsp";    // the "join" page
        } 
        else if (action.equals("add")) {
            // get parameters from the request
            String firstName = request.getParameter("fname");
            String lastName = request.getParameter("lname");
            String email = request.getParameter("email");
	    String street = request.getParameter("street");
	    String city = request.getParameter("city");
	    String state = request.getParameter("state");
      	    String zip = request.getParameter("zip");
      	    String phone = request.getParameter("phone");
	    String balance = request.getParameter("balance");
	    String sales = request.getParameter("sales");
	    String notes = request.getParameter("notes");
	        

            // validate the parameters
				//empty string: string with zero length.
				//null value: is unknown value--not having a string.
            String message;
	    Boolean matchVal;

            if (firstName == null || lastName == null || email == null || street == null || city == null || state == null || zip == null || 
		phone == null || balance == null || sales == null || 
                firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || email.isEmpty() || street.isEmpty() || city.isEmpty() || 
		state.isEmpty() || zip.isEmpty() || phone.isEmpty() || balance.isEmpty() || sales.isEmpty() )
      		{
		    message = "All text boxes required except Notes.";
		    url = "/index.jsp";
		}  
	       else if(
		    (Pattern.matches("^[A-z/-]+$", firstName) == false ) || (Pattern.matches("^[A-z/-]+$", lastName ) == false ) ||
		    (Pattern.matches("^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$", email ) == false ) || 
		    (Pattern.matches("^[a-zA-Z0-9,\\s\\.]+$", street ) == false ) ||
	            (Pattern.matches("^([A-Za-z0-9\\, _]*[A-Za-z0-9\\,\\.][A-Za-z0-9\\.\\, _])*$", zip) == false) ||
	            (Pattern.matches("^([1-9]{1}[0-9]{9})*$", phone ) == false )  ||
	            (Pattern.matches("^([0-9])+(\\.?)([0-9][0-9])+$", balance ) == false )  ||
	            (Pattern.matches("^([0-9])+(\\.?)([0-9][0-9])+$", sales ) == false ) )
		   {
		       message = "All text boxes required except notes & check validity of input";
		       url = "/index.jsp";
		   }
      		else{

		    Customer user = new Customer(firstName, lastName, email, street, city, state, notes, zip,  phone, balance, sales );
		    request.setAttribute("user", user);
		    message = "";
		    url = "/thanks.jsp";
		}
	    //request.setAttribute("user", user);
            request.setAttribute("message", message);
        } // end else if action
        getServletContext()
                .getRequestDispatcher(url)
                .forward(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }    
}
