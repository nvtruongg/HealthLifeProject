/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.service;

import com.healthlife.dao.OrderDAO;
import com.healthlife.dao.interfaces.IOrderDAO;
import com.healthlife.model.Cart;
import com.healthlife.model.CartItem;
import com.healthlife.model.DonHang;
import com.healthlife.model.SanPham;
import java.util.Map;

/**
 *
 * @author Nguyen Viet Truong
 */ 
public class OrderService implements IOrderService{
    IOrderDAO orderDAO;
    ISanPhamService sanPhamService;

    public OrderService() {
        this.orderDAO = new OrderDAO();
        this.sanPhamService = new SanPhamService();// Tiêm phụ thuộc
    }

    @Override
    public int placeOrder(DonHang donHang, Cart cart) throws Exception {
        // 1. Lấy ra các sản phẩm đã chọn
        Map<Integer, CartItem> selectedItems = cart.getSelectedItems();

        if (selectedItems.isEmpty()) {
            throw new Exception("Không có sản phẩm nào được chọn để thanh toán.");
        }
        
        // 2. LOGIC NGHIỆP VỤ: Kiểm tra tồn kho (Rất quan trọng)
        for (CartItem item : selectedItems.values()) {
            // Lấy thông tin sản phẩm mới nhất từ CSDL
            SanPham sp_in_db = sanPhamService.getProductById(item.getSanPham().getId());
            
            if (sp_in_db == null) {
                throw new Exception("Sản phẩm " + item.getSanPham().getTenSanPham() + " không còn tồn tại.");
            }
            
            if (item.getSoLuong() > sp_in_db.getSoLuongTon()) {
                throw new Exception("Sản phẩm '" + sp_in_db.getTenSanPham() + 
                                  "' không đủ hàng (Chỉ còn " + sp_in_db.getSoLuongTon() + " sản phẩm).");
            }
        }
        
        // 3. Cập nhật lại tổng tiền (dựa trên các SP đã chọn)
        donHang.setTongTienSanPham(cart.getTongTienHangDaChon());
        // (Tính toán lại phí vận chuyển và tổng thanh toán nếu cần)
        // Tạm thời:
        donHang.setTongThanhToan(cart.getTongTienHangDaChon().add(donHang.getPhiVanChuyen()));

        // 4. Mọi thứ OK, gọi DAO để lưu (chỉ lưu các SP đã chọn)
        return orderDAO.saveOrder(donHang, selectedItems);
    }
}
