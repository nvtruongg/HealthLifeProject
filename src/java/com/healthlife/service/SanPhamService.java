package com.healthlife.service;

import com.healthlife.dao.SanPhamDAO;
import com.healthlife.dao.interfaces.ISanPhamDAO;
import com.healthlife.model.SanPham;
import java.util.List;

public class SanPhamService implements ISanPhamService {
    private ISanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    public List<SanPham> getAllProducts() {
        return sanPhamDAO.getAllProducts();
    }

    @Override
    public List<SanPham> getProductsByCategoryID(String categoryId) {
        return sanPhamDAO.getProductsByCategoryID(categoryId);
    }

    @Override
    public SanPham getProductById(int id) {
        return sanPhamDAO.getProductById(id);
    }

    // Thêm mới cho tìm kiếm
    @Override
    public List<SanPham> searchProductsByName(String keyword) {
        return sanPhamDAO.searchProductsByName(keyword);
    }
}