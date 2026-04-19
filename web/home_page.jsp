<%@page import="Model.products"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <%
    String user = (String) session.getAttribute("user");
    %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội Thất Hiện Đại - Trang Chủ</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header class="banner">
        DECOR LUXURY - NÂNG TẦM KHÔNG GIAN SỐNG
    </header>

    <nav class="top-menu">
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/hienthi">Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/productDetail">Chi Tiết Sản Phẩm</a>
            <a href="#">Khuyến Mãi</a>
            <a href="lienhe.jsp">Liên hệ</a> 
            
        </div>

        <div class="auth-buttons">
            <a href="cart.jsp" class="cart-btn">
                <i class="fa-solid fa-cart-shopping"></i> Giỏ hàng
                <span class="cart-count" id="cartCount">
                    <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : 0 %>
                </span>
            </a>
                
           <% if(user != null){ %>
                <span style="color:white;">Xin chào, <%= user %></span>
                <a href="logout.jsp">Đăng xuất</a>
            <% } else { %>
                <a href="#" class="btn-login" onclick="openLogin()" >Đăng Nhập</a>
                <a href="#" class="btn-register" onclick="openRegister()">Đăng Ký</a>
            <% } %>
            
        </div>
    </nav>
        
    <div class="container">
        <aside class="left-menu">
            <h3>DANH MỤC</h3>
            <ul>
                <li onclick="location.href='${pageContext.request.contextPath}/hienthi'">Tất Cả</li>
                <% 
                    java.util.List<String> categories = (java.util.List<String>) request.getAttribute("categories");
                    if(categories != null && !categories.isEmpty()) {
                        for(String cat : categories) {
                %>
                   
                <li onclick="location.href='${pageContext.request.contextPath}/hienthi?category=<%= cat %>'"><%= cat %></li>
                
                <% 
                        }
                    } else {
                %>
                    
                    <li>Không có danh mục</li>
                
                <% 
                    }
                %>
            </ul>
        </aside>

        <main class="content">
            <h2 style="margin-bottom: 20px; color: #333;">
                <% 
                    String selectedCategory = (String) request.getAttribute("selectedCategory");
                    if(selectedCategory != null && !selectedCategory.isEmpty()) {
                        out.print(selectedCategory);
                    } else {
                        out.print("Tất cả sản phẩm");
                    }
                %>
            </h2>

            <% 
                java.util.List<products> productList = (java.util.List<products>) request.getAttribute("products");
                NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                
                if(productList == null || productList.isEmpty()) {
            %>
                <p style="color:#888; text-align:center; margin-top:40px;">Không có sản phẩm nào trong danh mục này.</p>
            <% 
                } else {
                    for(products p : productList) {
                        String formattedPrice = currencyFormat.format(p.getPrice());
            %>
            
                <div class="product">
                    <img src="${pageContext.request.contextPath}/images/<%= p.getImage() != null ? p.getImage() : "default.jpg" %>"
                         alt="<%= p.getProduct_name() %>"
                         onerror="this.src='https://placehold.co/500x300?text=<%= p.getProduct_name() %>'">
                    <h4><%= p.getProduct_name() %></h4>
                    <p class="product-desc"><%= p.getDescription() != null ? p.getDescription() : "Không có mô tả" %></p>
                    <p><%= formattedPrice %></p>
                    <button onclick="addToCart(<%= p.getProduct_id() %>, '<%= p.getProduct_name() %>')">
                        Thêm vào giỏ
                    </button>
                        
                    <button onclick="location.href='${pageContext.request.contextPath}/productDetail?id=<%= p.getProduct_id() %>'">Xem thêm</button>    
                        
                </div>
            <% 
                    }
                }
            %>
        </main>
    </div>

    <footer class="footer">
        <div>
            <h3>Nhóm 3</h3>
            <p>Lã Ngọc Huyền    | 29-08-2005 </p>
            <p>Trần Anh Đức     | 11-11-2005 </p>
            <p>Nguyễn Phi Long  | 14-06-2005 </p>
        </div>
        
        <div class="footer-logo">
            <img src="./images/logo.png">
        </div>
        
    </footer>

    <!-- ================= MODAL LOGIN ================= -->
<!--    <form action="loginServlet" method="post">
        <%
            String loginError = (String) session.getAttribute("loginError");
            if (loginError != null) {
                session.removeAttribute("loginError"); // xóa sau khi hiển thị
        %>
            <p style="color: red;"><%= loginError %></p>
        <% } %>
        <input type="text" name="username" placeholder="Email" required>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <button type="submit" name="action" value="login">Đăng nhập</button>
    </form>-->
    
<div id="loginModal" class="modal">
    <div class="modal-box">
        <span class="close" onclick="closeModal('loginModal')">&times;</span>

        <h2>Đăng nhập</h2>

        <form action="loginServlet" method="post">
            <input type="text" name="username" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mật khẩu" required>
            <button type="submit" name="action" value="login">Đăng nhập</button>
        </form>

        <p style="color: #ffffff">
            
                    <a href="#" style="color: #ffffff">Quên mật khẩu</a>
                    <span>|</span>
            <a href="#" onclick="switchModal('loginModal','registerModal')" style="color: #ffffff">Đăng ký</a>
        </p>
    </div>
</div>

<!-- ================= MODAL REGISTER ================= -->
<div id="registerModal" class="modal">
    <div class="modal-box">
        <span class="close" onclick="closeModal('registerModal')">&times;</span>

        <h2>Đăng ký</h2>

        <form action="loginServlet" method="post">
            <input type="text" name="username" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mật khẩu" required>
            <input type="password" name="password" placeholder="Nhập lại mật khẩu" required>

            <button type="submit" name="action" value="register">Đăng ký</button>
        </form>

        <p style="color: #ffffff" >Đã có tài khoản?
            <a href="#" onclick="switchModal('registerModal','loginModal')" style="color: #ffffff">Đăng nhập</a>
        </p>
    </div>
</div>
<!-- LOGIN MODAL -->
<!--<div id="loginModal" class="modal-overlay">
    <div class="modal-box">
        <h2>Đăng nhập</h2>

        <form action="loginServlet" method="post">
            <input type="text" name="username" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mật khẩu" required>

            <button type="submit" name="action" value="login">Đăng nhập</button>
        </form>

        <p>
            <a href="#" onclick="switchModal('loginModal','registerModal')">Đăng ký</a>
        </p>
    </div>
</div>-->

<!-- REGISTER MODAL -->
<div id="registerModal" class="modal-overlay">
    <div class="modal-box">
        <h2>Đăng ký</h2>

        <form action="loginServlet" method="post">
            <input type="text" name="username" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mật khẩu" required>

            <button type="submit" name="action" value="register">Đăng ký</button>
        </form>

        <p>
            <a href="#" onclick="switchModal('registerModal','loginModal')">Đăng nhập</a>
        </p>
    </div>
</div>

<script>
let cartCount = 0;
function addToCart() {
    cartCount++;
    document.getElementById('cartCount').textContent = cartCount;
}

// ===== MODAL =====
// Tự động mở modal nếu redirect về do lỗi
const urlParams = new URLSearchParams(window.location.search);
const openModal = urlParams.get("openModal");
if (openModal === "login") openLogin();
if (openModal === "register") openRegister();


function openLogin() {
    document.getElementById("loginModal").style.display = "flex";
}
function openRegister() {
    document.getElementById("registerModal").style.display = "flex";
}
function closeModal(id) {
    document.getElementById(id).style.display = "none";
}
function switchModal(closeId, openId) {
    closeModal(closeId);
    document.getElementById(openId).style.display = "flex";
}
</script>

</body>
</html>