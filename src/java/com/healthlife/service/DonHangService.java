package com.healthlife.service;

import com.healthlife.dao.DonHangDAO;
import com.healthlife.dao.interfaces.IDonHangDAO;
import com.healthlife.model.ChiTietDonHang;
import com.healthlife.model.DonHang;
import java.util.List;

public class DonHangService implements IDonHangService {
    
    private IDonHangDAO donHangDAO;

    public DonHangService() {
        this.donHangDAO = new DonHangDAO();
    }

    @Override
    public List<DonHang> getAllOrders() {
        return donHangDAO.getAllOrders();
    }

    @Override
    public DonHang getOrderById(int id) {
        return donHangDAO.getOrderById(id);
    }

    @Override
    public List<ChiTietDonHang> getOrderDetails(int orderId) {
        return donHangDAO.getOrderDetails(orderId);
    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        return donHangDAO.updateOrderStatus(orderId, status);
    }
    
    @Override
    public boolean updatePaymentStatus(int orderId, String paymentStatus) {
        return donHangDAO.updatePaymentStatus(orderId, paymentStatus);
    }
}