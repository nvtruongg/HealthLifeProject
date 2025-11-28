/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.dao.interfaces;
import com.healthlife.model.SanPham;
import java.util.List;
/**
 *
 * @author Nguyen Viet Truong
 */
public interface ISanPhamDAO {
    List<SanPham> getAllProducts();
    List<SanPham> getProductsByCategoryID(String categoryId);
    SanPham getProductById(int id);
    List<SanPham> searchProductsByName(String keyword);  // Thêm mới cho tìm kiếm
    boolean addProduct(SanPham sp);
    boolean updateProduct(SanPham sp);
    boolean deleteProduct(int id);
    List<SanPham> filterProducts(String categoryId, String brandId, String priceRange, String sortType);
}