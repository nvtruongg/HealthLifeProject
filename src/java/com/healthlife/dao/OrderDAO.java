/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.dao;

import com.healthlife.dao.interfaces.IOrderDAO;
import com.healthlife.db.DBContext;
import com.healthlife.model.CartItem;
import com.healthlife.model.DonHang;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Nguyen Viet Truong
 */
public class OrderDAO implements IOrderDAO {

    @Override
    public int saveOrder(DonHang donHang, Map<Integer, CartItem> selectedItems) throws SQLException, Exception {
        Connection conn = null;
        PreparedStatement psDonHang = null;
        PreparedStatement psChiTiet = null;
        PreparedStatement psUpdateStock = null;
        ResultSet rs = null;

        int orderId = -1; 

        String sqlDonHang = "INSERT INTO don_hang (id_nguoi_dung, ma_don_hang, ten_nguoi_nhan, so_dien_thoai_nhan, " +
                            "dia_chi_giao_hang, email_nguoi_nhan, tong_tien_san_pham, phi_van_chuyen, " +
                            "tong_thanh_toan, phuong_thuc_thanh_toan, trang_thai_thanh_toan, trang_thai_don_hang) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        String sqlChiTiet = "INSERT INTO chi_tiet_don_hang (id_don_hang, id_san_pham, so_luong, gia_luc_mua, thanh_tien) " +
                           "VALUES (?, ?, ?, ?, ?)";
                           
        // --- SQL MỚI ĐỂ TRỪ TỒN KHO ---
        // Đảm bảo không bị âm kho (so_luong_ton >= ?)
        String sqlStock = "UPDATE san_pham SET so_luong_ton = so_luong_ton - ? " +
                          "WHERE id = ? AND so_luong_ton >= ?";

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false); // BẮT ĐẦU TRANSACTION

            // 1. Thêm vào bảng 'don_hang'
            psDonHang = conn.prepareStatement(sqlDonHang, Statement.RETURN_GENERATED_KEYS);
            psDonHang.setInt(1, donHang.getIdNguoiDung());
            psDonHang.setString(2, donHang.getMaDonHang()); 
            psDonHang.setString(3, donHang.getTenNguoiNhan());
            psDonHang.setString(4, donHang.getSdtNhan());
            psDonHang.setString(5, donHang.getDiaChiGiaoHang());
            psDonHang.setString(6, donHang.getEmailNguoiNhan());
            psDonHang.setBigDecimal(7, donHang.getTongTienSanPham()); // Lấy tổng tiền đã chọn
            psDonHang.setBigDecimal(8, donHang.getPhiVanChuyen());
            psDonHang.setBigDecimal(9, donHang.getTongThanhToan()); // Lấy tổng tiền đã chọn
            psDonHang.setString(10, donHang.getPhuongThucThanhToan());
            psDonHang.setString(11, "chua_thanh_toan");
            psDonHang.setString(12, "cho_xac_nhan");
            
            psDonHang.executeUpdate();
            rs = psDonHang.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            if (orderId <= 0) {
                 throw new SQLException("Tạo đơn hàng thất bại.");
            }
                
            // 2. Chuẩn bị batch cho 'chi_tiet_don_hang' VÀ 'update_stock'
            psChiTiet = conn.prepareStatement(sqlChiTiet);
            psUpdateStock = conn.prepareStatement(sqlStock);
            
            for (CartItem item : selectedItems.values()) {
                // Thêm vào chi tiết đơn hàng
                psChiTiet.setInt(1, orderId);
                psChiTiet.setInt(2, item.getSanPham().getId());
                psChiTiet.setInt(3, item.getSoLuong());
                psChiTiet.setBigDecimal(4, item.getSanPham().getGiaBan());
                psChiTiet.setBigDecimal(5, item.getTongTien());
                psChiTiet.addBatch();
                
                // Thêm vào batch trừ tồn kho
                psUpdateStock.setInt(1, item.getSoLuong()); // Số lượng trừ
                psUpdateStock.setInt(2, item.getSanPham().getId()); // ID sản phẩm
                psUpdateStock.setInt(3, item.getSoLuong()); // Điều kiện (phải >= số lượng mua)
                psUpdateStock.addBatch();
            }
            
            // 3. Thực thi 2 batch
            psChiTiet.executeBatch();
            int[] updateCounts = psUpdateStock.executeBatch();

            // 4. Kiểm tra kết quả trừ kho
            for (int count : updateCounts) {
                if (count == 0) { // Nếu có 1 sp không trừ được kho (do hết hàng)
                    throw new SQLException("Cập nhật tồn kho thất bại, một sản phẩm có thể đã hết hàng.");
                }
            }
            
            conn.commit(); // --- COMMIT TRANSACTION ---
            return orderId;

        } catch (Exception e) {
            if (conn != null) conn.rollback(); // --- ROLLBACK TRANSACTION ---
            e.printStackTrace();
            throw new Exception("Lỗi khi lưu đơn hàng: " + e.getMessage());
            
        } finally {
            if (conn != null) conn.setAutoCommit(true); 
            if (rs != null) rs.close();
            if (psDonHang != null) psDonHang.close();
            if (psChiTiet != null) psChiTiet.close();
            if (psUpdateStock != null) psUpdateStock.close();
            if (conn != null) conn.close();
        }
    }
    
    @Override
    public List<DonHang> getOrdersByUserId(int userId) {
        List<DonHang> list = new ArrayList<>();
        // Sắp xếp đơn mới nhất lên đầu
        String sql = "SELECT * FROM don_hang WHERE id_nguoi_dung = ? ORDER BY ngay_dat DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                DonHang dh = new DonHang();
                dh.setId(rs.getInt("id"));
                dh.setMaDonHang(rs.getString("ma_don_hang"));
                dh.setNgayDat(rs.getTimestamp("ngay_dat")); // Cần thêm thuộc tính này vào Model DonHang nếu chưa có
                dh.setTongThanhToan(rs.getBigDecimal("tong_thanh_toan"));
                dh.setTrangThaiDonHang(rs.getString("trang_thai_don_hang"));
                dh.setDiaChiGiaoHang(rs.getString("dia_chi_giao_hang"));
                // Các trường khác nếu cần...
                
                list.add(dh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public DonHang getOrderById(int orderId) {
        // (Bạn có thể triển khai tương tự nếu cần xem chi tiết 1 đơn hàng cụ thể)
        return null; 
    }
}
