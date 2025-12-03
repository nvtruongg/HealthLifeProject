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
        try {
        // Lấy tên danh mục dựa trên kết quả JOIN
        sp.setTenDanhMuc(rs.getString("ten_danh_muc"));
    } catch (SQLException e) {
        // Bỏ qua nếu cột không tồn tại (để tránh lỗi ở các hàm khác không dùng JOIN)
    }
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
        return filterProducts(null, null, null, null);
    }
    //Lấy sản phẩm theo ID Danh Mục - Giữ nguyên
    @Override
    public List<SanPham> getProductsByCategoryID(String categoryId) {
        return filterProducts(categoryId, null, null, null);
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

    @Override
    public boolean addProduct(SanPham sp) {
         String query = "INSERT INTO san_pham (ma_san_pham, ten_san_pham, id_danh_muc, id_thuong_hieu, " +
                       "gia_goc, gia_ban, so_luong_ton, don_vi_tinh, trang_thai, mo_ta_ngan, mo_ta_chi_tiet, " +
                       "thanh_phan, cong_dung, lieu_dung_cach_dung, bao_quan, hinh_anh_dai_dien) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, sp.getMaSanPham());
            ps.setString(2, sp.getTenSanPham());
            ps.setInt(3, sp.getIdDanhMuc());
            ps.setInt(4, sp.getIdThuongHieu());
            ps.setBigDecimal(5, sp.getGiaGoc());
            ps.setBigDecimal(6, sp.getGiaBan());
            ps.setInt(7, sp.getSoLuongTon());
            ps.setString(8, sp.getDonViTinh());
            ps.setString(9, sp.getTrangThai());
            ps.setString(10, sp.getMoTaNgan());
            ps.setString(11, sp.getMoTaChiTiet());
            ps.setString(12, sp.getThanhPhan());
            ps.setString(13, sp.getCongDung());
            ps.setString(14, sp.getLieuDungCachDung());
            ps.setString(15, sp.getBaoQuan());
            ps.setString(16, sp.getHinhAnhDaiDien());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateProduct(SanPham sp) {
        String query = "UPDATE san_pham SET ma_san_pham=?, ten_san_pham=?, id_danh_muc=?, id_thuong_hieu=?, " +
                       "gia_goc=?, gia_ban=?, so_luong_ton=?, don_vi_tinh=?, trang_thai=?, " +
                       "mo_ta_ngan=?, mo_ta_chi_tiet=?, thanh_phan=?, cong_dung=?, lieu_dung_cach_dung=?, " +
                       "bao_quan=?, hinh_anh_dai_dien=? WHERE id=?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, sp.getMaSanPham());
            ps.setString(2, sp.getTenSanPham());
            ps.setInt(3, sp.getIdDanhMuc());
            ps.setInt(4, sp.getIdThuongHieu());
            ps.setBigDecimal(5, sp.getGiaGoc());
            ps.setBigDecimal(6, sp.getGiaBan());
            ps.setInt(7, sp.getSoLuongTon());
            ps.setString(8, sp.getDonViTinh());
            ps.setString(9, sp.getTrangThai());
            ps.setString(10, sp.getMoTaNgan());
            ps.setString(11, sp.getMoTaChiTiet());
            ps.setString(12, sp.getThanhPhan());
            ps.setString(13, sp.getCongDung());
            ps.setString(14, sp.getLieuDungCachDung());
            ps.setString(15, sp.getBaoQuan());
            ps.setString(16, sp.getHinhAnhDaiDien()); // Cập nhật ảnh (nếu có logic xử lý ảnh)
            ps.setInt(17, sp.getId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteProduct(int id) {
        String query = "DELETE FROM san_pham WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<SanPham> filterProducts(String categoryId, String brandId, String priceRange, String sortType) {
        List<SanPham> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        
        // 1. Câu truy vấn cơ bản
        StringBuilder sql = new StringBuilder("SELECT p.*, d.ten_danh_muc FROM san_pham p ");
        sql.append("LEFT JOIN danh_muc d ON p.id_danh_muc = d.id ");
        sql.append("WHERE p.trang_thai = 'dang_kinh_doanh' ");

        // 2. Điều kiện Danh mục (Cha hoặc Con)
        if (categoryId != null && !categoryId.isEmpty()) {
            sql.append("AND (d.id = ? OR d.id_danh_muc_cha = ?) ");
            params.add(categoryId);
            params.add(categoryId);
        }

        // 3. Điều kiện Thương hiệu
        if (brandId != null && !brandId.isEmpty()) {
            sql.append("AND p.id_thuong_hieu = ? ");
            params.add(brandId);
        }

        // 4. Điều kiện Giá
        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.equals("500000-max")) {
                sql.append("AND p.gia_ban >= 500000 ");
            } else if (priceRange.contains("-")) {
                String[] parts = priceRange.split("-");
                if (parts.length == 2) {
                    sql.append("AND p.gia_ban BETWEEN ? AND ? ");
                    params.add(parts[0]);
                    params.add(parts[1]);
                }
            }
        }

        // 5. Sắp xếp
        if (sortType != null) {
            switch (sortType) {
                case "asc": sql.append("ORDER BY p.gia_ban ASC "); break;
                case "desc": sql.append("ORDER BY p.gia_ban DESC "); break;
                default: sql.append("ORDER BY p.id DESC "); break; // Mặc định mới nhất
            }
        } else {
            sql.append("ORDER BY p.id DESC ");
        }

        // --- IN LOG ĐỂ KIỂM TRA ---
        System.out.println("DEBUG SQL: " + sql.toString());
        System.out.println("DEBUG PARAMS: " + params);
        // --------------------------
        // 6. Thực thi truy vấn
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            // Gán tham số động
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToSanPham(rs));
            }
        } catch (Exception e) {
            System.out.println("LỖI SQL FILTER: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
}