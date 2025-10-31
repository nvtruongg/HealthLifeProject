/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.service;

import com.healthlife.dao.SanPhamDAO;
import com.healthlife.dao.interfaces.ISanPhamDAO;
import com.healthlife.model.SanPham;
import java.util.List;

/**
 *
 * @author Nguyen Viet Truong
 */
public class SanPhamService implements ISanPhamService{
    ISanPhamDAO sanPhamDAO;
    public SanPhamService(){
        sanPhamDAO = new SanPhamDAO();
    }

    @Override
    public List<SanPham> getAllProducts() {
        return sanPhamDAO.getAllProducts();
    }

    @Override
    public List<SanPham> getProductsByCategoryID(String categoryId) {
        return sanPhamDAO.getProductsByCategoryID(categoryId);
    }
}
