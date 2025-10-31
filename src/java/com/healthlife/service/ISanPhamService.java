/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.service;

import com.healthlife.model.SanPham;
import java.util.List;

/**
 *
 * @author Nguyen Viet Truong
 */
public interface ISanPhamService {
    List<SanPham> getAllProducts();
    List<SanPham> getProductsByCategoryID(String categoryId);
}
