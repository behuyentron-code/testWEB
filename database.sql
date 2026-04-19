CREATE DATABASE IF NOT EXISTS furniture_web;
USE furniture_web;


DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS contacts;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `furniture_web`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Phòng Khách'),
(2, 'Phòng Ngủ'),
(3, 'Phòng Bếp'),
(4, 'Bàn Ghế Làm Việc'),
(5, 'Trang Trí Decor'),
(6, 'Đèn');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `contact_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `message` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `total_price` float DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `price` float DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `price`, `description`, `image`, `category_id`) VALUES
(1, 'Bàn ăn gỗ', 320000, 'Bàn ăn gia đình 4 ghế', 'ban_an.jpg', 1),
(2, 'Ghế ăn gỗ', 700000, 'Ghế ăn chắc chắn', 'ghe_an.jpg', 1),
(3, 'Bàn làm việc hiện đại', 1500000, 'Bàn làm việc MDF', 'ban_lamviec.jpg', 2),
(4, 'Ghế xoay văn phòng', 1200000, 'Ghế xoay tiện lợi', 'ghe_xoay.jpg', 2),
(5, 'Giường ngủ 1m6', 4000000, 'Giường đôi hiện đại', 'giuong.jpg', 2),
(6, 'Tủ quần áo 3 cánh', 3500000, 'Tủ gỗ tự nhiên', 'tu_ao.jpg', 2),
(7, 'Tủ đầu giường nhỏ', 900000, 'Tủ mini tiện lợi', 'tu_daugiuong.jpg', 2),
(8, 'Sofa phòng khách', 5500000, 'Sofa nỉ cao cấp', 'sofa.jpg', 1),
(9, 'Bàn trà sofa', 1200000, 'Bàn nhỏ phòng khách', 'ban_tra.jpg', 1),
(10, 'Kệ tivi gỗ', 2000000, 'Kệ phòng khách', 'ke_tivi.jpg', 1),
(11, 'Tủ giày thông minh', 1500000, 'Tủ tiết kiệm diện tích', 'tu_giay.jpg', 1),
(12, 'Kệ sách 5 tầng', 1200000, 'Kệ sách gỗ', 'ke_sach.jpg', 1),
(13, 'Bàn học sinh', 1000000, 'Bàn học nhỏ gọn', 'ban_hoc.jpg', 2),
(14, 'Ghế học sinh', 500000, 'Ghế học tiện lợi', 'ghe_hoc.jpg', 4),
(15, 'Tủ bếp trên', 3000000, 'Tủ bếp hiện đại', 'tu_bep.jpg', 3),
(16, 'Bàn đảo bếp', 4500000, 'Bàn bếp đa năng', 'ban_dao.jpg', 3),
(17, 'Kệ treo tường', 600000, 'Tiết kiệm không gian', 'ke_treo.jpg', 5),
(18, 'Tủ rượu gỗ', 3800000, 'Tủ trưng bày rượu', 'tu_ruou.jpg', 3),
(19, 'Bàn trang điểm', 2000000, 'Bàn có gương', 'ban_trangdiem.jpg', 2),
(20, 'Gương đứng toàn thân', 900000, 'Gương lớn', 'guong_dung.jpg', 2),
(21, 'Gương treo tường', 600000, 'Gương trang trí', 'guong_treo.jpg', 2),
(22, 'Đèn bàn học', 400000, 'Đèn học chống cận', 'den_ban.jpg', 6),
(23, 'Đèn trần phòng khách', 1500000, 'Đèn trang trí', 'den_tran.jpg', 6),
(24, 'Rèm cửa phòng ngủ', 1200000, 'Rèm vải cao cấp', 'rem.jpg', 2),
(25, 'Thảm trải sàn', 800000, 'Thảm trang trí', 'tham.jpg', 5),
(26, 'Tủ lạnh 2 cửa', 8000000, 'Tủ lạnh gia đình', 'tulanh.jpg', 3),
(27, 'Máy giặt cửa ngang', 7000000, 'Máy giặt hiện đại', 'maygiat.jpg', 6),
(28, 'Kệ trang trí', 900000, 'Kệ decor', 'ke_trangtri.jpg', 5),
(29, 'Ghế thư giãn', 2000000, 'Ghế lười thoải mái', 'ghe_thugian.jpg', 4),
(30, 'Bàn gấp tiện lợi', 600000, 'Bàn gấp tiết kiệm diện tích', 'ban_gap.jpg', 4);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);
COMMIT;
