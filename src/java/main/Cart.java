 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;

/**
 *
 * @author Dragan
 */
@WebServlet(name = "Cart", urlPatterns = {"/cart"})
public class Cart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("user");

        if(user == null){
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type=\"text/javascript\">alert('You must be logged in !')</script>");
                out.println("<script type=\"text/javascript\">");
                out.println("setTimeout(() => location.href = '/CarShopWebApplication/index.html')");
                out.println("</script>");
                return;
            }
       }
        
        String modelId = request.getParameter("selectedModel");
        String equipmentId = request.getParameter("selectedEquipment");
        String colorId = request.getParameter("selectedColor");

        List<Model> model = DB.query("SELECT m FROM Model m where m.id=?", Integer.parseInt(modelId));
        List<LevelOfEquipment> level = DB.query("SELECT l FROM LevelOfEquipment l where l.id=?", Integer.parseInt(equipmentId));
        List<Color> color = DB.query("SELECT c FROM Color c where c.id=?", Integer.parseInt(colorId));
        
        Car car = new Car();
        car.setModel(model.get(0));
        car.setLevelOfEquipment(level.get(0));
        car.setColor(color.get(0));
        DB.insert(car);
        List<Car> cars = DB.query("SELECT c FROM Car c order by c.id desc");
        
        Order order = new Order();
        order.setStatus("Temporary");
        order.setPrice(model.get(0).getPrice());
        order.setCar(cars.get(0));
        order.setUser(user);
        DB.insert(order);
        List<Order> orders = DB.query("SELECT o FROM Order o order by o.id desc");

        response.sendRedirect("cart.jsp?orderId=" + orders.get(0).getId());
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
