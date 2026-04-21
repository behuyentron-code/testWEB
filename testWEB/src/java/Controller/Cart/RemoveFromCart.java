/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Cart;

import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author LaNgocHuyen
 */


/**
 * Xóa 1 sản phẩm khỏi giỏ hàng
 */

public class RemoveFromCart extends HttpServlet {

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String productIdParam = request.getParameter("productId");

        if (productIdParam != null) {
            try {
                int productId = Integer.parseInt(productIdParam);
                Map<Integer, Object[]> cart =
                    (Map<Integer, Object[]>) session.getAttribute("cart");

                if (cart != null) {
                    cart.remove(productId);
                    session.setAttribute("cart", cart);

                    // Cập nhật lại cartCount
                    int cartCount = 0;
                    for (Object[] entry : cart.values()) {
                        cartCount += (int) entry[1];
                    }
                    session.setAttribute("cartCount", cartCount);
                }
            } catch (NumberFormatException e) {
                // productId không hợp lệ, bỏ qua
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
}