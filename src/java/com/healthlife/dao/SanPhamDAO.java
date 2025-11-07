/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.dao;
import com.healthlife.dao.interfaces.ISanPhamDAO;
import com.healthlife.db.DBContext;
import com.healthlife.model.SanPham;
import java.sql.PreparedStatement;
import java.sql.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Nguyen Viet Truong
 */
public class SanPhamDAO implements ISanPhamDAO{
    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection connection = null;
    // Hàm private để ánh xạ ResultSet sang đối tượng SanPham (Tránh lặp code) - Giữ nguyên như trước
    private SanPham mapResultSetToSanPham(ResultSet rs) throws SQLException {
        SanPham sp = new SanPham();
        sp.setId(rs.getInt("id"));
        sp.setMaSanPham(rs.getString("ma_san_pham"));
        sp.setTenSanPham(rs.getString("ten_san_pham"));
        sp.setIdDanhMuc(rs.getInt("id_danh_muc"));
        sp.setIdThuongHieu(rs.getInt("id_thuong_hieu"));
        sp.setGiaGoc(rs.getBigDecimal("gia_goc"));
        sp.setGiaBan(rs.getBigDecimal("gia_ban"));
        sp.setSoLuongTon(rs.getInt("so_luong_ton"));
        sp.setDonViTinh(rs.getString("don_vi_tinh"));
        sp.setHinhAnhDaiDien(rs.getString("hinh_anh_dai_dien"));
        sp.setMoTaNgan(rs.getString("mo_ta_ngan"));
        sp.setMoTaChiTiet(rs.getString("mo_ta_chi_tiet"));
        sp.setThanhPhan(rs.getString("thanh_phan"));
        sp.setCongDung(rs.getString("cong_dung"));
        sp.setLieuDungCachDung(rs.getString("lieu_dung_cach_dung"));
        sp.setBaoQuan(rs.getString("bao_quan"));
        sp.setTrangThai(rs.getString("trang_thai"));
        sp.setNgayTao(rs.getTimestamp("ngay_tao"));
        sp.setNgayCapNhat(rs.getTimestamp("ngay_cap_nhat"));
        return sp;
    }
    //Lấy tất cả sản phẩm đang kinh doanh - Giữ nguyên
    @Override
    public List<SanPham> getAllProducts() {
        List<SanPham> list = new ArrayList<>();
        String query = "SELECT * FROM san_pham WHERE trang_thai = 'dang_kinh_doanh'";
       
        try {
            connection = DBContext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToSanPham(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
    //Lấy sản phẩm theo ID Danh Mục - Giữ nguyên
    @Override
    public List<SanPham> getProductsByCategoryID(String categoryId) {
        List<SanPham> list = new ArrayList<>();
        String query = "SELECT * FROM san_pham WHERE id_danh_muc = ? AND trang_thai = 'dang_kinh_doanh'";
       
        try {
            connection = DBContext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, categoryId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToSanPham(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
    // Lấy sản phẩm theo ID - Giữ nguyên
    @Override
    public SanPham getProductById(int id) {
        SanPham sp = null;
        String query = "SELECT * FROM san_pham WHERE id = ? AND trang_thai = 'dang_kinh_doanh'";
        try {
            connection = DBContext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                sp = mapResultSetToSanPham(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return sp;
    }
    // Tìm kiếm sản phẩm theo tên (thêm mới)
    @Override
    public List<SanPham> searchProductsByName(String keyword) {
        List<SanPham> list = new ArrayList<>();
        String query = "SELECT * FROM san_pham WHERE ten_san_pham LIKE ? AND trang_thai = 'dang_kinh_doanh'";
       
        try {
            connection = DBContext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");  // Tìm gần đúng
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToSanPham(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
    // Hàm helper để đóng các kết nối - Giữ nguyên
    private void closeConnections() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}