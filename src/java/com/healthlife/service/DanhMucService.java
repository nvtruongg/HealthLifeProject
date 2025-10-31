/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.service;

import com.healthlife.dao.DanhMucDAO;
import com.healthlife.dao.interfaces.IDanhMucDAO;
import com.healthlife.model.DanhMuc;
import java.util.List;

/**
 *
 * @author Nguyen Viet Truong
 */
public class DanhMucService implements IDanhMucService{

    IDanhMucDAO danhMucDAO;

    public DanhMucService() {
        danhMucDAO = new DanhMucDAO();
    }
    
    
    @Override
    public List<DanhMuc> getAllCategories() {
        return danhMucDAO.getAllCategories();
    }
    
}
