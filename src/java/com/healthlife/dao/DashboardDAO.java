package com.healthlife.dao;

import com.healthlife.db.DBContext;
import com.healthlife.dto.ThongKeDTO;
import com.healthlife.dto.TopSanPhamDTO;
import com.healthlife.model.DonHang;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {

    // 1. Tổng doanh thu (chỉ tính đơn đã giao thành công 'hoan_thanh')
    public double getTotalRevenue() {
        // Đã đổi 'da_giao' -> 'hoan_thanh'
        String sql = "SELECT SUM(tong_thanh_toan) FROM don_hang WHERE trang_thai_don_hang = 'hoan_thanh'";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 2. Tổng số đơn hàng
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM don_hang";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 3. Tổng số khách hàng
    public int getTotalCustomers() {
        String sql = "SELECT COUNT(*) FROM nguoi_dung WHERE vai_tro = 'khach_hang'";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    // 4. Tổng số sản phẩm
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM san_pham WHERE trang_thai = 'dang_kinh_doanh'";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 5. Thống kê doanh thu 6 tháng gần nhất (Cho biểu đồ đường)
    public List<ThongKeDTO> getRevenueLast6Months() {
        List<ThongKeDTO> list = new ArrayList<>();
        // Đã đổi 'da_giao' -> 'hoan_thanh'
        String sql = "SELECT DATE_FORMAT(ngay_dat, '%m/%Y') as thang, SUM(tong_thanh_toan) as doanh_thu " +
                     "FROM don_hang " +
                     "WHERE trang_thai_don_hang = 'hoan_thanh' " +
                     "AND ngay_dat >= DATE_SUB(NOW(), INTERVAL 6 MONTH) " +
                     "GROUP BY DATE_FORMAT(ngay_dat, '%m/%Y'), YEAR(ngay_dat), MONTH(ngay_dat) " +
                     "ORDER BY YEAR(ngay_dat) ASC, MONTH(ngay_dat) ASC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ThongKeDTO(rs.getString("thang"), rs.getDouble("doanh_thu")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 6. Thống kê trạng thái đơn hàng (Cho biểu đồ tròn)
    public List<ThongKeDTO> getOrderStatusStats() {
        List<ThongKeDTO> list = new ArrayList<>();
        String sql = "SELECT trang_thai_don_hang, COUNT(*) as so_luong FROM don_hang GROUP BY trang_thai_don_hang";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ThongKeDTO(rs.getString("trang_thai_don_hang"), rs.getDouble("so_luong")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 7. Top 5 Sản phẩm bán chạy (Quan trọng: Cần bảng chi_tiet_don_hang)
    public List<TopSanPhamDTO> getTopSellingProducts() {
        List<TopSanPhamDTO> list = new ArrayList<>();
        // Đã đổi 'da_giao' -> 'hoan_thanh'
        String sql = "SELECT sp.ten_san_pham, SUM(ct.so_luong) as tong_ban, SUM(ct.thanh_tien) as tong_tien " +
                     "FROM chi_tiet_don_hang ct " +
                     "JOIN san_pham sp ON ct.id_san_pham = sp.id " +
                     "JOIN don_hang dh ON ct.id_don_hang = dh.id " +
                     "WHERE dh.trang_thai_don_hang = 'hoan_thanh' " +
                     "GROUP BY sp.id, sp.ten_san_pham " +
                     "ORDER BY tong_ban DESC LIMIT 5";
                     
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new TopSanPhamDTO(
                    rs.getString("ten_san_pham"),
                    rs.getInt("tong_ban"),
                    rs.getDouble("tong_tien")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 8. 5 Đơn hàng gần nhất
    public List<DonHang> getRecentOrders() {
        List<DonHang> list = new ArrayList<>();
        String sql = "SELECT * FROM don_hang ORDER BY ngay_dat DESC LIMIT 5";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DonHang dh = new DonHang();
                dh.setId(rs.getInt("id"));
                dh.setMaDonHang(rs.getString("ma_don_hang"));
                dh.setTenNguoiNhan(rs.getString("ten_nguoi_nhan"));
                dh.setTongThanhToan(rs.getBigDecimal("tong_thanh_toan"));
                dh.setTrangThaiDonHang(rs.getString("trang_thai_don_hang"));
                dh.setNgayDat(rs.getTimestamp("ngay_dat"));
                list.add(dh);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}