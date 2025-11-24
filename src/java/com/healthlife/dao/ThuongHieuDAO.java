package com.healthlife.dao;

import com.healthlife.dao.interfaces.IThuongHieuDAO;
import com.healthlife.db.DBContext;
import com.healthlife.model.ThuongHieu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Triển khai logic CSDL cho bảng 'thuong_hieu'.
 */
public class ThuongHieuDAO implements IThuongHieuDAO {
    
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    @Override
    public List<ThuongHieu> getAll() {
        List<ThuongHieu> list = new ArrayList<>();
        String query = "SELECT * FROM thuong_hieu";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ThuongHieu(
                        rs.getInt("id"),
                        rs.getString("ten_thuong_hieu"),
                        rs.getString("xuat_xu"),
                        rs.getString("hinh_anh_logo"),
                        rs.getString("mo_ta")
                ));
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy danh sách thương hiệu: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    @Override
    public ThuongHieu getById(int id) {
        String query = "SELECT * FROM thuong_hieu WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new ThuongHieu(
                        rs.getInt("id"),
                        rs.getString("ten_thuong_hieu"),
                        rs.getString("xuat_xu"),
                        rs.getString("hinh_anh_logo"),
                        rs.getString("mo_ta")
                );
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy thương hiệu theo ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    @Override
    public boolean add(ThuongHieu th) {
        String query = "INSERT INTO thuong_hieu (ten_thuong_hieu, xuat_xu, mo_ta, hinh_anh_logo) VALUES (?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, th.getTenThuongHieu());
            ps.setString(2, th.getXuatXu());
            ps.setString(3, th.getMoTa());
            ps.setString(4, th.getHinhAnhLogo()); // Tạm thời
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi thêm thương hiệu: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    @Override
    public boolean update(ThuongHieu th) {
        String query = "UPDATE thuong_hieu SET ten_thuong_hieu = ?, xuat_xu = ?, mo_ta = ?, hinh_anh_logo = ? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, th.getTenThuongHieu());
            ps.setString(2, th.getXuatXu());
            ps.setString(3, th.getMoTa());
            ps.setString(4, th.getHinhAnhLogo()); // Tạm thời
            ps.setInt(5, th.getId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi cập nhật thương hiệu: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    @Override
    public boolean delete(int id) {
        String query = "DELETE FROM thuong_hieu WHERE id = ?";
        try {
             conn = new DBContext().getConnection();
             ps = conn.prepareStatement(query);
             ps.setInt(1, id);
             return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa thương hiệu: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }
    
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            // Bỏ qua lỗi khi đóng
        }
    }
}