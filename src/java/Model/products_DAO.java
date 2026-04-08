/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */

import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class products_DAO {
//    Connection cnn = null;
//    PreparedStatement ps = null;
//    
//    public List<products> getAll () throws Exception {
//        if (cnn == null){
//            cnn = new dbConnect().getConnect();
//        }
//        String sql = "Select * from products";
//        ps = cnn.prepareStatement(sql);
//        ResultSet rs = ps.executeQuery();
//        
//        List<products> list = new ArrayList();
//        while (rs.next()){
//            products p = new products();
//            p.setProduct_id(rs.getInt("product_id"));
//            p.setProduct_name(rs.getString("product_name"));
//            p.setPrice(rs.getDouble("price"));
//            p.setDescription(rs.getString("description"));
//            p.setImage(rs.getString("image"));
//            p.setCategory_id(rs.getInt("category_id"));
//            list.add(p);
//        }
//        return list;
//    }
//    
//    public List<products> Search (String ten) throws Exception {
//        if (cnn == null){
//            cnn = new dbConnect().getConnect();
//        }
//        String sql = "Select * from products where product_name  Like ? ";
//        ps = cnn.prepareStatement(sql);
//        ps.setString(1, "%" + ten + "%");
//        ResultSet rs = ps.executeQuery();
//        
//        List<products> list = new ArrayList();
//        while (rs.next()){
//            products p = new products();
//            p.setProduct_id(rs.getInt("product_id"));
//            p.setProduct_name(rs.getString("product_name"));
//            p.setPrice(rs.getDouble("price"));
//            p.setDescription(rs.getString("description"));
//            p.setImage(rs.getString("image"));
//            p.setCategory_id(rs.getInt("category_id"));
//            list.add(p);
//        }
//        return list;
//    }
//    
//    public products getByID (int ma) throws Exception {
//        if (cnn == null){
//            cnn = new dbConnect().getConnect();
//        }
//        String sql = "Select * from products where category_id = " + ma;
//        ps = cnn.prepareStatement(sql);
//        ResultSet rs = ps.executeQuery();
//        
//        List<products> list = new ArrayList();
//        if (rs.next()){
//            products p = new products();
//            p.setProduct_id(rs.getInt("product_id"));
//            p.setProduct_name(rs.getString("product_name"));
//            p.setPrice(rs.getDouble("price"));
//            p.setDescription(rs.getString("description"));
//            p.setImage(rs.getString("image"));
//            p.setCategory_id(rs.getInt("category_id"));
//        
//            
//            return p;
//        }
//        return null;
//    }
    
    private static final String BASE_SQL =
        "SELECT p.product_id, p.product_name, p.price, p.description, " +
        "       p.image, p.category_id, c.category_name " +
        "FROM products p " +
        "JOIN categories c ON p.category_id = c.category_id ";
 
    /** Lấy tất cả sản phẩm */
    public List<products> getAllProducts() {
        System.out.println("=== getAllProducts called ===");
        return query(BASE_SQL + "ORDER BY p.product_id ASC", null);
    }
 
    /** Lọc theo tên danh mục */
    public List<products> getProductsByCategory(String categoryName) {
        System.out.println("=== getProductsByCategory: " + categoryName + " ===");
        return query(BASE_SQL + "WHERE c.category_name = ? ORDER BY p.product_id ASC", categoryName);
    }
 
    /** Lấy danh sách tên tất cả danh mục */
    public List<String> getAllCategoryNames() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT category_name FROM categories ORDER BY category_id ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = new dbConnect().getConnect();
            System.out.println("Database connected successfully");
            
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(rs.getString("category_name"));
            }
            System.out.println("Categories found: " + list.size());
            
        } catch (SQLException e) {
            System.err.println("[ProductDAO] getAllCategoryNames SQL Error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception ex) {
            System.err.println("[ProductDAO] getAllCategoryNames Error: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch(Exception e) {}
            try { if (ps != null) ps.close(); } catch(Exception e) {}
            try { if (conn != null) conn.close(); } catch(Exception e) {}
        }
        return list;
    }
 
    private List<products> query(String sql, String param) {
        List<products> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = new dbConnect().getConnect();
            ps = conn.prepareStatement(sql);
 
            if (param != null) {
                ps.setString(1, param);
                System.out.println("Executing query with param: " + param);
            }
            
            System.out.println("SQL: " + sql);
            rs = ps.executeQuery();
 
            while (rs.next()) {
                products p = new products(
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getDouble("price"),
                    rs.getString("description"),
                    rs.getString("image"),
                    rs.getInt("category_id"),
                    rs.getString("category_name")
                );
                list.add(p);
                System.out.println("Loaded product: " + p.getProduct_name());
            }
            System.out.println("Total products loaded: " + list.size());
            
        } catch (SQLException e) {
            System.err.println("[ProductDAO] query SQL Error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception ex) {
            System.err.println("[ProductDAO] query Error: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch(Exception e) {}
            try { if (ps != null) ps.close(); } catch(Exception e) {}
            try { if (conn != null) conn.close(); } catch(Exception e) {}
        }
        return list;
    }

}
