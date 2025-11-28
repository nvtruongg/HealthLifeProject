/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.healthlife.service;

import com.healthlife.model.Cart;
import com.healthlife.model.DonHang;
import java.util.List;

/**
 *
 * @author Nguyen Viet Truong
 */
public interface IOrderService {
    /**
     * @return Trả về ID của đơn hàng nếu thành công, ngược lại ném Exception
     */
    int placeOrder(DonHang donHang, Cart cart) throws Exception;
    List<DonHang> getOrdersByUserId(int userId);
}
