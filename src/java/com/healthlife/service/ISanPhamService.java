package com.healthlife.service;

import com.healthlife.model.SanPham;
import java.util.List;

public interface ISanPhamService {
    List<SanPham> getAllProducts();
    List<SanPham> getProductsByCategoryID(String categoryId);
    SanPham getProductById(int id);
    List<SanPham> searchProductsByName(String keyword);  // Thêm mới
     boolean addProduct(SanPham sp);
    boolean updateProduct(SanPham sp);
    boolean deleteProduct(int id);

    public List<SanPham> getTopSellingProducts(int i);
}