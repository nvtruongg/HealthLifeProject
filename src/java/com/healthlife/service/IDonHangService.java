package com.healthlife.service;

import com.healthlife.model.ChiTietDonHang;
import com.healthlife.model.DonHang;
import java.util.List;

public interface IDonHangService {
    List<DonHang> getAllOrders();
    DonHang getOrderById(int id);
    List<ChiTietDonHang> getOrderDetails(int orderId);
    boolean updateOrderStatus(int orderId, String status);
    boolean updatePaymentStatus(int orderId, String paymentStatus);
}