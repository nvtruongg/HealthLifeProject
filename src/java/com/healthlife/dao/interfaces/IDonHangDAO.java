package com.healthlife.dao.interfaces;

import com.healthlife.model.ChiTietDonHang;
import com.healthlife.model.DonHang;
import java.util.List;

public interface IDonHangDAO {
    // Lấy tất cả đơn hàng (sắp xếp mới nhất trước)
    List<DonHang> getAllOrders();
    
    // Lấy đơn hàng theo ID
    DonHang getOrderById(int id);
    
    // Lấy chi tiết sản phẩm của 1 đơn hàng
    List<ChiTietDonHang> getOrderDetails(int orderId);
    
    // Cập nhật trạng thái đơn hàng (ví dụ: xác nhận, hủy, giao hàng)
    boolean updateOrderStatus(int orderId, String status);
    
    // Cập nhật trạng thái thanh toán
    boolean updatePaymentStatus(int orderId, String paymentStatus);
}