package com.healthlife.dao;

import com.healthlife.dao.interfaces.IDonHangDAO;
import com.healthlife.db.DBContext;
import com.healthlife.model.ChiTietDonHang;
import com.healthlife.model.DonHang;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DonHangDAO implements IDonHangDAO {

   

    @Override
    public List<DonHang> getAllOrders() {
        List<DonHang> list = new ArrayList<>();
        String query = "SELECT * FROM don_hang ORDER BY ngay_dat DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToOrder(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public DonHang getOrderById(int id) {
        String query = "SELECT * FROM don_hang WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToOrder(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<ChiTietDonHang> getOrderDetails(int orderId) {
        List<ChiTietDonHang> list = new ArrayList<>();
        // JOIN bảng san_pham để lấy tên và ảnh
        // (Giả sử bảng san_pham có cột 'ten_san_pham' và 'hinh_anh_dai_dien')
        String query = "SELECT c.*, p.ten_san_pham, p.hinh_anh_dai_dien " +
                       "FROM chi_tiet_don_hang c " +
                       "JOIN san_pham p ON c.id_san_pham = p.id " +
                       "WHERE c.id_don_hang = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ChiTietDonHang detail = new ChiTietDonHang();
                    detail.setId(rs.getInt("id"));
                    detail.setIdDonHang(rs.getInt("id_don_hang"));
                    detail.setIdSanPham(rs.getInt("id_san_pham"));
                    detail.setSoLuong(rs.getInt("so_luong"));
                    detail.setGiaLucMua(rs.getBigDecimal("gia_luc_mua"));
                    detail.setThanhTien(rs.getBigDecimal("thanh_tien"));
                    
                    // Map thông tin từ bảng sản phẩm
                    detail.setTenSanPham(rs.getString("ten_san_pham"));
                    detail.setHinhAnhSanPham(rs.getString("hinh_anh_dai_dien"));
                    
                    list.add(detail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        String query = "UPDATE don_hang SET trang_thai_don_hang = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean updatePaymentStatus(int orderId, String paymentStatus) {
        String query = "UPDATE don_hang SET trang_thai_thanh_toan = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, paymentStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Hàm map dữ liệu từ ResultSet vào Model DonHang
    private DonHang mapResultSetToOrder(ResultSet rs) throws SQLException {
        DonHang dh = new DonHang();
        dh.setId(rs.getInt("id"));
        dh.setIdNguoiDung(rs.getInt("id_nguoi_dung"));
        dh.setMaDonHang(rs.getString("ma_don_hang"));
        dh.setTenNguoiNhan(rs.getString("ten_nguoi_nhan"));
        dh.setSdtNhan(rs.getString("so_dien_thoai_nhan"));
        dh.setDiaChiGiaoHang(rs.getString("dia_chi_giao_hang"));
        dh.setEmailNguoiNhan(rs.getString("email_nguoi_nhan"));
        dh.setNgayDat(rs.getTimestamp("ngay_dat"));
        dh.setTongTienSanPham(rs.getBigDecimal("tong_tien_san_pham"));
        dh.setPhiVanChuyen(rs.getBigDecimal("phi_van_chuyen"));
        dh.setTongThanhToan(rs.getBigDecimal("tong_thanh_toan"));
        dh.setPhuongThucThanhToan(rs.getString("phuong_thuc_thanh_toan"));
        dh.setTrangThaiThanhToan(rs.getString("trang_thai_thanh_toan"));
        dh.setTrangThaiDonHang(rs.getString("trang_thai_don_hang"));
        dh.setGhiChu(rs.getString("ghi_chu_khach_hang"));
        return dh;
    }
}