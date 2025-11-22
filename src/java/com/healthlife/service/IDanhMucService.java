package com.healthlife.service;

import com.healthlife.model.DanhMuc;
import java.util.List;

/**
 * Interface cho DanhMuc Service.
 * Đã đổi tên từ ICategoryService
 */
public interface IDanhMucService {
    
    List<DanhMuc> getAllCategories();
    
    boolean addCategory(String ten, String moTa, Integer idCha);
    
    boolean deleteCategory(int id);
    
    // --- THÊM MỚI ---
    
    /**
     * Lấy một danh mục theo ID (để sửa).
     * @param id
     * @return đối tượng DanhMuc.
     */
    DanhMuc getCategoryById(int id);
    
    /**
     * Xử lý logic cập nhật danh mục.
     * @param danhMuc
     * @return true nếu thành công.
     */
    boolean updateCategory(DanhMuc danhMuc);
}