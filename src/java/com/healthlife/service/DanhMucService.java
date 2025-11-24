package com.healthlife.service;


import com.healthlife.dao.DanhMucDAO;
import com.healthlife.dao.interfaces.IDanhMucDAO;

import com.healthlife.model.DanhMuc;
import java.util.List;

/**
 * Triển khai (implements) cho IDanhMucService.
 * Đã đổi tên từ CategoryService
 */
public class DanhMucService implements IDanhMucService {
    
    private IDanhMucDAO danhMucDAO;

    public DanhMucService() {
        // Khởi tạo DAO
        this.danhMucDAO = new DanhMucDAO();
    }

    @Override
    public List<DanhMuc> getAllCategories() {
        return danhMucDAO.getAllCategories();
    }

    @Override
    public boolean addCategory(String ten, String moTa, Integer idCha) {
        if (ten == null || ten.trim().isEmpty()) {
            System.out.println("Logic Service: Tên danh mục không được để trống.");
            return false;
        }
        return danhMucDAO.addCategory(ten, moTa, idCha);
    }

    @Override
    public boolean deleteCategory(int id) {
        // (Bạn có thể thêm logic kiểm tra ràng buộc sản phẩm ở đây)
        return danhMucDAO.deleteCategory(id);
    }
    
    // --- THÊM MỚI ---

    @Override
    public DanhMuc getCategoryById(int id) {
        return danhMucDAO.getCategoryById(id);
    }

    @Override
    public boolean updateCategory(DanhMuc danhMuc) {
        // Thêm logic kiểm tra (giống như khi add)
        if (danhMuc.getTenDanhMuc() == null || danhMuc.getTenDanhMuc().trim().isEmpty()) {
            System.out.println("Logic Service: Tên danh mục không được để trống khi cập nhật.");
            return false;
        }
        return danhMucDAO.updateCategory(danhMuc);
    }
}