
package sample.controllers;

import java.awt.event.FocusEvent;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.shopping.Cart;
import sample.shopping.Clothes;
import sample.users.UserDAO;
import sun.awt.KeyboardFocusManagerPeerImpl;


@WebServlet(name = "AddController", urlPatterns = {"/AddController"})
public class AddController extends HttpServlet {

    private static final String ERROR = "MainController?action=Shopping_Page";
    private static final String SUCCESS = "MainController?action=Shopping_Page";


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean checkAdd = false;
            Clothes clothes = null;
            HttpSession session = request.getSession();
            String id = request.getParameter("id");
            int quantity = Integer.parseInt(request.getParameter("cmbQuantity"));
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart == null) {
                cart = new Cart();
            }
            boolean checkitem = cart.checkitem(id);
            if (!checkitem) {
                UserDAO dao = new UserDAO();
                clothes = dao.ADDANDUPDATE(id, quantity);
                clothes.setQuantity(quantity);

                checkAdd = cart.add(clothes);
                session.setAttribute("MESSAGE2", "");
            } else {
                session.setAttribute("MESSAGE2", "you have add this item in your cart, you can update quantity in that");
                url = SUCCESS;
                return;
            }
            if (checkAdd) {
                session.setAttribute("CART", cart);
                session.setAttribute("MESSAGE", "You have successfully add " + clothes.getName() + " with quantity " + clothes.getQuantity());
                url = SUCCESS;
            } else {
                session.setAttribute("MESSAGE", "Add false " + clothes.getName() + " with quantity " + clothes.getQuantity());
            }
         
        } catch (Exception e) {
            log("Error at AddController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
