package Controller.Cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author LaNgocHuyen
 */

/**
 * Cập nhật số lượng sản phẩm trong giỏ hàng (dùng cho nút +/- ở cart.jsp)
 */
@WebServlet("/updateCart")
public class UpdateCart extends HttpServlet {

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String productIdParam = request.getParameter("productId");
        String qtyParam       = request.getParameter("qty");

        if (productIdParam == null || qtyParam == null) {
            response.getWriter().write("{\"status\":\"error\",\"cartCount\":0}");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);
            int qty       = Integer.parseInt(qtyParam);
            if (qty < 1) qty = 1;
            if (qty > 99) qty = 99;

            Map<Integer, Object[]> cart =
                (Map<Integer, Object[]>) session.getAttribute("cart");

            if (cart != null && cart.containsKey(productId)) {
                cart.get(productId)[1] = qty;
                session.setAttribute("cart", cart);
            }

            int cartCount = 0;
            if (cart != null) {
                for (Object[] entry : cart.values()) {
                    cartCount += (int) entry[1];
                }
            }
            session.setAttribute("cartCount", cartCount);

            try (PrintWriter out = response.getWriter()) {
                out.print("{\"status\":\"ok\",\"cartCount\":" + cartCount + "}");
            }

        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\",\"cartCount\":0}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
}