package main;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Dragan
 */
@WebServlet(name = "Signup", urlPatterns = {"/signup"})
public class Signup extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private String alert(String message) {
        return "<script type=\"text/javascript\">alert('" + message + "')</script>";
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String password = request.getParameter("password");
            String checkpass = request.getParameter("checkpass");
            String permission = "guest";
            Set<Order> orders = new HashSet<>(0);
            String existingEmail = null;
            String existingUsername = null;
            Boolean error = false;
            
            if(email.isEmpty() || username.isEmpty() || firstname.isEmpty() || lastname.isEmpty() || password.isEmpty()) {
                out.println(this.alert("Popunite sva polja !"));
                error = true;
            }
            if(error == false) {
                if (password.equals(checkpass)) {
                    List<User> user = DB.query("SELECT u FROM User u WHERE u.email=? OR u.username=?", email, username);
                    if(!user.isEmpty()) {
                        existingEmail = user.get(0).getEmail();
                        existingUsername = user.get(0).getUsername();
                        if (existingEmail != null && email.equals(existingEmail)) {
                            out.println(this.alert("Korisnik sa ovim email-om postoji !"));
                            error = true;
                        } else if(existingUsername != null && username.equals(existingUsername)) {
                            out.println(this.alert("Korisnik sa ovim username-om postoji !"));
                            error = true;
                        }  else {
                            out.println(this.alert("Doslo je do greske !"));
                            error = true;
                        }
                    } else {
                        User u = new User(username, firstname, lastname, email, password, permission, orders);
                        DB.insert(u);
                        response.sendRedirect("index.html");
                    }
                } else {
                    out.println(this.alert("Ne poklapaju se sifre !"));
                    error = true;
                }
            }
            if(error == true) {
                out.println("<script type=\"text/javascript\">");
                out.println("setTimeout(() => location.href = '/CarShopWebApplication/signup.jsp')");
                out.println("</script>");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
