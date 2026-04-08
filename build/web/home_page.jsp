<%@page import="Model.products"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
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
            <a href="#">Sản Phẩm</a>
            <a href="#">Khuyến Mãi</a>
            <a href="#">Liên Hệ</a>
        </div>

        <div class="auth-buttons">
            <a href="#" class="cart-btn" onclick="return false;">
                <i class="fa-solid fa-cart-shopping"></i>Giỏ hàng 
                <span class="cart-count" id="cartCount">0</span>
            </a>
            <a href="#" class="btn-login">Đăng Nhập</a>
            <a href="#" class="btn-register">Đăng Ký</a>
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
                        
                    <button>  Xem thêm </button>    
                        
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

    <script>
        let cartCount = 0;
        function addToCart(id, name) {
            cartCount++;
            document.getElementById('cartCount').textContent = cartCount;
            console.log("Added to cart: " + name + " (ID: " + id + ")");
        }
    </script>
</body>
</html>