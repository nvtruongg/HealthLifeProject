package com.healthlife.dao.interfaces;

import com.healthlife.model.DanhMuc;
import java.util.List;

/**
 * Interface cho DanhMuc DAO.
 * Đã đổi tên từ ICategoryDAO
 */
public interface IDanhMucDAO {
    
    List<DanhMuc> getAllCategories();
    
    
    boolean addCategory(String ten, String moTa, Integer idCha);
    
   
    boolean deleteCategory(int id);
    
    
    
    DanhMuc getCategoryById(int id);
    
  
    boolean updateCategory(DanhMuc danhMuc);
}