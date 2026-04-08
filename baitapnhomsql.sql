
USE furniture_web;


DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS contacts;


CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) 
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price FLOAT,
    description VARCHAR(100),
    image VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_price FLOAT,
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price FLOAT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    message VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO categories (category_name) VALUES
(N'Bàn ăn'),
(N'Ghế ăn'),
(N'Bàn làm việc'),
(N'Ghế xoay'),
(N'Giường ngủ'),
(N'Tủ quần áo'),
(N'Tủ dầud giường'),
(N'sofa'),
(N'Bàn trà'),
(N'Kệ tivi'),
(N'Tủ giày'),
(N'Kệ sách'),
(N'Bàn học'),
(N'Ghế học sinh'),
(N'Tủ bếp'),
(N'Bàn đảo bếp'),
(N'kệ treo tường'),
(N'Tủ rượu'),
(N'Bang trang điểm'),
(N'Giương đứng'),
(N'Gương treo tường'),
(N'Đèn bàn'),
(N'Đèn trần'),
(N'rèm cửa'),
(N'Thảm trải sàn'),
(N'Tủ lạnh'),
(N'Máy giặt'),
(N'kệ trang trí'),
(N'Ghế thư giãn'),
(N'Bàn gấp');

INSERT INTO products (product_name, price, description, image, category_id) VALUES
(N'Bàn ăn gỗ', 320000, N'Bàn ăn gia đình 4 ghế', 'ban_an.jpg', 1),
(N'Ghế ăn gỗ', 700000, N'Ghế ăn chắc chắn', 'ghe_an.jpg', 2),
(N'Bàn làm việc hiện đại', 1500000, N'Bàn làm việc MDF', 'ban_lamviec.jpg', 3),
(N'Ghế xoay văn phòng', 1200000, N'Ghế xoay tiện lợi', 'ghe_xoay.jpg', 4),
(N'Giường ngủ 1m6', 4000000, N'Giường đôi hiện đại', 'giuong.jpg', 5),
(N'Tủ quần áo 3 cánh', 3500000, N'Tủ gỗ tự nhiên', 'tu_ao.jpg', 6),
(N'Tủ đầu giường nhỏ', 900000, N'Tủ mini tiện lợi', 'tu_daugiuong.jpg', 7),
(N'Sofa phòng khách', 5500000, N'Sofa nỉ cao cấp', 'sofa.jpg', 8),
(N'Bàn trà sofa', 1200000, N'Bàn nhỏ phòng khách', 'ban_tra.jpg', 9),
(N'Kệ tivi gỗ', 2000000, N'Kệ phòng khách', 'ke_tivi.jpg', 10),
(N'Tủ giày thông minh', 1500000, N'Tủ tiết kiệm diện tích', 'tu_giay.jpg', 11),
(N'Kệ sách 5 tầng', 1200000, N'Kệ sách gỗ', 'ke_sach.jpg', 12),
(N'Bàn học sinh', 1000000, N'Bàn học nhỏ gọn', 'ban_hoc.jpg', 13),
(N'Ghế học sinh', 500000, N'Ghế học tiện lợi', 'ghe_hoc.jpg', 14),
(N'Tủ bếp trên', 3000000, N'Tủ bếp hiện đại', 'tu_bep.jpg', 15),
(N'Bàn đảo bếp', 4500000, N'Bàn bếp đa năng', 'ban_dao.jpg', 16),
(N'Kệ treo tường', 600000, N'Tiết kiệm không gian', 'ke_treo.jpg', 17),
(N'Tủ rượu gỗ', 3800000, N'Tủ trưng bày rượu', 'tu_ruou.jpg', 18),
(N'Bàn trang điểm', 2000000, N'Bàn có gương', 'ban_trangdiem.jpg', 19),
(N'Gương đứng toàn thân', 900000, N'Gương lớn', 'guong_dung.jpg', 20),
(N'Gương treo tường', 600000, N'Gương trang trí', 'guong_treo.jpg', 21),
(N'Đèn bàn học', 400000, N'Đèn học chống cận', 'den_ban.jpg', 22),
(N'Đèn trần phòng khách', 1500000, N'Đèn trang trí', 'den_tran.jpg', 23),
(N'Rèm cửa phòng ngủ', 1200000, N'Rèm vải cao cấp', 'rem.jpg', 24),
(N'Thảm trải sàn', 800000, N'Thảm trang trí', 'tham.jpg', 25),
(N'Tủ lạnh 2 cửa', 8000000, N'Tủ lạnh gia đình', 'tulanh.jpg', 26),
(N'Máy giặt cửa ngang', 7000000, N'Máy giặt hiện đại', 'maygiat.jpg', 27),
(N'Kệ trang trí', 900000, N'Kệ decor', 'ke_trangtri.jpg', 28),
(N'Ghế thư giãn', 2000000, N'Ghế lười thoải mái', 'ghe_thugian.jpg', 29),
(N'Bàn gấp tiện lợi', 600000, N'Bàn gấp tiết kiệm diện tích', 'ban_gap.jpg', 30);
