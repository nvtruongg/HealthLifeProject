/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.healthlife.dao.interfaces;

import com.healthlife.model.CartItem;
import com.healthlife.model.DonHang;
import java.util.Map;

/**
 *
 * @author Nguyen Viet Truong
 */
public interface IOrderDAO {
    int saveOrder(DonHang donHang, Map<Integer, CartItem> selectedItems) throws Exception;
}
